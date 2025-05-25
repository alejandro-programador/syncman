import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/card_model.dart';
import 'package:syncman_new/widgets/notification.dart';

class OrderReportView extends StatefulWidget {
  const OrderReportView({super.key});

  @override
  OrderReportViewState createState() => OrderReportViewState();
}

class OrderReportViewState extends State<OrderReportView> {
  final TextEditingController _dateController = TextEditingController();

  final List<Map<String, String>> pedidos = List.generate(
    3,
    (index) => {
      "id": "W-1467864",
      "empresa": "Inversiones IDS C.A.",
      "cliente": "Pedro Perez",
      "total": "\$1.956,00",
      "articulos": "70",
      "fecha": "05/02/2025",
    },
  );

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Reporte de pedidos", style: TextStyle(fontSize: 18)),
          ],
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('BUSCAR REPORTE',
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextField(
                  controller: _dateController,
                  readOnly: true,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    labelText: "Fecha",
                    labelStyle: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Buscar",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontWeight: FontWeight.w700, color: Colors.white))),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pedidos.length,
              itemBuilder: (context, index) {
                final pedido = pedidos[index];
                return PedidoCard(pedido: pedido);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PedidoCard extends StatelessWidget {
  const PedidoCard({super.key, required this.pedido});

  final Map<String, String> pedido;

  @override
  Widget build(BuildContext context) {
    return const CardModel(
      miniTitle: "PEDIDO",
      title: "W-1467864",
      description: "Inversiones IDS",
      subtitle: 'Pedro Perez',
      amount: "\$1,956.00",
      articles: "70",
      isRecent: false,
      daysAgo: "Hace dos días",
      isOrderReport: true,
    );
  }
}
