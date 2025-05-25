import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/providers/return_record_provider.dart';
import 'package:syncman_new/providers/seller_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/menu.dart';
import 'package:syncman_new/widgets/notification.dart';

class RefundView extends StatefulWidget {
  const RefundView({super.key});

  @override
  State<RefundView> createState() => _RefundViewState();
}

class _RefundViewState extends State<RefundView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReturnRecordProvider>().loadReturnRecords();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
            Text("Devolución", style: TextStyle(fontSize: 18)),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) {
                // TODO: Implement search functionality
              },
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, size: 18),
                hintText: 'Buscar devolución',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.greyColor,
                    ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // TODO: Navigate to new refund form
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      '+ Nueva devolución',
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
            Expanded(
              child: Consumer<ReturnRecordProvider>(
                builder: (context, returnRecordProvider, child) {
                  if (returnRecordProvider.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                      ),
                    );
                  }

                  final returnRecords = returnRecordProvider.returnRecords;

                  if (returnRecords.isEmpty) {
                    return const Center(
                      child: Text('No hay devoluciones disponibles'),
                    );
                  }

                  return ListView.builder(
                    itemCount: returnRecords.length,
                    itemBuilder: (context, index) {
                      final returnRecord = returnRecords[index];
                      return _buildReturnRecordCard(context, returnRecord);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnRecordCard(BuildContext context, ReturnRecord returnRecord) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: Colors.white,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Image.asset(
                        'assets/icons/illustration.png',
                        width: 24,
                        height: 24,
                      )
                    ],
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DEVOLUCIÓN',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppTheme.greyColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '#${returnRecord.codigo}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Text(
                          returnRecord.descripcion,
                          style: Theme.of(context).textTheme.labelMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: returnRecord.estatus == 'Pendiente' ? Colors.red[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      returnRecord.estatus,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: returnRecord.estatus == 'Pendiente' ? Colors.red : Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: AppTheme.greyBackground,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        returnRecord.motivo,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        returnRecord.desMotivo,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '\$${returnRecord.total}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fecha',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.greyColor,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.greyColor,
                            ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        returnRecord.createdAt.toString(),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                              color: AppTheme.greyColor,
                            ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        '\$${returnRecord.total}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.primaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
