import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/models/article_model.dart';
import 'package:syncman_new/models/bank_model.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/models/category_model.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/models/collect_model.dart';
import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/models/ctaingeg_model.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/models/order_model.dart';
import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/models/valija_model.dart';
import 'package:syncman_new/models/zone_model.dart';
import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/models/return_record_model.dart';
import 'package:syncman_new/repositories/area/local_area_write_repository.dart';
import 'package:syncman_new/repositories/article/api_article_read_repository.dart';
import 'package:syncman_new/repositories/article/local_article_read_repository.dart';
import 'package:syncman_new/repositories/article/local_article_write_repository.dart';
import 'package:syncman_new/repositories/bank/local_bank_read_repository.dart';
import 'package:syncman_new/repositories/bank/local_bank_write_repository.dart';
import 'package:syncman_new/repositories/bill/api_bill_read_repository.dart';
import 'package:syncman_new/repositories/bill/local_bill_write_repository.dart';
import 'package:syncman_new/repositories/client/api_client_read_repository.dart';
import 'package:syncman_new/repositories/client/local_client_write_repository.dart';
import 'package:syncman_new/repositories/cursor/cursor_repository.dart';
import 'package:syncman_new/repositories/cursor/local_cursor_repository.dart';
import 'package:syncman_new/repositories/dashboard/api_dashboard_read_repository.dart';
import 'package:syncman_new/repositories/dashboard/local_dashboard_write_repository.dart';
import 'package:syncman_new/repositories/order/api_order_read_repository.dart';
import 'package:syncman_new/repositories/order/local_order_write_repository.dart';
import 'package:syncman_new/repositories/payment/api_payment_read_repository.dart';
import 'package:syncman_new/repositories/payment/local_payment_write_repository.dart';
import 'package:syncman_new/repositories/return-record/api_return_record_read_repository.dart';
import 'package:syncman_new/repositories/return-record/local_return_record_write_repository.dart';
import 'package:syncman_new/repositories/seller/api_seller_read_repository.dart';
import 'package:syncman_new/repositories/seller/local_seller_write_repository.dart';
import 'package:syncman_new/repositories/valija/api_valija_read_repository.dart';
import 'package:syncman_new/repositories/valija/local_valija_write_repository.dart';
import 'package:syncman_new/services/sync/area_service.dart';
import 'package:syncman_new/services/sync/article_service.dart';
import 'package:syncman_new/services/sync/bank_service.dart';
import 'package:syncman_new/services/sync/bill_service.dart';
import 'package:syncman_new/services/sync/client_service.dart';
import 'package:syncman_new/services/sync/cursor_manager.dart';
import 'package:syncman_new/services/sync/dashboard_service.dart';
import 'package:syncman_new/services/sync/order_service.dart';
import 'package:syncman_new/services/sync/payment_service.dart';
import 'package:syncman_new/services/sync/seller_service.dart';
import 'package:syncman_new/services/sync/valija_service.dart';
import 'package:syncman_new/repositories/area/api_area_read_repository.dart';
import 'package:syncman_new/repositories/category/api_category_read_repository.dart';
import 'package:syncman_new/repositories/category/local_category_write_repository.dart';
import 'package:syncman_new/services/sync/category_service.dart';
import 'package:syncman_new/repositories/price/api_price_read_repository.dart';
import 'package:syncman_new/repositories/price/local_price_write_repository.dart';
import 'package:syncman_new/services/sync/price_service.dart';
import 'package:syncman_new/repositories/transport/api_transport_read_repository.dart';
import 'package:syncman_new/repositories/transport/local_transport_write_repository.dart';
import 'package:syncman_new/services/sync/transport_service.dart';
import 'package:syncman_new/repositories/currency/api_currency_read_repository.dart';
import 'package:syncman_new/repositories/currency/local_currency_write_repository.dart';
import 'package:syncman_new/services/sync/currency_service.dart';
import 'package:syncman_new/repositories/payment_condition/api_payment_condition_read_repository.dart';
import 'package:syncman_new/repositories/payment_condition/local_payment_condition_write_repository.dart';
import 'package:syncman_new/services/sync/payment_condition_service.dart';
import 'package:syncman_new/repositories/ctaingeg/api_ctaingeg_read_repository.dart';
import 'package:syncman_new/repositories/ctaingeg/local_ctaingeg_write_repository.dart';
import 'package:syncman_new/services/sync/ctaingeg_service.dart';
import 'package:syncman_new/repositories/tax/api_tax_read_repository.dart';
import 'package:syncman_new/repositories/tax/local_tax_write_repository.dart';
import 'package:syncman_new/services/sync/tax_service.dart';
import 'package:syncman_new/repositories/zone/api_zone_read_repository.dart';
import 'package:syncman_new/repositories/zone/local_zone_write_repository.dart';
import 'package:syncman_new/services/sync/zone_service.dart';
import 'package:syncman_new/repositories/currency/local_currency_read_repository.dart';
import 'package:syncman_new/repositories/collect_payment_method/api_collect_payment_method_read_repository.dart';
import 'package:syncman_new/repositories/collect_payment_method/local_collect_payment_method_write_repository.dart';
import 'package:syncman_new/services/sync/collect_payment_method_service.dart';
import 'package:syncman_new/repositories/tipo_precio/api_tipo_precio_read_repository.dart';
import 'package:syncman_new/repositories/tipo_precio/local_tipo_precio_write_repository.dart';
import 'package:syncman_new/services/sync/tipo_precio_service.dart';
import 'package:syncman_new/models/tipo_precio_model.dart';
import 'package:syncman_new/services/sync/return_record_service.dart';
import 'package:syncman_new/repositories/collect/api_collect_read_repository.dart';
import 'package:syncman_new/repositories/collect/local_collect_write_repository.dart';
import 'package:syncman_new/services/sync/collect_service.dart';
import 'dart:convert';

class SyncManager {
  final Map<String, CursorManager> _cursorManagers = {};
  late final AppDatabase _database;
  late final CursorRepository _cursorRepository;
  final ApiService _apiService;

  SyncManager({ApiService? apiService}) : _apiService = apiService ?? ApiService();

  Future<void> init() async {
    _database = AppDatabase.instance;
    _cursorRepository = LocalCursorRepository();

    print('=== Initializing SyncManager ===');
    
    // Regenerar la base de datos
    // await _database.regenerateDB();

    // print('=== Adding Dashboard Cursor ===');
    // await addDashboardCursor();
    // print('=== Dashboard Cursor Added ===');

    print('=== Adding Client Cursor ===');
    await addClientCursor();
    print('=== Client Cursor Added ===');

    print('=== Adding Seller Cursor ===');
    await addSellerCursor();
    print('=== Seller Cursor Added ===');

    // print('=== Adding Return Record Cursor ===');
    // await addReturnRecordCursor();
    // print('=== Return Record Cursor Added ===');

    // print('=== Adding Valija Cursor ===');
    // addValijaCursor();
    // print('=== Valija Cursor Added ===');

    // print('=== Adding Collect Cursor ===');
    // addCollectCursor();
    // print('=== Collect Cursor Added ===');

    // print('=== Adding Bill Cursor ===');
    // addBillCursor();
    // print('=== Bill Cursor Added ===');

    // print('=== Adding Article Cursor ===');
    // addArticleCursor();
    // print('=== Article Cursor Added ===');

    // print('=== Adding Collect Payment Method Cursor ===');
    // addCollectPaymentMethodCursor();
    // print('=== Collect Payment Method Cursor Added ===');

    // print('=== Adding Tipo Precio Cursor ===');
    // addTipoPrecioCursor();
    // print('=== Tipo Precio Cursor Added ===');

    // print('=== Adding Currency Cursor ===');
    // addCurrencyCursor();
    // print('=== Currency Cursor Added ===');
  }

  Future<void> sync(String cursorName) async {
    final cursorManager = _cursorManagers[cursorName];
    if (cursorManager == null) {
      throw Exception('Cursor manager not found for $cursorName');
    }

    await cursorManager.init();
    await cursorManager.nextAll();
  }

  Future<void> syncAll() async {
    for (var cursorManager in _cursorManagers.values) {
      await cursorManager.init();
      await cursorManager.nextAll();
    }
  }

  addOrderCursor() {
    final orderReadRepository = ApiOrderReadRepository(_apiService);
    final orderWriteRepository =
        LocalOrderWriteRepository(_database.database);
    final orderService =
        OrderService(orderReadRepository, orderWriteRepository);

    _cursorManagers['orders'] = CursorManager<List<Order>>(
        'orders', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final orders =
          await orderService.query(updatedAt: updatedAt, page: page);
      if (orders.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});

        return [];
      }

      for (var order in orders) {
        await orderService.updateOrCreate(order);
      }

      setCursor({
        'updatedAt': orders.last.updatedAt.toIso8601String(),
        'page': page + 1,
      });

      return orders;
    });
  }
  

  addSellerCursor() {
    final sellerReadRepository = ApiSellerReadRepository(_apiService);
    final sellerWriteRepository =
        LocalSellerWriteRepository(_database.database);
    final sellerService =
        SellerService(sellerReadRepository, sellerWriteRepository);

    _cursorManagers['sellers'] = CursorManager<List<Seller>>(
        'sellers', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final sellers =
          await sellerService.query(updatedAt: updatedAt, page: page);
      
      if (sellers.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var seller in sellers) {
        await sellerService.updateOrCreate(seller);
      }

      final newCursor = {
        'updatedAt': sellers.last.updatedAt.toIso8601String(),
        'page': page + 1,
      };
      setCursor(newCursor);

      return sellers;
    });
  }

  addAreaCursor() {
    final areaReadRepository = ApiAreaReadRepository(_apiService);
    final areaWriteRepository = LocalAreaWriteRepository(_database.database);
    final areaService = AreaService(areaReadRepository, areaWriteRepository);

    _cursorManagers['areas'] = CursorManager<List<Area>>(
        'areas', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final areas = await areaService.query(updatedAt: updatedAt, page: page);
      if (areas.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var area in areas) {
        await areaService.updateOrCreate(area);
      }

      setCursor({
        'updatedAt': areas.last.updatedAt.toIso8601String(),
        'page': page + 1,
      });

      return areas;
    });
  }

  addBankCursor() {
    final bankReadRepository = LocalBankReadRepository(_database.database);
    final bankWriteRepository = LocalBankWriteRepository(_database.database);
    final bankService = BankService(bankReadRepository, bankWriteRepository);

    _cursorManagers['bank'] = CursorManager<List<Bank>>(
        'banks', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final banks = await bankService.query(updatedAt: updatedAt, page: page);
      if (banks.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});

        return [];
      }

      for (var bank in banks) {
        await bankService.updateOrCreate(bank);
      }

      setCursor({
        'updatedAt': banks.last.updatedAt.toIso8601String(),
        'page': page + 1,
      });

      return banks;
    });
  }

  addClientCursor() {
    final clientReadRepository = ApiClientReadRepository(ApiService());
    final clientWriteRepository =
        LocalClientWriteRepository(_database.database);
    final clientService =
        ClientService(clientReadRepository, clientWriteRepository);

    _cursorManagers['client'] = CursorManager<List<Client>>(
        'clients', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      print('=== Fetching Clients ===');
      print('UpdatedAt: $updatedAt');
      print('Page: $page');

      final clients =
          await clientService.query(updatedAt: updatedAt, page: page);
      
      print('=== Clients from API ===');
      print('Number of clients received: ${clients.length}');
      for (var client in clients) {
        print('Client: ${client.descripcion}');
        print('ID: ${client.id}');
        print('Código: ${client.codigo}');
        print('Saldo: ${client.saldo_deudor}');
        print('------------------------');
      }

      if (clients.isEmpty) {
        print('No clients found, resetting cursor');
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      print('=== Saving Clients to Database ===');
      for (var client in clients) {
        print('Saving client: ${client.descripcion}');
        await clientService.updateOrCreate(client);
        print('Client saved successfully');
      }

      setCursor({
        'updatedAt': clients.last.updatedAt?.toIso8601String() ?? '',
        'page': page + 1,
      });

      print('=== Cursor Updated ===');
      print('New UpdatedAt: ${clients.last.updatedAt?.toIso8601String() ?? ''}');
      print('New Page: ${page + 1}');

      // Verify saved data
      print('=== Verifying Saved Client Data ===');
      final savedClients = await clientService.query();
      print('Total clients in database: ${savedClients.length}');
      for (var client in savedClients) {
        print('Saved Client: ${client.descripcion}');
        print('ID: ${client.id}');
        print('Código: ${client.codigo}');
        print('Saldo: ${client.saldo_deudor}');
        print('------------------------');
      }

      return clients;
    });
  }

  addPaymentCursor() {
    final paymentReadRepository = ApiPaymentReadRepository(_apiService);
    final paymentWriteRepository =
        LocalPaymentWriteRepository(_database.database);
    final paymentService =
        PaymentService(paymentReadRepository, paymentWriteRepository);

    _cursorManagers['payment'] = CursorManager<List<Payment>>(
        'payments', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      print('=== Fetching Payments ===');
      print('UpdatedAt: $updatedAt');
      print('Page: $page');

      final payments =
          await paymentService.query(updatedAt: updatedAt, page: page);
      
      print('=== Payments from API ===');
      print('Number of payments received: ${payments.length}');
      for (var payment in payments) {
        print('Payment ID: ${payment.id}');
        print('Client: ${payment.cliente}');
        print('Amount: ${payment.total}');
        print('Status: ${payment.estatus}');
        print('------------------------');
      }
      
      if (payments.isEmpty) {
        print('No payments found, resetting cursor');
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      print('=== Saving Payments to Database ===');
      for (var payment in payments) {
        print('Saving payment: ${payment.id}');
        await paymentService.updateOrCreate(payment);
        print('Payment saved successfully');
      }

      final newCursor = {
        'updatedAt': payments.last.updatedAt.toIso8601String(),
        'page': page + 1,
      };
      setCursor(newCursor);

      print('=== Cursor Updated ===');
      print('New UpdatedAt: ${newCursor['updatedAt']}');
      print('New Page: ${newCursor['page']}');

      // Verify saved data
      print('=== Verifying Saved Payment Data ===');
      final savedPayments = await paymentService.query();
      print('Total payments in database: ${savedPayments.length}');
      for (var payment in savedPayments) {
        print('Saved Payment ID: ${payment.id}');
        print('Client: ${payment.cliente}');
        print('Amount: ${payment.total}');
        print('Status: ${payment.estatus}');
        print('------------------------');
      }

      return payments;
    });
  }

  addValijaCursor() {
    final valijaReadRepository = ApiValijaReadRepository(_apiService);
    final valijaWriteRepository =
        LocalValijaWriteRepository(_database.database);
    final valijaService =
        ValijaService(valijaReadRepository, valijaWriteRepository);

    _cursorManagers['valija'] = CursorManager<List<Valija>>(
        'valijas', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final valijas =
          await valijaService.query(updatedAt: updatedAt, page: page);
      
      if (valijas.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var valija in valijas) {
        await valijaService.updateOrCreate(valija);
      }

      final newCursor = {
        'updatedAt': valijas.last.updatedAt?.toIso8601String() ?? '',
        'page': page + 1,
      };
      setCursor(newCursor);

      return valijas;
    });
  }

  addBillCursor() {
    final billReadRepository = ApiBillReadRepository(_apiService);
    final billWriteRepository =
        LocalBillWriteRepository(_database.database);
    final billService =
        BillService(billReadRepository, billWriteRepository);

    _cursorManagers['bill'] = CursorManager<List<Bill>>(
        'bills', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final bills =
          await billService.query(updatedAt: updatedAt, page: page);
      
      if (bills.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var bill in bills) {
        await billService.updateOrCreate(bill);
      }

      final newCursor = {
        'updatedAt': bills.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return bills;
    });
  }

  addCategoryCursor() {
    final categoryReadRepository = ApiCategoryReadRepository(_apiService);
    final categoryWriteRepository =
        LocalCategoryWriteRepository(_database.database);
    final categoryService =
        CategoryService(categoryReadRepository, categoryWriteRepository);

    _cursorManagers['category'] = CursorManager<List<Category>>(
        'categories', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final categories =
          await categoryService.query(updatedAt: updatedAt, page: page);
      
      if (categories.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var category in categories) {
        await categoryService.updateOrCreate(category);
      }

      final newCursor = {
        'updatedAt': categories.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return categories;
    });
  }

  addPriceCursor() {
    final priceReadRepository = ApiPriceReadRepository(_apiService);
    final priceWriteRepository =
        LocalPriceWriteRepository(_database.database);
    final priceService =
        PriceService(priceReadRepository, priceWriteRepository);

    _cursorManagers['price'] = CursorManager<List<Price>>(
        'prices', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final prices =
          await priceService.query(updatedAt: updatedAt, page: page);
      
      if (prices.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var price in prices) {
        await priceService.updateOrCreate(price);
      }

      final newCursor = {
        'updatedAt': prices.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return prices;
    });
  }

  addTransportCursor() {
    final transportReadRepository = ApiTransportReadRepository(_apiService);
    final transportWriteRepository =
        LocalTransportWriteRepository(_database.database);
    final transportService =
        TransportService(transportReadRepository, transportWriteRepository);

    _cursorManagers['transport'] = CursorManager<List<Transport>>(
        'transports', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final transports =
          await transportService.query(updatedAt: updatedAt, page: page);
      
      if (transports.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var transport in transports) {
        await transportService.updateOrCreate(transport);
      }

      final newCursor = {
        'updatedAt': transports.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return transports;
    });
  }

  addCurrencyCursor() {
    final currencyReadRepository = ApiCurrencyReadRepository(_apiService);
    final currencyWriteRepository =
        LocalCurrencyWriteRepository(_database.database);
    final currencyService =
        CurrencyService(currencyReadRepository, currencyWriteRepository);

    _cursorManagers['currency'] = CursorManager<List<Currency>>(
        'currencies', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      print('=== Fetching Currencies ===');
      print('UpdatedAt: $updatedAt');
      print('Page: $page');

      final currencies =
          await currencyService.query(updatedAt: updatedAt, page: page);
      
      print('=== Currencies from API ===');
      print('Number of currencies received: ${currencies.length}');
      for (var currency in currencies) {
        print('Currency: ${currency.nombre} (${currency.codigo})');
        print('ID: ${currency.id}');
        print('Cambio: ${currency.cambio}');
        print('------------------------');
      }
      
      if (currencies.isEmpty) {
        print('No currencies found, resetting cursor');
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      print('=== Saving Currencies to Database ===');
      for (var currency in currencies) {
        print('Saving currency: ${currency.nombre}');
        await currencyService.updateOrCreate(currency);
        print('Currency saved successfully');
      }

      final newCursor = {
        'updatedAt': currencies.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);
      print('=== Cursor Updated ===');
      print('New UpdatedAt: ${newCursor['updatedAt']}');
      print('New Page: ${newCursor['page']}');

      // Verify saved data
      print('=== Verifying Saved Data ===');
      final savedCurrencies = await currencyService.query();
      print('Total currencies in database: ${savedCurrencies.length}');
      for (var currency in savedCurrencies) {
        print('Saved Currency: ${currency.nombre} (${currency.codigo})');
        print('ID: ${currency.id}');
        print('Cambio: ${currency.cambio}');
        print('------------------------');
      }

      return currencies;
    });
  }

  addPaymentConditionCursor() {
    final paymentConditionReadRepository = ApiPaymentConditionReadRepository(_apiService);
    final paymentConditionWriteRepository =
        LocalPaymentConditionWriteRepository(_database.database);
    final paymentConditionService =
        PaymentConditionService(paymentConditionReadRepository, paymentConditionWriteRepository);

    _cursorManagers['paymentCondition'] = CursorManager<List<PaymentCondition>>(
        'paymentConditions', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final paymentConditions =
          await paymentConditionService.query(updatedAt: updatedAt, page: page);
      
      if (paymentConditions.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var paymentCondition in paymentConditions) {
        await paymentConditionService.updateOrCreate(paymentCondition);
      }

      final newCursor = {
        'updatedAt': paymentConditions.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return paymentConditions;
    });
  }

  addCtaIngEgCursor() {
    final ctaIngrEgrReadRepository = ApiCtaIngrEgrReadRepository(_apiService);
    final ctaIngrEgrWriteRepository =
        LocalCtaIngrEgrWriteRepository(_database.database);
    final ctaIngrEgrService =
        CtaIngrEgrService(ctaIngrEgrReadRepository, ctaIngrEgrWriteRepository);

    _cursorManagers['ctaIngrEgr'] = CursorManager<List<CtaIngrEgr>>(
        'ctaIngrEgr', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final ctaIngrEgrList =
          await ctaIngrEgrService.query(updatedAt: updatedAt, page: page);
      
      if (ctaIngrEgrList.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var ctaIngrEgr in ctaIngrEgrList) {
        await ctaIngrEgrService.updateOrCreate(ctaIngrEgr);
      }

      final newCursor = {
        'updatedAt': ctaIngrEgrList.last.updatedAt,
        'page': page + 1,
      };
      setCursor(newCursor);

      return ctaIngrEgrList;
    });
  }

  addTaxCursor() {
    final taxReadRepository = ApiTaxReadRepository(_apiService);
    final taxWriteRepository = LocalTaxWriteRepository(_database.database);
    final taxService = TaxService(taxReadRepository, taxWriteRepository);

    _cursorManagers['tax'] = CursorManager<List<Tax>>(
        'taxes', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final taxes = await taxService.query(updatedAt: updatedAt, page: page);
      
      if (taxes.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var tax in taxes) {
        await taxService.updateOrCreate(tax);
      }

      final newCursor = {
        'updatedAt': DateTime.now().toIso8601String(),
        'page': page + 1,
      };
      setCursor(newCursor);

      return taxes;
    });
  }

  addZoneCursor() {
    final zoneReadRepository = ApiZoneReadRepository(_apiService);
    final zoneWriteRepository = LocalZoneWriteRepository(_database.database);
    final zoneService = ZoneService(zoneReadRepository, zoneWriteRepository);

    _cursorManagers['zone'] = CursorManager<List<Area>>(
        'zones', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final zones = await zoneService.query(updatedAt: updatedAt, page: page);
      
      if (zones.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var zone in zones) {
        await zoneService.updateOrCreate(zone);
      }

      final newCursor = {
        'updatedAt': zones.last.updatedAt.toIso8601String(),
        'page': page + 1,
      };
      setCursor(newCursor);

      return zones;
    });
  }

  addCollectPaymentMethodCursor() async {
    final collectPaymentMethodReadRepository = ApiCollectPaymentMethodReadRepository(_apiService);
    final collectPaymentMethodWriteRepository =
        LocalCollectPaymentMethodWriteRepository(_database.database);
    final collectPaymentMethodService =
        CollectPaymentMethodService(collectPaymentMethodReadRepository, collectPaymentMethodWriteRepository);

    _cursorManagers['collect_payment_method'] = CursorManager<List<CollectPaymentMethod>>(
        'collect_payment_methods', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      print('=== Fetching Payment Methods ===');
      print('UpdatedAt: $updatedAt');
      print('Page: $page');

      final paymentMethods =
          await collectPaymentMethodService.query(updatedAt: updatedAt, page: page);
      
      print('=== Payment Methods from API ===');
      print('Number of payment methods received: ${paymentMethods.length}');
      for (var paymentMethod in paymentMethods) {
        print('Payment Method: ${paymentMethod.descripcion}');
        print('ID: ${paymentMethod.id}');
        print('Cuenta: ${paymentMethod.cuenta}');
        print('------------------------');
      }
      
      if (paymentMethods.isEmpty) {
        print('No payment methods found, resetting cursor');
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      print('=== Saving Payment Methods to Database ===');
      for (var paymentMethod in paymentMethods) {
        print('Saving payment method: ${paymentMethod.descripcion}');
        await collectPaymentMethodService.updateOrCreate(paymentMethod);
        print('Payment method saved successfully');
      }

      final newCursor = {
        'updatedAt': paymentMethods.last.updatedAt?.toIso8601String() ?? '',
        'page': page + 1,
      };
      setCursor(newCursor);

      print('=== Cursor Updated ===');
      print('New UpdatedAt: ${newCursor['updatedAt']}');
      print('New Page: ${newCursor['page']}');

      // Verify saved data
      print('=== Verifying Saved Data ===');
      final savedPaymentMethods = await collectPaymentMethodService.query();
      print('Total payment methods in database: ${savedPaymentMethods.length}');
      for (var paymentMethod in savedPaymentMethods) {
        print('Saved Payment Method: ${paymentMethod.descripcion}');
        print('ID: ${paymentMethod.id}');
        print('Cuenta: ${paymentMethod.cuenta}');
        print('------------------------');
      }

      return paymentMethods;
    });
  }

  addTipoPrecioCursor() async {
    final tipoPrecioReadRepository = ApiTipoPrecioReadRepository(_apiService);
    final tipoPrecioWriteRepository =
        LocalTipoPrecioWriteRepository(await _database.database);
    final tipoPrecioService =
        TipoPrecioService(tipoPrecioReadRepository, tipoPrecioWriteRepository);

    _cursorManagers['tipo_precio'] = CursorManager<List<TipoPrecio>>(
        'tipo_precios', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final tipoPrecios =
          await tipoPrecioService.query(updatedAt: updatedAt, page: page);
      
      if (tipoPrecios.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var tipoPrecio in tipoPrecios) {
        await tipoPrecioService.updateOrCreate(tipoPrecio);
      }

      final newCursor = {
        'updatedAt': tipoPrecios.last.updatedAt?.toIso8601String() ?? '',
        'page': page + 1,
      };
      setCursor(newCursor);

      return tipoPrecios;
    });
  }

  addArticleCursor() {
    final articleReadRepository = ApiArticleReadRepository(_apiService);
    final articleWriteRepository =
        LocalArticleWriteRepository(_database.database);
    final articleService =
        ArticleService(articleReadRepository, articleWriteRepository);

    _cursorManagers['article'] = CursorManager<List<Articulo>>(
        'articles', _cursorRepository, (cursor, setCursor) async {
      try {
        final updatedAt = cursor.value['updatedAt'];
        final page = cursor.value['page'] ?? 1;

        print('=== Fetching Articles ===');
        print('UpdatedAt: $updatedAt');
        print('Page: $page');

        final articles =
            await articleService.query(updatedAt: updatedAt, page: page);
        
        print('=== Articles from API ===');
        print('Number of articles received: ${articles.length}');
        for (var article in articles) {
          print('Article: ${article.descripcion}');
          print('ID: ${article.id}');
          print('Código: ${article.codigo}');
          print('Stock: ${article.stock}');
          print('Precio: ${article.precio}');
          print('------------------------');
        }

        if (articles.isEmpty) {
          print('No articles found, resetting cursor');
          setCursor({'updatedAt': updatedAt, 'page': 1});
          return [];
        }

        print('=== Saving Articles to Database ===');
        for (var article in articles) {
          print('Saving article: ${article.descripcion}');
          await articleService.updateOrCreate(article);
          print('Article saved successfully');
        }

        setCursor({
          'updatedAt': articles.last.updatedAt,
          'page': page + 1,
        });

        print('=== Cursor Updated ===');
        print('New UpdatedAt: ${articles.last.updatedAt}');
        print('New Page: ${page + 1}');

        // Verify saved data
        print('=== Verifying Saved Article Data ===');
        try {
          final localArticleReadRepository = LocalArticleReadRepository(_database.database);
          final savedArticles = await localArticleReadRepository.query();
          print('Total articles in database: ${savedArticles.length}');
          
          if (savedArticles.isEmpty) {
            print('WARNING: No articles found in local database after saving');
          } else {
            for (var article in savedArticles) {
              print('Saved Article: ${article.descripcion}');
              print('ID: ${article.id}');
              print('Código: ${article.codigo}');
              print('Stock: ${article.stock}');
              print('Precio: ${article.precio}');
              print('Linea: ${article.linea.descripcion}');
              print('Sublinea: ${article.sublinea.descripcion}');
              print('Categoría: ${article.categoria.descripcion}');
              print('Color: ${article.color.descripcion}');
              print('Ubicación: ${article.ubicacion.descripcion}');
              print('Procedencia: ${article.procedencia.descripcion}');
              print('------------------------');
            }
          }
        } catch (e, stackTrace) {
          print('Error verifying saved articles: $e');
          print('Stack trace: $stackTrace');
        }

        return articles;
      } catch (e, stackTrace) {
        print('Error in addArticleCursor: $e');
        print('Stack trace: $stackTrace');
        rethrow;
      }
    });
  }

  addDashboardCursor() async {
    print('\n=== Initializing Dashboard Sync ===');
    final dashboardReadRepository = ApiDashboardReadRepository(_apiService);
    final db = await _database.database;
    final dashboardWriteRepository = LocalDashboardWriteRepository(db);
    final dashboardService = DashboardService(dashboardReadRepository, dashboardWriteRepository);

    _cursorManagers['dashboard'] = CursorManager<List<Dashboard>>(
        'dashboard', _cursorRepository, (cursor, setCursor) async {
      // Verificar si ya existe un cursor con datos
      if (cursor.value.isNotEmpty) {
        print('Dashboard already synced, stopping sync process');
        return [];
      }

      print('\n=== Fetching Dashboard ===');
      print('Initial sync - no previous data');

      final dashboards = await dashboardService.query(updatedAt: null, page: 1);
      
      print('\n=== Dashboard from API ===');
      if (dashboards.isEmpty) {
        print('No dashboard data found');
        return [];
      }

      final dashboard = dashboards.first;
      print('Monto Vencido: ${dashboard.montoVencido}');
      print('Monto No Vencido: ${dashboard.montoNoVencido}');
      print('Monto Adeudado: ${dashboard.montoAdeudado}');
      print('Pedidos Creados: ${dashboard.pedidosCreados}');
      print('Pedidos Parcialmente: ${dashboard.pedidosParcialmente}');
      print('Pedidos Procesados: ${dashboard.pedidosProcesados}');
      print('Clientes Deudores: ${dashboard.clientesDeudores}');
      print('Clientes Solventes: ${dashboard.clientesSolventes}');
      print('Clientes Con Pedidos Hoy: ${dashboard.clientesConPedidosHoy}');
      print('Clientes Sin Pedidos Hoy: ${dashboard.clientesSinPedidosHoy}');
      print('------------------------');

      print('\n=== Saving Dashboard to Database ===');
      await dashboardService.updateOrCreate(dashboard);
      print('Dashboard saved successfully');

      // Establecer el cursor como completado
      setCursor({
        'updatedAt': dashboard.updatedAt?.toIso8601String() ?? '',
        'page': 1,
        'completed': true
      });

      print('\n=== Dashboard Sync Completed ===');
      return [];
    });
    print('=== Dashboard Sync Initialized ===\n');
  }

  Future<void> verifyArticlesTable() async {
    try {
      print('\n=== Verifying Articles Table Data ===');
      
      final db = await _database.database;
      final List<Map<String, dynamic>> articles = await db.query('articles');
      
      print('Total articles in database: ${articles.length}');
      
      for (var article in articles) {
        print('\nArticle Details:');
        print('ID: ${article['_id']}');
        print('Código: ${article['codigo']}');
        print('Descripción: ${article['descripcion']}');
        print('Tipo: ${article['tipo']}');
        print('Anulado: ${article['anulado'] == 1 ? 'Sí' : 'No'}');
        print('Fecha Registro: ${article['fechaRegistro']}');
        
        // Parse and display related data
        try {
          final linea = jsonDecode(article['linea'] as String);
          print('Línea: ${linea['descripcion']}');
          
          final sublinea = jsonDecode(article['sublinea'] as String);
          print('Sublinea: ${sublinea['descripcion']}');
          
          final categoria = jsonDecode(article['categoria'] as String);
          print('Categoría: ${categoria['descripcion']}');
          
          final color = jsonDecode(article['color'] as String);
          print('Color: ${color['descripcion']}');
          
          final ubicacion = jsonDecode(article['ubicacion'] as String);
          print('Ubicación: ${ubicacion['descripcion']}');
          
          final procedencia = jsonDecode(article['procedencia'] as String);
          print('Procedencia: ${procedencia['descripcion']}');
        } catch (e) {
          print('Error parsing related data: $e');
        }
        
        print('Item: ${article['item']}');
        print('Modelo: ${article['modelo']}');
        print('Referencia: ${article['referencia']}');
        print('Génerico: ${article['generico'] == 1 ? 'Sí' : 'No'}');
        print('Maneja Serial: ${article['manejaSerial'] == 1 ? 'Sí' : 'No'}');
        print('Maneja Lote: ${article['manejaLote'] == 1 ? 'Sí' : 'No'}');
        print('Maneja Lote con Vencimiento: ${article['manejaLoteConVencimiento'] == 1 ? 'Sí' : 'No'}');
        print('Tipo Imp: ${article['tipoImp']}');
        print('Tipo Imp2: ${article['tipoImp2']}');
        print('Garantía: ${article['garantia']}');
        print('Volumen: ${article['volumen']}');
        print('Peso: ${article['peso']}');
        print('Stock Mínimo: ${article['stockMinimo']}');
        print('Stock Máximo: ${article['stockMaximo']}');
        print('Stock Pedido: ${article['stockPedido']}');
        print('Relación Unidad: ${article['relacionUnidad']}');
        print('Precio OM: ${article['precioOm'] == 1 ? 'Sí' : 'No'}');
        print('Comentario: ${article['comentario']}');
        print('Tipo Costo: ${article['tipoCosto']}');
        print('Monto Comisión: ${article['montoComision']}');
        print('Stock: ${article['stock']}');
        print('Precio: ${article['precio']}');
        print('Tax Rate: ${article['taxRate']}');
        print('Is Deleted: ${article['isDeleted'] == 1 ? 'Sí' : 'No'}');
        print('Deleted At: ${article['deletedAt']}');
        print('Created At: ${article['createdAt']}');
        print('Updated At: ${article['updatedAt']}');
        print('------------------------');
      }
    } catch (e, stackTrace) {
      print('Error verifying articles table: $e');
      print('Stack trace: $stackTrace');
    }
  }

  Future<void> verifySellersTable() async {
    try {
      print('\n=== Verifying Sellers Table Data ===');
      
      final db = await _database.database;
      final List<Map<String, dynamic>> sellers = await db.query('sellers');
      
      print('Total sellers in database: ${sellers.length}');
      
      for (var seller in sellers) {
        print('\nSeller Details:');
        print('ID: ${seller['id']} (${seller['id'].runtimeType})');
        print('Código: ${seller['codigo']} (${seller['codigo'].runtimeType})');
        print('Descripción: ${seller['descripcion']} (${seller['descripcion'].runtimeType})');
        print('Tipo: ${seller['tipo']} (${seller['tipo'].runtimeType})');
        print('Zona: ${seller['zona']} (${seller['zona'].runtimeType})');
        print('Cédula: ${seller['cedula']} (${seller['cedula'].runtimeType})');
        print('Dirección: ${seller['direc1']} (${seller['direc1'].runtimeType})');
        print('Teléfonos: ${seller['telefonos']} (${seller['telefonos'].runtimeType})');
        print('Fecha Registro: ${seller['fechaReg']} (${seller['fechaReg'].runtimeType})');
        print('Inactivo: ${seller['inactivo'] == 1 ? 'Sí' : 'No'} (${seller['inactivo'].runtimeType})');
        print('Comisión: ${seller['comision']} (${seller['comision'].runtimeType})');
        print('Comentario: ${seller['comentario']} (${seller['comentario'].runtimeType})');
        print('Función Cobrador: ${seller['funCob'] == 1 ? 'Sí' : 'No'} (${seller['funCob'].runtimeType})');
        print('Función Vendedor: ${seller['funVen'] == 1 ? 'Sí' : 'No'} (${seller['funVen'].runtimeType})');
        print('Comisión Vendedor: ${seller['comisionv']} (${seller['comisionv'].runtimeType})');
        print('Login: ${seller['login']} (${seller['login'].runtimeType})');
        print('Email: ${seller['email']} (${seller['email'].runtimeType})');
        print('Saldo CXC: ${seller['saldoCXC']} (${seller['saldoCXC'].runtimeType})');
        print('Saldo Deudor: ${seller['saldo_deudor']} (${seller['saldo_deudor'].runtimeType})');
        print('Saldo Deudor Total: ${seller['saldo_deudor_total']} (${seller['saldo_deudor_total'].runtimeType})');
        
        // Parse and display datos adicionales if they exist
        if (seller['datosAdicionales'] != null) {
          try {
            print('\nDatos Adicionales: ${seller['datosAdicionales'].runtimeType}');
            final datosAdicionales = jsonDecode(seller['datosAdicionales'] as String);
            for (var dato in datosAdicionales) {
              print('${dato['descripcion']}: ${dato['valor']} (${dato['valor'].runtimeType})');
            }
          } catch (e) {
            print('Error parsing datos adicionales: $e');
          }
        }
        
        print('Is Deleted: ${seller['isDeleted'] == 1 ? 'Sí' : 'No'} (${seller['isDeleted'].runtimeType})');
        print('Deleted At: ${seller['deletedAt']} (${seller['deletedAt'].runtimeType})');
        print('Created At: ${seller['createdAt']} (${seller['createdAt'].runtimeType})');
        print('Updated At: ${seller['updatedAt']} (${seller['updatedAt'].runtimeType})');
        print('------------------------');
      }
    } catch (e, stackTrace) {
      print('Error verifying sellers table: $e');
      print('Stack trace: $stackTrace');
    }
  }

  addReturnRecordCursor() async {
    final returnRecordReadRepository = ApiReturnRecordReadRepository(_apiService);
    final db = await _database.database;
    final returnRecordWriteRepository = LocalReturnRecordWriteRepository(db);
    final returnRecordService =
        ReturnRecordService(returnRecordReadRepository, returnRecordWriteRepository);

    _cursorManagers['return_record'] = CursorManager<List<ReturnRecord>>(
        'return_records', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      print('=== Fetching Return Records ===');
      print('UpdatedAt: $updatedAt');
      print('Page: $page');

      final returnRecords =
          await returnRecordService.query(updatedAt: updatedAt, page: page);
      
      print('=== Return Records from API ===');
      print('Number of return records received: ${returnRecords.length}');
      for (var record in returnRecords) {
        print('Return Record: ${record.codigo}');
        print('ID: ${record.id}');
        print('Cliente: ${record.cliente.descripcion}');
        print('Total: ${record.total}');
        print('Estatus: ${record.estatus}');
        print('------------------------');
      }
      
      if (returnRecords.isEmpty) {
        print('No return records found, resetting cursor');
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      print('=== Saving Return Records to Database ===');
      for (var record in returnRecords) {
        print('Saving return record: ${record.codigo}');
        await returnRecordService.updateOrCreate(record);
        print('Return record saved successfully');
      }

      final newCursor = {
        'updatedAt': returnRecords.last.updatedAt.toIso8601String(),
        'page': page + 1,
      };
      setCursor(newCursor);

      print('=== Cursor Updated ===');
      print('New UpdatedAt: ${newCursor['updatedAt']}');
      print('New Page: ${newCursor['page']}');

      // Verify saved data
      print('=== Verifying Saved Return Record Data ===');
      final savedRecords = await returnRecordService.query();
      print('Total return records in database: ${savedRecords.length}');
      for (var record in savedRecords) {
        print('Saved Return Record: ${record.codigo}');
        print('ID: ${record.id}');
        print('Cliente: ${record.cliente.descripcion}');
        print('Total: ${record.total}');
        print('Estatus: ${record.estatus}');
        print('------------------------');
      }

      return returnRecords;
    });
  }

  Future<void> verifyReturnRecordsTable() async {
    try {
      print('\n=== Verifying Return Records Table Data ===');
      
      final db = await _database.database;
      final List<Map<String, dynamic>> records = await db.query('return_records');
      
      print('Total return records in database: ${records.length}');
      
      for (var record in records) {
        print('\nReturn Record Details:');
        print('ID: ${record['_id']}');
        print('Código: ${record['codigo']}');
        
        // Parse and display related data
        try {
          final vendedor = jsonDecode(record['vendedor'] as String);
          print('Vendedor: ${vendedor['descripcion']}');
          
          final cliente = jsonDecode(record['cliente'] as String);
          print('Cliente: ${cliente['descripcion']}');
          
          final factura = jsonDecode(record['factura'] as String);
          print('Factura: ${factura['codigo']}');
          
          final productos = jsonDecode(record['productos'] as String);
          print('Productos: ${productos.length} items');
          for (var producto in productos) {
            print('  - ${producto['descripcion']}: ${producto['cantidad']} unidades');
          }
          
          final imagenes = jsonDecode(record['imagenes'] as String);
          print('Imágenes: ${imagenes.length} archivos');
        } catch (e) {
          print('Error parsing related data: $e');
        }
        
        print('IVA: ${record['iva']}');
        print('Subtotal: ${record['subtotal']}');
        print('Total: ${record['total']}');
        print('Observación: ${record['observacion']}');
        print('Motivo: ${record['motivo']}');
        print('Descripción del Motivo: ${record['desMotivo']}');
        print('Descripción: ${record['descripcion']}');
        print('Estatus: ${record['estatus']}');
        print('Is Deleted: ${record['isDeleted'] == 1 ? 'Sí' : 'No'}');
        print('Deleted At: ${record['deletedAt']}');
        print('Created At: ${record['createdAt']}');
        print('Updated At: ${record['updatedAt']}');
        print('------------------------');
      }
    } catch (e, stackTrace) {
      print('Error verifying return records table: $e');
      print('Stack trace: $stackTrace');
    }
  }

  addCollectCursor() {
    final collectReadRepository = ApiCollectReadRepository(_apiService);
    final collectWriteRepository =
        LocalCollectWriteRepository(_database.database);
    final collectService =
        CollectService(collectReadRepository, collectWriteRepository);

    _cursorManagers['collect'] = CursorManager<List<Collect>>(
        'collects', _cursorRepository, (cursor, setCursor) async {
      final updatedAt = cursor.value['updatedAt'];
      final page = cursor.value['page'] ?? 1;

      final collects =
          await collectService.query(updatedAt: updatedAt, page: page);
      
      if (collects.isEmpty) {
        setCursor({'updatedAt': updatedAt, 'page': 1});
        return [];
      }

      for (var collect in collects) {
        await collectService.updateOrCreate(collect);
      }

      final newCursor = {
        'updatedAt': collects.last.updatedAt?.toIso8601String() ?? '',
        'page': page + 1,
      };
      setCursor(newCursor);

      return collects;
    });
  }
}
