import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/providers/valija_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:intl/intl.dart';

class ValijaView extends StatefulWidget {
  const ValijaView({super.key});

  @override
  State<ValijaView> createState() => _ValijaViewState();
}

class _ValijaViewState extends State<ValijaView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ValijaProvider>().loadValijas();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('d \'de\' MMMM \'del\' yyyy, HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  List<Valija> filteredValijas() {
    final valijas = context.watch<ValijaProvider>().valijas;
    if (_searchQuery.isEmpty) return valijas;

    return valijas.where((valija) {
      String code = valija.codigo?.toLowerCase() ?? '';
      String seller = valija.vendedor?.toLowerCase() ?? '';
      return code.contains(_searchQuery) || seller.contains(_searchQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final valijaProvider = context.watch<ValijaProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Valija",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                const SizedBox(width: 4),
                Text("Hoy ${DateFormat('hh:mm a').format(DateTime.now())}",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
              ],
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
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
                hintText: 'Buscar valija',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 16),
            // New Bag Button
            GestureDetector(
              onTap: () {
                // TODO: Implementar creación de nueva valija
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '+ Nueva valija',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Cards List
            Expanded(
              child: valijaProvider.isLoading && valijaProvider.valijas.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : filteredValijas().isEmpty
                      ? Center(
                          child: Text(
                            'No hay valijas disponibles',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredValijas().length,
                          itemBuilder: (context, index) {
                            final valija = filteredValijas()[index];
                            return Card(
                              color: Colors.white,
                              elevation: 1,
                              margin: const EdgeInsets.only(bottom: 12),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/icons/mingcute_suitcase-2-fill.png',
                                        width: 24, height: 24),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "VALIJA",
                                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                                  color: AppTheme.greyColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "#-V${valija.codigo}",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            valija.vendedor ?? 'Sin vendedor',
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _formatDate(valija.createdAt?.toIso8601String()),
                                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                                  color: AppTheme.greyColor,
                                                ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            "TOTAL",
                                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                                  color: AppTheme.greyColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            "\$${valija.monto?.toStringAsFixed(2) ?? '0.00'}",
                                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: valija.estatus == 'Pendiente'
                                            ? Colors.red[100]
                                            : Colors.green[100],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        valija.estatus ?? 'Pendiente',
                                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: valija.estatus == 'Pendiente'
                                                ? Colors.red
                                                : Colors.green,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
