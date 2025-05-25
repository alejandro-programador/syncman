import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/notification.dart';

class ValijaReportView extends StatefulWidget {
  const ValijaReportView({super.key});

  @override
  ValijaReportViewState createState() => ValijaReportViewState();
}

class ValijaReportViewState extends State<ValijaReportView> {
  String selectedStatus = "Todos";
  bool isDropdownOpen = false;
  DateTime selectedDate = DateTime.now();

  List<String> statuses = [
    "Todos",
    "Depositado",
    "Pendiente",
    "Aprobado",
    "Rechazado",
    "Procesado",
    "Finalizado"
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
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
            Text("Reporte de valija", style: TextStyle(fontSize: 18)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDatePicker("Fecha I", context),
                    _buildDatePicker("Fecha F", context),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDropdownOpen = !isDropdownOpen;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Estatus",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium
                                    ?.copyWith(fontWeight: FontWeight.w600)),
                            Text(
                              selectedStatus,
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppTheme.greyColor, fontWeight: FontWeight.w700),
                            ),
                            Icon(
                              isDropdownOpen ? Icons.expand_more : Icons.chevron_right,
                              color: AppTheme.greyColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isDropdownOpen)
                      Column(
                        children: statuses.map((status) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStatus = status;
                                isDropdownOpen = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(14),
                              color: selectedStatus == status ? Colors.blue.shade100 : Colors.white,
                              child: Row(
                                children: [
                                  Text(
                                    status,
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        color: selectedStatus == status
                                            ? Colors.blue
                                            : AppTheme.greyColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.valijaReportList);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Buscar",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(String label, BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              DateFormat('dd/MM/yyyy').format(selectedDate),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppTheme.greyColor),
            ),
            const Icon(Icons.chevron_right, color: AppTheme.greyColor, size: 24),
          ],
        ),
      ),
    );
  }
}
