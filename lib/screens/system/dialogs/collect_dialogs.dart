import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/providers/bill_selection_provider.dart';
import 'package:syncman_new/providers/payment_method_provider.dart';
import 'package:syncman_new/theme/theme.dart';

class CollectDialogs {
  static Future<List<String>?> showFacturaDropdown(
    BuildContext context,
    String? clientId,
    BillSelectionProvider billSelectionProvider,
  ) async {
    if (clientId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No se ha especificado un cliente'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }

    return showDialog<List<String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Facturas',
              style: Theme.of(context).textTheme.bodySmall),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Container(
                width: double.maxFinite,
                constraints: const BoxConstraints(maxHeight: 400),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (billSelectionProvider.clientBills.isEmpty)
                      Text('No hay facturas disponibles',
                          style: Theme.of(context).textTheme.bodySmall)
                    else
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: billSelectionProvider.clientBills.length,
                          itemBuilder: (context, index) {
                            final bill = billSelectionProvider.clientBills[index];
                            final isSelected = billSelectionProvider.selectedFacturas.contains(bill.codigo);

                            return ListTile(
                              dense: true,
                              title: Text(
                                '#${bill.codigo}',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              trailing: Checkbox(
                                value: isSelected,
                                onChanged: (checked) {
                                  setState(() {
                                    if (checked == true) {
                                      billSelectionProvider.setSelectedFacturas(
                                        [...billSelectionProvider.selectedFacturas, bill.codigo]
                                      );
                                    } else {
                                      billSelectionProvider.setSelectedFacturas(
                                        billSelectionProvider.selectedFacturas
                                            .where((code) => code != bill.codigo)
                                            .toList()
                                      );
                                    }
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, billSelectionProvider.selectedFacturas),
              child: Text('Aceptar',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  static Future<Currency?> showCurrencyDropdown(
    BuildContext context,
    List<Currency> currencies,
    BillSelectionProvider billSelectionProvider,
  ) async {
    if (currencies.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay monedas disponibles'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }

    return showDialog<Currency>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Moneda',
              style: Theme.of(context).textTheme.bodySmall),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 400),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: currencies.length,
              itemBuilder: (context, index) {
                final currency = currencies[index];
                final isSelected = billSelectionProvider.selectedCurrency?.id == currency.id;
                return ListTile(
                  title: Text(currency.nombre ?? ''),
                  subtitle: Text(currency.codigo ?? ''),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () => Navigator.pop(context, currency),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        );
      },
    );
  }

  static Future<CollectPaymentMethod?> showPaymentMethodDropdown(
    BuildContext context,
    PaymentMethodProvider provider,
  ) async {
    if (provider.paymentMethods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No hay métodos de pago disponibles'),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }

    return showDialog<CollectPaymentMethod>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Método de Pago',
              style: Theme.of(context).textTheme.bodySmall),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 400),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.paymentMethods.length,
              itemBuilder: (context, index) {
                final paymentMethod = provider.paymentMethods[index];
                final isSelected = provider.selectedPaymentMethod?.id == paymentMethod.id;
                return ListTile(
                  title: Text(paymentMethod.descripcion ?? ''),
                  subtitle: Text(paymentMethod.cuenta == true ? 'Requiere cuenta' : 'No requiere cuenta'),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () => Navigator.pop(context, paymentMethod),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        );
      },
    );
  }

  static Future<String?> showTipoDropdown(
    BuildContext context,
    List<String> tipos,
    String? selectedTipo,
  ) async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Seleccionar Tipo',
              style: Theme.of(context).textTheme.bodySmall),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 400),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: tipos.length,
              itemBuilder: (context, index) {
                final tipo = tipos[index];
                final isSelected = selectedTipo == tipo;
                return ListTile(
                  title: Text(tipo),
                  trailing: isSelected ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: () => Navigator.pop(context, tipo),
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar',
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        );
      },
    );
  }
} 