import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/providers/article_provider.dart';
import 'package:syncman_new/providers/bill_provider.dart';
import 'package:syncman_new/providers/cart_provider.dart';
import 'package:syncman_new/providers/category_provider.dart';
import 'package:syncman_new/providers/client_provider.dart';
import 'package:syncman_new/providers/configuration_provider.dart';
import 'package:syncman_new/providers/cta_ingregre_provider.dart';
import 'package:syncman_new/providers/currency_provider.dart';
import 'package:syncman_new/providers/database_provider.dart';
import 'package:syncman_new/providers/dashboard_provider.dart';
import 'package:syncman_new/providers/order_provider.dart';
import 'package:syncman_new/providers/payment_condition_provider.dart';
import 'package:syncman_new/providers/price_provider.dart';
import 'package:syncman_new/providers/return_record_provider.dart';
import 'package:syncman_new/providers/seller_provider.dart';
import 'package:syncman_new/providers/tax_provider.dart';
import 'package:syncman_new/providers/transport_provider.dart';
import 'package:syncman_new/providers/valija_provider.dart';
import 'package:syncman_new/providers/zone_provider.dart';
import 'package:syncman_new/providers/payment_provider.dart';
import 'package:syncman_new/providers/bill_selection_provider.dart';
import 'package:syncman_new/providers/payment_method_provider.dart';
import 'package:syncman_new/providers/selected_client_provider.dart';
import 'package:syncman_new/providers/collect_provider.dart';
import 'package:syncman_new/repositories/article/local_article_read_repository.dart';
import 'package:syncman_new/repositories/article/local_article_write_repository.dart';
import 'package:syncman_new/repositories/bill/local_bill_read_repository.dart';
import 'package:syncman_new/repositories/bill/local_bill_write_repository.dart';
import 'package:syncman_new/repositories/category/local_category_read_repository.dart';
import 'package:syncman_new/repositories/category/local_category_write_repository.dart';
import 'package:syncman_new/repositories/collect_payment_method/local_collect_payment_method_read_repository.dart';
import 'package:syncman_new/repositories/collect_payment_method/local_collect_payment_method_write_repository.dart';
import 'package:syncman_new/repositories/client/local_client_read_repository.dart';
import 'package:syncman_new/repositories/client/local_client_write_repository.dart';
import 'package:syncman_new/repositories/configuration/local_configuration_read_repository.dart';
import 'package:syncman_new/repositories/configuration/local_configuration_write_repository.dart';
import 'package:syncman_new/repositories/ctaingeg/local_ctaingeg_read_repository.dart';
import 'package:syncman_new/repositories/ctaingeg/local_ctaingeg_write_repository.dart';
import 'package:syncman_new/repositories/currency/local_currency_read_repository.dart';
import 'package:syncman_new/repositories/currency/local_currency_write_repository.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_read_repository.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_write_repository.dart';
import 'package:syncman_new/repositories/order/local_order_read_repository.dart';
import 'package:syncman_new/repositories/order/local_order_write_repository.dart';
import 'package:syncman_new/repositories/payment/local_payment_read_repository.dart';
import 'package:syncman_new/repositories/payment/local_payment_write_repository.dart';
import 'package:syncman_new/repositories/payment_condition/local_payment_condition_read_repository.dart';
import 'package:syncman_new/repositories/payment_condition/local_payment_condition_write_repository.dart';
import 'package:syncman_new/repositories/price/local_price_read_repository.dart';
import 'package:syncman_new/repositories/price/local_price_write_repository.dart';
import 'package:syncman_new/repositories/return-record/local_return_record_read_repository.dart';
import 'package:syncman_new/repositories/return-record/local_return_record_write_repository.dart';
import 'package:syncman_new/repositories/seller/local_seller_read_repository.dart';
import 'package:syncman_new/repositories/seller/local_seller_write_repository.dart';
import 'package:syncman_new/repositories/tax/local_tax_read_repository.dart';
import 'package:syncman_new/repositories/tax/local_tax_write_repository.dart';
import 'package:syncman_new/repositories/transport/local_transport_read_repository.dart';
import 'package:syncman_new/repositories/transport/local_transport_write_repository.dart';
import 'package:syncman_new/repositories/valija/local_valija_read_repository.dart';
import 'package:syncman_new/repositories/valija/local_valija_write_repository.dart';
import 'package:syncman_new/repositories/zone/local_zone_read_repository.dart';
import 'package:syncman_new/repositories/zone/local_zone_write_repository.dart';
import 'package:syncman_new/repositories/collect/local_collect_read_repository.dart';
import 'package:syncman_new/repositories/collect/local_collect_write_repository.dart';
import 'package:syncman_new/services/sync/article_service.dart';
import 'package:syncman_new/services/sync/bill_service.dart';
import 'package:syncman_new/services/sync/category_service.dart';
import 'package:syncman_new/services/sync/client_service.dart';
import 'package:syncman_new/services/sync/configuration_service.dart';
import 'package:syncman_new/services/sync/ctaingeg_service.dart';
import 'package:syncman_new/services/sync/currency_service.dart';
import 'package:syncman_new/services/sync/dashboard_service.dart';
import 'package:syncman_new/services/sync/order_service.dart';
import 'package:syncman_new/services/sync/payment_condition_service.dart';
import 'package:syncman_new/services/sync/payment_service.dart';
import 'package:syncman_new/services/sync/return_record_service.dart';
import 'package:syncman_new/services/sync/seller_service.dart';
import 'package:syncman_new/services/sync/price_service.dart';
import 'package:syncman_new/services/sync/tax_service.dart';
import 'package:syncman_new/services/sync/transport_service.dart';
import 'package:syncman_new/services/sync/valija_service.dart';
import 'package:syncman_new/services/sync/zone_service.dart';
import 'package:syncman_new/services/sync/collect_payment_method_service.dart';
import 'package:syncman_new/services/sync/collect_service.dart';

class AppProviders extends StatelessWidget {
  final Widget child;
  final AppDatabase database;

  const AppProviders({
    super.key,
    required this.child,
    required this.database,
  });

  Future<MultiProvider> _buildProviders() async {
    final db = await database.database;

    // Client
    final clientReadRepository = LocalClientReadRepository(database.database);
    final clientWriteRepository = LocalClientWriteRepository(database.database);
    final clientService = ClientService(clientReadRepository, clientWriteRepository);

    // Seller
    final sellerReadRepository = LocalSellerReadRepository(database.database);
    final sellerWriteRepository = LocalSellerWriteRepository(database.database);
    final sellerService = SellerService(sellerReadRepository, sellerWriteRepository);

    // Payment
    final paymentReadRepository = LocalPaymentReadRepository(database.database);
    final paymentWriteRepository = LocalPaymentWriteRepository(database.database);
    final paymentService = PaymentService(paymentReadRepository, paymentWriteRepository);

    // Bill
    final billReadRepository = LocalBillReadRepository(database.database);
    final billWriteRepository = LocalBillWriteRepository(database.database);
    final billService = BillService(billReadRepository, billWriteRepository);

    // Article
    final articleReadRepository = LocalArticleReadRepository(database.database);
    final articleWriteRepository = LocalArticleWriteRepository(database.database);
    final articleService = ArticleService(articleReadRepository, articleWriteRepository);

    // Category
    final categoryReadRepository = LocalCategoryReadRepository(database.database);
    final categoryWriteRepository = LocalCategoryWriteRepository(database.database);
    final categoryService = CategoryService(categoryReadRepository, categoryWriteRepository);

    // Price
    final priceReadRepository = LocalPriceReadRepository(database.database);
    final priceWriteRepository = LocalPriceWriteRepository(database.database);
    final priceService = PriceService(priceReadRepository, priceWriteRepository);

    // Order
    final orderReadRepository = LocalOrderReadRepository(database.database);
    final orderWriteRepository = LocalOrderWriteRepository(database.database);
    final orderService = OrderService(orderReadRepository, orderWriteRepository);

    // Transport
    final transportReadRepository = LocalTransportReadRepository(database.database);
    final transportWriteRepository = LocalTransportWriteRepository(database.database);
    final transportService = TransportService(transportReadRepository, transportWriteRepository);

    // Currency
    final currencyReadRepository = LocalCurrencyReadRepository(database.database);
    final currencyWriteRepository = LocalCurrencyWriteRepository(database.database);
    final currencyService = CurrencyService(currencyReadRepository, currencyWriteRepository);

    // Payment Condition
    final paymentConditionReadRepository = LocalPaymentConditionReadRepository(database.database);
    final paymentConditionWriteRepository = LocalPaymentConditionWriteRepository(database.database);
    final paymentConditionService =
        PaymentConditionService(paymentConditionReadRepository, paymentConditionWriteRepository);

    // Cta Ingre Egr
    final ctaIngregreReadRepository = LocalCtaIngrEgrReadRepository(database.database);
    final ctaIngregreWriteRepository = LocalCtaIngrEgrWriteRepository(database.database);
    final ctaIngregreService =
        CtaIngrEgrService(ctaIngregreReadRepository, ctaIngregreWriteRepository);

    // Tax
    final taxReadRepository = LocalTaxReadRepository(database.database);
    final taxWriteRepository = LocalTaxWriteRepository(database.database);
    final taxService = TaxService(taxReadRepository, taxWriteRepository);

    // Zone
    final zoneReadRepository = LocalZoneReadRepository(database.database);
    final zoneWriteRepository = LocalZoneWriteRepository(database.database);
    final zoneService = ZoneService(zoneReadRepository, zoneWriteRepository);

    // Configuration
    final configurationReadRepository = LocalConfigurationReadRepository(database.database);
    final configurationWriteRepository = LocalConfigurationWriteRepository(database.database);
    final configurationService =
        ConfigurationService(configurationReadRepository, configurationWriteRepository);

    // Payment Method
    final paymentMethodReadRepository = LocalCollectPaymentMethodReadRepository(database.database);
    final paymentMethodWriteRepository = LocalCollectPaymentMethodWriteRepository(database.database);
    final paymentMethodService = CollectPaymentMethodService(paymentMethodReadRepository, paymentMethodWriteRepository);

    // Dashboard
    final dashboardReadRepository = LocalDashboardReadRepository(await database.database);
    final dashboardWriteRepository = LocalDashboardWriteRepository(database.database);
    final dashboardService = DashboardService(dashboardReadRepository, dashboardWriteRepository);
    final dashboardProvider = DashboardProvider(dashboardService);

    // Valija
    final valijaReadRepository = LocalValijaReadRepository(database.database);
    final valijaWriteRepository = LocalValijaWriteRepository(database.database);
    final valijaService = ValijaService(valijaReadRepository, valijaWriteRepository);

    // Return Record
    final returnRecordReadRepository = LocalReturnRecordReadRepository(database.database);
    final returnRecordWriteRepository = LocalReturnRecordWriteRepository(await database.database);
    final returnRecordService = ReturnRecordService(returnRecordReadRepository, returnRecordWriteRepository);

    // Collect
    final collectReadRepository = LocalCollectReadRepository(database.database);
    final collectWriteRepository = LocalCollectWriteRepository(database.database);
    final collectService = CollectService(collectReadRepository, collectWriteRepository);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DatabaseProvider(database)),
        ChangeNotifierProvider(create: (_) => ClientsProvider(clientService)),
        ChangeNotifierProvider(create: (_) => SellersProvider(sellerService)),
        ChangeNotifierProvider(create: (_) => PaymentProvider(paymentService)),
        ChangeNotifierProvider(create: (_) => BillProvider(billService)),
        ChangeNotifierProvider(create: (_) => ArticleProvider(articleService)),
        ChangeNotifierProvider(create: (_) => CategoryProvider(categoryService)),
        ChangeNotifierProvider(create: (_) => PriceProvider(priceService)),
        ChangeNotifierProvider(create: (_) => OrderProvider(orderService)),
        ChangeNotifierProvider(create: (_) => TransportProvider(transportService)),
        ChangeNotifierProvider(create: (_) => CurrencyProvider(currencyService)),
        ChangeNotifierProvider(create: (_) => PaymentConditionProvider(paymentConditionService)),
        ChangeNotifierProvider(create: (_) => CtaIngrEgrProvider(ctaIngregreService)),
        ChangeNotifierProvider(create: (_) => TaxProvider(taxService)),
        ChangeNotifierProvider(create: (_) => ZoneProvider(zoneService)),
        ChangeNotifierProvider(create: (_) => ConfigurationProvider(configurationService)),
        ChangeNotifierProvider(create: (_) => PaymentMethodProvider(paymentMethodService)),
        ChangeNotifierProvider(create: (_) => ValijaProvider(valijaService)),
        ChangeNotifierProvider(create: (_) => ReturnRecordProvider(returnRecordService: returnRecordService)),
        ChangeNotifierProvider(create: (_) => CollectsProvider(collectService)),
        ChangeNotifierProvider(
          create: (_) {
            dashboardProvider.loadDashboard();
            return dashboardProvider;
          },
        ),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BillSelectionProvider()),
        ChangeNotifierProvider(create: (_) => SelectedClientProvider()),
      ],
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MultiProvider>(
      future: _buildProviders(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return snapshot.data ?? const SizedBox();
      },
    );
  }
}
