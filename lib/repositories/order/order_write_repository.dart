import 'package:syncman_new/models/order_model.dart';

abstract class OrderWriteRepository {
  Future<void> updateOrCreate(Order order);
}
