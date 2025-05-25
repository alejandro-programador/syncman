import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class ProductDetailView extends StatelessWidget {
  const ProductDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          "Artículos",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  'assets/images/product.png',
                  width: 240,
                  height: 240,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Image Selection
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2), // Border color & thickness
                      borderRadius: BorderRadius.circular(8), // Optional: Round corners
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue, size: 24),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2), // Border color & thickness
                      borderRadius: BorderRadius.circular(8), // Optional: Round corners
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.image, color: Colors.blue, size: 24),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Product Info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'DT13-TC114',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.greyColor),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Abrazadera EMT 1 ACT',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Marca',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTheme.greyColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Pricing and Stock
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      color: Colors.white,
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'UNIDAD',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600, color: AppTheme.greyColor),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropdownButton<String>(
                                  value: 'US\$ 8,89 /01',
                                  items: [
                                    DropdownMenuItem(
                                      value: 'US\$ 8,89 /01',
                                      child: Text(
                                        'US\$ 8,89 /01',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                                const SizedBox(width: 8),
                                ChoiceChip(
                                  showCheckmark: false,
                                  color: WidgetStatePropertyAll(Colors.red[50]),
                                  label: Text("0",
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: Colors.red,
                                          )),
                                  selected: true,
                                  onSelected: (bool value) {},
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.transparent), // Elimina el borde
                                    borderRadius:
                                        BorderRadius.circular(8), // Opcional: Ajusta la forma
                                  ),
                                ),
                                // Text('0', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                            Text(
                              'PAQUETE',
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600, color: AppTheme.greyColor),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                DropdownButton<String>(
                                  value: 'US\$ 8,89 /01',
                                  items: [
                                    DropdownMenuItem(
                                      value: 'US\$ 8,89 /01',
                                      child: Text(
                                        'US\$ 8,89 /01',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.copyWith(fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                  onChanged: (value) {},
                                ),
                                const SizedBox(width: 8),
                                ChoiceChip(
                                  showCheckmark: false,
                                  color: WidgetStatePropertyAll(Colors.green[50]),
                                  label: Text("2400",
                                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                            color: Colors.green,
                                          )),
                                  selected: true,
                                  onSelected: (bool value) {},
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.transparent), // Elimina el borde
                                    borderRadius:
                                        BorderRadius.circular(8), // Opcional: Ajusta la forma
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Description Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: ExpansionTile(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide.none,
                  ),
                  title: Text('Descripción',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  initiallyExpanded: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                          'Praesent vehicula nisi vel massa tempor, a egestas lacus ultricies.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: AppTheme.greyColor)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset('assets/icons/mingcute_download-fill.png', width: 24, height: 24),
                  const SizedBox(width: 8),
                  Text('Adjuntos',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            // Attachments
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Colors.white,
                elevation: 0,
                child: ListTile(
                  leading: Image.asset('assets/icons/illus.png', width: 24, height: 24),
                  title: Text('Manual_2024.PDF',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  subtitle: Text('Noviembre 1, 2024 • 294kb',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppTheme.greyColor)),
                  // trailing: IconButton(
                  //   icon: Icon(Icons.download),
                  //   onPressed: () {},
                  // ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      size: 24,
                      color: AppTheme.greyColor,
                    ),
                  ),
                  Text(
                    "1",
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline,
                        size: 24, color: AppTheme.primaryColor),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Ajusta el radio aquí
                      ),
                    ),
                    onPressed: () {},
                    child: Text("/",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.primaryColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4), // Ajusta el radio aquí
                      ),
                    ),
                    onPressed: () {},
                    child: Text("Añadir",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(fontWeight: FontWeight.w600, color: AppTheme.primaryColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
