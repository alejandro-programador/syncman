import 'package:syncman_new/models/payment_model.dart';

abstract class PaymentWriteRepository {
  Future<void> updateOrCreate(Payment payment);
} 