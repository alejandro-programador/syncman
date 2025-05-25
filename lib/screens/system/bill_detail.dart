import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/providers/bill_provider.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/network_utils.dart';
import 'package:syncman_new/widgets/bill_card_model.dart';
import 'package:syncman_new/widgets/notification.dart';

class BillDetailView extends StatefulWidget {
  final Bill bill;
  const BillDetailView({super.key, required this.bill});

  @override
  State<BillDetailView> createState() => _BillDetailViewState();
}

class _BillDetailViewState extends State<BillDetailView> {
  late StreamSubscription<bool> _connectivitySubscription;
  bool _isOnline = false;

  void initConnectivity() {
    NetworkUtils.startConnectivityCheck();
    _connectivitySubscription = NetworkUtils.onConnectivityChanged.listen((isOnline) {
      setState(() {
        _isOnline = isOnline;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final priceProvider = Provider.of<PriceProvider>(context, listen: false);
      // context.read<ArticleProvider>().fetchArticles(context, priceProvider);
    });
    initConnectivity();
  }

  List<dynamic> filteredArticles() {
    // final articles = context.watch<ArticleProvider>().articles;
    // final List<dynamic> renglones = jsonDecode(widget.billData['renglones']) ?? [];

    // // Extract the list of codes from renglones
    // final Set<String> renglonesCodes = renglones.map((r) => r['articulo'].toString()).toSet();

    // // Filter articles based on matching 'codigo'
    // return articles.where((article) => renglonesCodes.contains(article['_id'].toString())).toList();

    return [];
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    NetworkUtils.stopConnectivityCheck();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredList = filteredArticles();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Facturas", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/icons/refresh.png', width: 12, height: 14),
                const SizedBox(width: 4),
                Text("Hoy 09:25 AM",
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(fontFamily: 'Mulish')),
              ],
            )
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
      body: Container(
        color: AppTheme.greyBackground,
        child: Column(
          children: [
            const SizedBox(
              height: 16.0,
            ),
            // Expanded(
            //   child: Column(
            //     children: [
            //       BillCardModel(
            //         title: '#${widget.billData['codigo'] ?? 'sin codigo'}',
            //         description:
            //             widget.billData['descripcion'] ?? 'sin descripcion',
            //         location: widget.billData['direccion'] ?? 'sin direccion',
            //         amount: "${widget.billData['saldo'] ?? 0}",
            //         emissionDate: widget.billData['fecEmis'] ?? 'sin fecha',
            //         expirationDate: widget.billData['fecVenc'] ?? 'sin fecha',
            //         pending: widget.billData['pendiente'] ?? 0,
            //       ),
            //     ],
            //   ),
            // ),
            Expanded(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BillCardModel(
                        title: '#${widget.bill.codigo ?? 'sin codigo'}',
                        description: widget.bill.descripcion ?? 'sin descripcion',
                        location: widget.bill.dirEnt ?? 'sin direccion',
                        amount: "${widget.bill.saldo ?? 0}",
                        emissionDate: widget.bill.fecEmis ?? 'sin fecha',
                        expirationDate: widget.bill.fecVenc ?? 'sin fecha',
                        pending: widget.bill.tasa.toInt() ?? 0,
                        devolution: true),
                    Expanded(
                      child: filteredList.isEmpty
                          ? const Text('No hay datos.')
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                              itemCount: filteredList.length,
                              itemBuilder: (context, index) {
                                // final article = articles[index];
                                final article = filteredList[index];
                                String truncatedDescription = article['descripcion'].length > 25
                                    ? article['descripcion'].substring(0, 25) + "..."
                                    : article['descripcion'];

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                                      child: Row(
                                        children: [
                                          Image.asset("assets/images/product.png",
                                              width: 58, height: 46),
                                          Column(
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
                                                      article['codigo'] ?? 'sin codigo',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelSmall
                                                          ?.copyWith(color: AppTheme.greyColor),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                truncatedDescription,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(fontWeight: FontWeight.w500),
                                              ),
                                              Text(
                                                article['modelo'] ?? 'sin modelo',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        color: AppTheme.greyColor,
                                                        fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Tipo",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        color: AppTheme.greyColor,
                                                        fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Text(article['tipo'] ?? 'sin tipo',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(fontWeight: FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Garantia",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        color: AppTheme.greyColor,
                                                        fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Text(article['garantia'] ?? 'sin garantia',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                        fontWeight: FontWeight.w600,
                                                      )),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Peso",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(
                                                        color: AppTheme.greyColor,
                                                        fontWeight: FontWeight.w600)),
                                          ],
                                        ),
                                        const SizedBox(width: 32),
                                        Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8, vertical: 4),
                                              child: Text("${article['peso'] ?? 'sin peso'}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium
                                                      ?.copyWith(
                                                          fontWeight: FontWeight.w600,
                                                          color: AppTheme.primaryColor)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: AppTheme.greyBackground,
                                    ),
                                  ],
                                );
                              }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
