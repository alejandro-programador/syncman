import 'package:syncman_new/models/payment_condition_model.dart';

abstract class PaymentConditionWriteRepository {
  Future<void> updateOrCreate(PaymentCondition paymentCondition);
} 