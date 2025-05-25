import 'package:syncman_new/models/payment_model.dart';
import 'package:syncman_new/repositories/payment/payment_read_repository.dart';
import 'package:syncman_new/repositories/payment/payment_write_repository.dart';

class PaymentService {
  final PaymentReadRepository _paymentReadRepository;
  final PaymentWriteRepository _paymentWriteRepository;

  PaymentService(this._paymentReadRepository, this._paymentWriteRepository);

  Future<List<Payment>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _paymentReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Payment> getById(String id) async {
    final payment = await _paymentReadRepository.getById(id);
    if (payment == null) {
      throw Exception('Payment not found');
    }

    return payment;
  }

  Future<Payment> getByCodigo(String codigo) async {
    final payment = await _paymentReadRepository.getByCodigo(codigo);
    if (payment == null) {
      throw Exception('Payment not found');
    }

    return payment;
  }

  Future<void> updateOrCreate(Payment payment) async {
    await _paymentWriteRepository.updateOrCreate(payment);
  }
} 