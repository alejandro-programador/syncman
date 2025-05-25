import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/providers/payment_method_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/screens/system/widgets/text_field_row.dart';
import 'package:syncman_new/screens/system/widgets/deposito_field.dart';

class MetodoDePagoStep extends StatelessWidget {
  final List<Map<String, dynamic>> paymentMethods;
  final bool showSuccessMessage;
  final TextEditingController titularCuentaController;
  final TextEditingController titularRifController;
  final TextEditingController referenciaController;
  final TextEditingController fechaController;
  final TextEditingController cobroController;
  final TextEditingController baseController;
  final TextEditingController ivaController;
  final TextEditingController depositoController;
  final TextEditingController amountController;
  final TextEditingController descriptionController;
  final String? selectedTipo;
  final String? depositoError;
  final VoidCallback onAddPaymentMethod;
  final VoidCallback onPaymentMethodTap;

  const MetodoDePagoStep({
    super.key,
    required this.paymentMethods,
    required this.showSuccessMessage,
    required this.titularCuentaController,
    required this.titularRifController,
    required this.referenciaController,
    required this.fechaController,
    required this.cobroController,
    required this.baseController,
    required this.ivaController,
    required this.depositoController,
    required this.amountController,
    required this.descriptionController,
    required this.selectedTipo,
    required this.depositoError,
    required this.onAddPaymentMethod,
    required this.onPaymentMethodTap,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Mostrar métodos de pago guardados
          ...paymentMethods.map((method) => Card(
                color: AppTheme.greyBackground,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.greyBackground,
                    child: Image.asset('assets/icons/mingcute_bank-fill.png',
                        width: 24, height: 24),
                  ),
                  title: Text(
                    method['metodoPago'] ?? '',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.greyColor,
                        ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text.rich(
                          TextSpan(
                            text: 'Monto ',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.greyColor,
                                ),
                            children: [
                              TextSpan(
                                text: '\$${method['monto']}',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (method['referencia']?.isNotEmpty ?? false)
                        Text(
                          'Referencia #${method['referencia']}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTheme.greyColor),
                        ),
                    ],
                  ),
                ),
              )),

          // First Payment Method Dropdown
          Text(
            'Método de Pago',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.greyColor,
                ),
          ),
          Consumer<PaymentMethodProvider>(
            builder: (context, paymentMethodProvider, child) {
              return GestureDetector(
                onTap: onPaymentMethodTap,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppTheme.greyColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        paymentMethodProvider.selectedPaymentMethod?.descripcion ??
                            'Seleccionar...',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Row fields
          Consumer<PaymentMethodProvider>(
            builder: (context, paymentMethodProvider, child) {
              final selectedMethod = paymentMethodProvider.selectedPaymentMethod;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (selectedMethod?.cuenta == true) ...[
                    TextFieldRow(
                      label: "Titular de cuenta",
                      controller: titularCuentaController,
                    ),
                    TextFieldRow(
                      label: "Titular RIF",
                      controller: titularRifController,
                    ),
                    TextFieldRow(
                      label: "Referencia",
                      controller: referenciaController,
                    ),
                  ],
                  TextFieldRow(
                    label: "Fecha",
                    controller: fechaController,
                  ),
                  if (selectedTipo == "Base + IVA")
                    TextFieldRow(
                      label: "Cobro",
                      controller: cobroController,
                    ),
                  if (selectedTipo != "IVA")
                    TextFieldRow(
                      label: "Base",
                      controller: baseController,
                    ),
                  if (selectedTipo == "IVA" || selectedTipo == "Base + IVA")
                    TextFieldRow(
                      label: "IVA",
                      controller: ivaController,
                    ),
                  if (selectedTipo == "Base + IVA")
                    DepositoField(
                      controller: depositoController,
                      error: depositoError,
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),

          // Amount Field
          Text(
            'Monto',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          Container(
            color: Colors.white,
            child: TextField(
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Ingrese el monto',
                hintStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Add New Payment Method Button
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppTheme.primaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              onPressed: onAddPaymentMethod,
              child: Text(
                "+ Agregar nuevo método de pago",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryColor,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Description Field
          Text(
            'Descripción',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.greyColor,
                ),
          ),
          const SizedBox(height: 8),
          Container(
            color: Colors.white,
            child: TextField(
              style: Theme.of(context).textTheme.labelMedium,
              controller: descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Escriba una descripción',
                hintStyle: Theme.of(context).textTheme.labelMedium,
                labelStyle: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // REGISTRAR COBRO Section
          Text(
            'REGISTRAR COBRO',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.greyColor,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Selecciona hasta 4 imágenes .JPG o .PNG',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: AppTheme.greyColor),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/icons/add_image.png',
                      width: 24, height: 24),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/icons/add_image.png',
                      width: 24, height: 24),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
} 