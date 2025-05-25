import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class CartProduct extends StatefulWidget {
  final String productName;
  final String productCode;
  final String pricePerPackage;
  final String pricePerUnit;
  final int stock;
  final String category;
  final int taxRate;
  final double unitPrice;
  final List<dynamic> unidades;
  final VoidCallback onRemove;
  final Function(double) onPriceChanged;
  final Function(String) onUnitChanged;
  final Function(String) onCalculatedPriceChanged;

  const CartProduct(
      {super.key,
      required this.productName,
      required this.productCode,
      required this.pricePerPackage,
      required this.pricePerUnit,
      required this.stock,
      required this.category,
      required this.taxRate,
      required this.unitPrice,
      required this.unidades,
      required this.onRemove,
      required this.onPriceChanged,
      required this.onUnitChanged,
      required this.onCalculatedPriceChanged});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  late String selectedOption;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    // Inicializar selectedOption con la primera unidad disponible
    if (widget.unidades.isNotEmpty) {
      selectedOption = widget.unidades[0]['unidadName'] as String;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onUnitChanged(widget.unidades[0]['_id'] as String);
        widget.onPriceChanged(getCalculatedPrice());
        widget.onCalculatedPriceChanged(getCalculatedPrice().toStringAsFixed(2));
      });
    } else {
      selectedOption = 'Unidad';
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onUnitChanged('');
        widget.onPriceChanged(0);
        widget.onCalculatedPriceChanged("0.00");
      });
    }
  }

  @override
  void dispose() {
    widget.onPriceChanged(0); // Reset price when removed
    super.dispose();
  }

  double getCalculatedPrice() {
    final selectedUnit = widget.unidades.firstWhere(
      (unit) => unit['unidadName'] == selectedOption,
      orElse: () => {'equivalencia': 1},
    );
    final equivalence = (selectedUnit['equivalencia'] as num).toDouble();
    return widget.unitPrice * equivalence;
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;

    // Calcular la longitud máxima basada en el ancho de la pantalla
    int maxLength = screenWidth > 600
        ? 50
        : screenWidth > 400
            ? 40
            : screenWidth > 360
                ? 32
                : 24;

    String truncatedName = widget.productName.length > maxLength
        ? "${widget.productName.substring(0, maxLength)}..."
        : widget.productName;

    // Obtener las opciones de unidades sin duplicados
    Set<String> uniqueUnits = widget.unidades.map((unit) => unit['unidadName'] as String).toSet();
    List<String> unitOptions = uniqueUnits.toList();

    if (unitOptions.isEmpty) {
      unitOptions = ['Unidad']; // Valor por defecto si no hay unidades
    }

    // Asegurarse de que selectedOption esté en la lista de opciones
    if (!unitOptions.contains(selectedOption)) {
      selectedOption = unitOptions.first;
    }

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/product.png", width: 58, height: 46),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "/product-detail");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.productCode,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(color: AppTheme.greyColor),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        truncatedName,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        softWrap: true,
                      ),
                      Text(
                        widget.category,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
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
                    Text("Unid.",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Text(selectedOption,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
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
                    Text("Disponible",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(widget.stock.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.greenColor)),
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
                    Text("Precio",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppTheme.greyColor, fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(width: 32),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        getCalculatedPrice().toStringAsFixed(2),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
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
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (quantity > 1) quantity--;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    size: 24,
                    color: AppTheme.greyColor,
                  ),
                ),
                Text(
                  quantity.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  icon:
                      const Icon(Icons.add_circle_outline, size: 24, color: AppTheme.primaryColor),
                ),
                // const Spacer(),
                // OutlinedButton(
                //   style: OutlinedButton.styleFrom(
                //     side: const BorderSide(color: AppTheme.primaryColor),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: Text("/",
                //       style: Theme.of(context).textTheme.labelMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //           color: AppTheme.primaryColor)),
                // ),
                const SizedBox(
                  width: 8.0,
                ),
                DropdownButton<String>(
                  value: selectedOption,
                  icon: const Icon(Icons.arrow_drop_down, color: AppTheme.primaryColor),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primaryColor),
                  underline: Container(
                    height: 1,
                    color: AppTheme.primaryColor,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue!;
                      final selectedUnit = widget.unidades.firstWhere(
                        (unit) => unit['unidadName'] == newValue,
                        orElse: () => {'_id': ''},
                      );
                      widget.onUnitChanged(selectedUnit['_id'] as String);
                      final calculatedPrice = getCalculatedPrice();
                      widget.onPriceChanged(calculatedPrice);
                      widget.onCalculatedPriceChanged(calculatedPrice.toStringAsFixed(2));
                    });
                  },
                  items: widget.unidades.map<DropdownMenuItem<String>>((unit) {
                    return DropdownMenuItem<String>(
                      value: unit['unidadName'] as String,
                      child: Text(unit['unidadName'] as String),
                    );
                  }).toList(),
                ),
                // OutlinedButton(
                //   style: OutlinedButton.styleFrom(
                //     side: const BorderSide(color: AppTheme.primaryColor),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //   ),
                //   onPressed: () {},
                //   child: Text("Unidad",
                //       style: Theme.of(context).textTheme.labelMedium?.copyWith(
                //           fontWeight: FontWeight.w600,
                //           color: AppTheme.primaryColor)),
                // ),
                const SizedBox(
                  width: 16.0,
                ),
                GestureDetector(
                  onTap: widget.onRemove,
                  child: Image.asset('assets/icons/mynaui_trash-solid.png', width: 24, height: 24),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
