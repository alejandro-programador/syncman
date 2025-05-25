import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/providers/seller_provider.dart';
import 'package:syncman_new/theme/theme.dart';

class SellerDetailView extends StatefulWidget {
  final String sellerDNI;

  const SellerDetailView({super.key, required this.sellerDNI});

  @override
  State<SellerDetailView> createState() => _SellerDetailViewState();
}

class _SellerDetailViewState extends State<SellerDetailView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SellersProvider>().fetchSellerData(widget.sellerDNI);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sellersProvider = context.watch<SellersProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.menu, color: Colors.black),
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const MenuView()),
        //     );
        //   },
        // ),
        title: Text(
          "Detalle de vendedor",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: sellersProvider.isLoading
          ? const Expanded(
              child: Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primaryColor,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 8),
                  SellerDetailCard(
                      title: 'DESCRIPCION',
                      description: sellersProvider.sellerProfile['descripcion']),
                  SellerDetailCard(
                      title: 'CÉDULA', description: sellersProvider.sellerProfile['cedula']),
                  SellerDetailCard(
                      title: 'TELÉFONOS', description: sellersProvider.sellerProfile['telefonos']),
                  SellerDetailCard(
                      title: 'SALDOCXC',
                      description: '\$${sellersProvider.sellerProfile['saldoCXC'].toString()}'),
                  SellerDetailCard(
                      title: 'SALDO DEUDOR',
                      description: '\$${sellersProvider.sellerProfile['saldo_deudor'].toString()}'),
                  SellerDetailCard(
                      title: 'SALDO TOTAL',
                      description:
                          '\$${sellersProvider.sellerProfile['saldo_deudor_total'].toString()}'),
                ],
              ),
            ),
    );
  }
}

class SellerDetailCard extends StatelessWidget {
  final String title;
  final String description;

  const SellerDetailCard({
    required this.title,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Flexible Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.labelSmall
                            ?.copyWith(color: Colors.grey, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
