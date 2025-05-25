import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/client_card2.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/widgets/notification.dart';

class ClientsView extends StatefulWidget {
  const ClientsView({super.key});

  @override
  ClientsViewState createState() => ClientsViewState();
}

class ClientsViewState extends State<ClientsView> {
  int selectedCategory = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  // scroll
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientsProvider>().loadClients();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  List<Client> filteredClients() {
    final clients = context.watch<ClientsProvider>().clients;
    List<Client> filteredList;

    // Filtrar por categoría seleccionada
    switch (selectedCategory) {
      case 1: // Moroso
        filteredList = clients.where((client) => (client.saldo_deudor ?? 0) > 0).toList();
        break;
      case 2: // Al día
        filteredList = clients.where((client) => (client.saldo_deudor_total ?? 0) <= 0).toList();
        break;
      case 3: // CXC
        filteredList = clients
            .where((client) => (client.saldoCXC ?? 0) > 0 && (client.saldo_deudor ?? 0) <= 0)
            .toList();
        break;
      default: // Todos
        filteredList = clients;
    }

    // Aplicar búsqueda
    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((client) {
        String name = client.descripcion?.toLowerCase() ?? '';
        String code = client.codigo?.toLowerCase() ?? '';
        return name.contains(_searchQuery) || code.contains(_searchQuery);
      }).toList();
    }

    return filteredList;
  }

  @override
  Widget build(BuildContext context) {
    final clientsProvider = context.watch<ClientsProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Clientes", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                const SizedBox(width: 4),
                Text("Hoy 09:25 AM",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
              ],
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MenuView()),
            );
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png', width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: AppTheme.greyBackground,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, size: 18),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchQuery = "";
                              _searchController.clear();
                            });
                          },
                        )
                      : null,
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                  labelStyle: Theme.of(context).textTheme.bodySmall,
                  hintText: 'Buscar cliente',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChoiceChip(
                    showCheckmark: false,
                    backgroundColor:
                        selectedCategory == 0 ? AppTheme.primaryColor : Colors.transparent,
                    label: Text("Todos",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: selectedCategory == 0 ? Colors.black : AppTheme.greyColor,
                            )),
                    selected: selectedCategory == 0,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = 0;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent), // Elimina el borde
                      borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                    ),
                  ),
                  ChoiceChip(
                    backgroundColor:
                        selectedCategory == 1 ? AppTheme.primaryColor : Colors.transparent,
                    showCheckmark: false,
                    label: Text("Morosos",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: selectedCategory == 1 ? Colors.black : AppTheme.greyColor,
                            )),
                    selected: selectedCategory ==
                        1, // Asegúrate de que selectedCategory sea un valor entero
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = 1; // Esto debe ser un int, no un double
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  ChoiceChip(
                    showCheckmark: false,
                    backgroundColor:
                        selectedCategory == 2 ? AppTheme.primaryColor : Colors.transparent,
                    label: Text("Al día",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: selectedCategory == 2 ? Colors.black : AppTheme.greyColor,
                            )),
                    selected: selectedCategory ==
                        2, // Asegúrate de que selectedCategory sea un valor entero
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = 2; // Esto debe ser un int, no un double
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent), // Elimina el borde
                      borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                    ),
                  ),
                  ChoiceChip(
                    backgroundColor:
                        selectedCategory == 3 ? AppTheme.primaryColor : Colors.transparent,
                    showCheckmark: false,
                    label: Text("CXC",
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: selectedCategory == 3 ? Colors.black : AppTheme.greyColor,
                            )),
                    selected: selectedCategory ==
                        3, // Asegúrate de que selectedCategory sea un valor entero
                    onSelected: (bool selected) {
                      setState(() {
                        selectedCategory = 3; // Esto debe ser un int, no un double
                      });
                    },
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.transparent), // Elimina el borde
                      borderRadius: BorderRadius.circular(8), // Opcional: Ajusta la forma
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: clientsProvider.isLoading && clientsProvider.clients.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredClients().length,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      // itemCount: clientsProvider.clients.length +
                      //     (clientsProvider.isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < clientsProvider.clients.length) {
                          // final client = clientsProvider.clients[index];
                          final client = filteredClients()[index];
                          return ClientCard2(
                            title: client.codigo ?? "W-1467864",
                            description:
                                client.descripcion ?? "Centro Gastronómico Mister Chef C.A.",
                            subtitle: client.fechaReg ?? 'Última compra hace un mes',
                            saldocxc: "\$${client.saldoCXC ?? 0}",
                            saldodeudor: "\$${client.saldo_deudor ?? 0}",
                            saldototal: "\$${client.saldo_deudor_total ?? 0}",
                            isRecent: client.recent == 0,
                            daysAgo: client.date ?? "Hace dos días",
                            selectedCategory: selectedCategory,
                            clientId: client.id?.toString() ?? '',
                            clientContrib: (client.contrib ?? 0) != 0,
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
