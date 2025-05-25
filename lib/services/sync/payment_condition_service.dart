import 'package:syncman_new/models/payment_condition_model.dart';
import 'package:syncman_new/repositories/payment_condition/payment_condition_read_repository.dart';
import 'package:syncman_new/repositories/payment_condition/payment_condition_write_repository.dart';

class PaymentConditionService {
  final PaymentConditionReadRepository _paymentConditionReadRepository;
  final PaymentConditionWriteRepository _paymentConditionWriteRepository;

  PaymentConditionService(this._paymentConditionReadRepository, this._paymentConditionWriteRepository);

  Future<List<PaymentCondition>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _paymentConditionReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<PaymentCondition> getById(String id) async {
    final paymentCondition = await _paymentConditionReadRepository.getById(id);
    if (paymentCondition == null) {
      throw Exception('Payment condition not found');
    }

    return paymentCondition;
  }

  Future<PaymentCondition> getByCodigo(String codigo) async {
    final paymentCondition = await _paymentConditionReadRepository.getByCodigo(codigo);
    if (paymentCondition == null) {
      throw Exception('Payment condition not found');
    }

    return paymentCondition;
  }

  Future<void> updateOrCreate(PaymentCondition paymentCondition) async {
    await _paymentConditionWriteRepository.updateOrCreate(paymentCondition);
  }
} 