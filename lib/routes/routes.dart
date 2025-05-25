import 'package:flutter/material.dart';
import 'package:syncman_new/screens/auth/login.dart';
import 'package:syncman_new/screens/info/help_center.dart';
import 'package:syncman_new/screens/info/privacy_policy.dart';
import 'package:syncman_new/screens/splash.dart';
import 'package:syncman_new/screens/system/bill.dart';
import 'package:syncman_new/screens/system/cart.dart';
import 'package:syncman_new/screens/system/client.dart';
import 'package:syncman_new/screens/system/client_detail.dart';
import 'package:syncman_new/screens/system/collect.dart';
import 'package:syncman_new/screens/system/collect_report.dart';
import 'package:syncman_new/screens/system/collect_report_list.dart';
import 'package:syncman_new/screens/system/home.dart';
import 'package:syncman_new/screens/system/inactive_client.dart';
import 'package:syncman_new/screens/system/invoice.dart';
import 'package:syncman_new/screens/system/order.dart';
import 'package:syncman_new/screens/system/order_add.dart';
import 'package:syncman_new/screens/system/order_detail.dart';
import 'package:syncman_new/screens/system/order_report.dart';
import 'package:syncman_new/screens/system/product.dart';
import 'package:syncman_new/screens/system/product_catalog.dart';
import 'package:syncman_new/screens/system/product_detail.dart';
import 'package:syncman_new/screens/system/projection.dart';
import 'package:syncman_new/screens/system/refund.dart';
import 'package:syncman_new/screens/system/refund_report.dart';
import 'package:syncman_new/screens/system/report.dart';
import 'package:syncman_new/screens/system/seller.dart';
import 'package:syncman_new/screens/system/summary.dart';
import 'package:syncman_new/screens/system/supervisor_profile.dart';
import 'package:syncman_new/screens/system/valija.dart';
import 'package:syncman_new/screens/system/valija_create.dart';
import 'package:syncman_new/screens/system/valija_report.dart';
import 'package:syncman_new/screens/system/valija_report_list.dart';
import 'package:syncman_new/test_articles.dart';
import 'package:syncman_new/widgets/notification.dart';
import 'package:syncman_new/widgets/success_message.dart';

class Routes {
  // auth
  static const String welcome = '/welcome';
  static const String login = '/';

  // info
  static const String help = '/help-center';
  static const String privacy = '/privacy-policy';

  // system
  static const String dashboard = '/dashboard';
  static const String notifications = '/notifications';
  static const String projection = '/projection';
  static const String supervisor = '/supervisor-profile';
  static const String seller = '/seller';
  static const String client = '/client';
  static const String clientProfile = '/client-profile';
  static const String clientDetail = '/client-detail';
  static const String sellerDetail = '/seller-detail';
  static const String order = '/order';
  static const String product = '/product';
  static const String productDetail = '/product-detail';
  static const String catalog = '/catalog';
  static const String cart = '/cart';
  static const String invoice = '/invoice';
  static const String success = '/success-message';
  static const String collect = '/collect';
  static const String collectReport = '/collect-report';
  static const String valija = '/valija';
  static const String createValija = '/create-valija';
  static const String summary = '/summary';
  static const String report = '/report';
  static const String refund = '/refund';
  static const String bill = '/bill';
  static const String billDetail = '/bill-detail';
  static const String orderReport = '/order-report';
  static const String orderDetail = '/order-detail';
  static const String inactiveClient = '/inactive-client';
  static const String refundReport = '/refund-report';
  static const String collectReport2 = '/collect-report2';
  static const String valijaReport = '/valija-report';
  static const String valijaReportList = '/valija-report-list';
  static const String orderAdd = '/order-add';
  static const String testArticles = '/test-articles';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // auth
      case welcome:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
      // info
      case help:
        return MaterialPageRoute(builder: (_) => const HelpCenterView());
      case privacy:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyView());
      // system
      case dashboard:
        return MaterialPageRoute(builder: (_) => const SyncManDashboard());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsView());
      case projection:
        return MaterialPageRoute(builder: (_) => const ProjectionView());
      case supervisor:
        return MaterialPageRoute(builder: (_) => const SupervisorProfileView());
      case seller:
        return MaterialPageRoute(builder: (_) => const SellerView());
      case client:
        return MaterialPageRoute(builder: (_) => const ClientsView());
      case clientDetail:
        return MaterialPageRoute(builder: (_) => const ClientDetailView());
      case order:
        return MaterialPageRoute(builder: (_) => const OrderView());
      case product:
        return MaterialPageRoute(builder: (_) => const ProductListView());
      case productDetail:
        return MaterialPageRoute(builder: (_) => const ProductDetailView());
      case catalog:
        return MaterialPageRoute(builder: (_) => const ProductCatalogView());
      case cart:
        return MaterialPageRoute(builder: (_) => const CartView());
      case invoice:
        return MaterialPageRoute(builder: (_) => const InvoiceView());
      case success:
        return MaterialPageRoute(builder: (_) => const SuccessMessageView());
      case collect:
        return MaterialPageRoute(builder: (_) => const CollectView());
      case collectReport:
        return MaterialPageRoute(builder: (_) => const CollectReport());
      case valija:
        return MaterialPageRoute(builder: (_) => const ValijaView());
      case createValija:
        return MaterialPageRoute(builder: (_) => const ValijaCreateView());
      case summary:
        return MaterialPageRoute(builder: (_) => const SummaryView());
      case report:
        return MaterialPageRoute(builder: (_) => const ReportView());
      case refund:
        return MaterialPageRoute(builder: (_) => const RefundView());
      case bill:
        return MaterialPageRoute(builder: (_) => const BillsView());
      case orderReport:
        return MaterialPageRoute(builder: (_) => const OrderReportView());
      case orderDetail:
        return MaterialPageRoute(builder: (_) => const OrderDetail());
      case inactiveClient:
        return MaterialPageRoute(builder: (_) => const InactiveClientView());
      case refundReport:
        return MaterialPageRoute(builder: (_) => const RefundReportView());
      case collectReport2:
        return MaterialPageRoute(builder: (_) => const CollectReport2View());
      case valijaReport:
        return MaterialPageRoute(builder: (_) => const ValijaReportView());
      case valijaReportList:
        return MaterialPageRoute(builder: (_) => const ValijaReportListView());
      case orderAdd:
        return MaterialPageRoute(builder: (_) => const OrderAddView());
      case testArticles:
        return MaterialPageRoute(builder: (_) => const TestArticlesScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => const Scaffold(
                  body: Center(child: Text('Page not found')),
                ));
    }
  }
}
