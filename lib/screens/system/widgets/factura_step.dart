import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/providers/bill_selection_provider.dart';
import 'package:syncman_new/providers/selected_client_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/screens/system/widgets/detail_row.dart';

class FacturaStep extends StatelessWidget {
  final List<String> selectedFacturas;
  final String? selectedTipo;
  final String? selectedCurrencyName;
  final VoidCallback onFacturaTap;
  final VoidCallback onTipoTap;
  final VoidCallback onCurrencyTap;

  const FacturaStep({
    super.key,
    required this.selectedFacturas,
    required this.selectedTipo,
    required this.selectedCurrencyName,
    required this.onFacturaTap,
    required this.onTipoTap,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<SelectedClientProvider>(
            builder: (context, selectedClient, child) {
              return Card(
                color: AppTheme.greyBackground,
                elevation: 0,
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.greyBackground,
                    child: Icon(Icons.person, size: 24, color: AppTheme.greyColor),
                  ),
                  title: Text(
                    '${selectedClient.clientName ?? 'Cliente no seleccionado'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.greyColor,
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${selectedClient.clientCompany ?? 'No especificada'}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: AppTheme.greyColor,
                            ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 10),
          Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Detalles',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppTheme.greyColor,
                        ),
                  ),
                  const Divider(),
                  DetailRow(
                    label: 'Facturas',
                    value: selectedFacturas.isNotEmpty
                        ? selectedFacturas.join(', ')
                        : 'Seleccionar...',
                    isDropdown: true,
                    onTap: onFacturaTap,
                  ),
                  DetailRow(
                    label: 'Tipo',
                    value: selectedTipo ?? 'Seleccionar...',
                    isDropdown: true,
                    onTap: onTipoTap,
                  ),
                  DetailRow(
                    label: 'Moneda',
                    value: selectedCurrencyName ?? 'Seleccionar...',
                    isDropdown: true,
                    onTap: onCurrencyTap,
                  ),
                  DetailRow(label: 'Tasa', value: ''),
                  DetailRow(label: 'Tasa IVA', value: ''),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Facturas',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '\$280,90',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryColor,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 