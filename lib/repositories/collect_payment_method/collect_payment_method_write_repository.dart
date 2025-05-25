import 'package:syncman_new/models/collect_payment_method.dart';

abstract class CollectPaymentMethodWriteRepository {
  Future<void> create(CollectPaymentMethod paymentMethod);
  Future<void> update(CollectPaymentMethod paymentMethod);
  Future<void> delete(String id);
  Future<void> updateOrCreate(CollectPaymentMethod paymentMethod);
} 