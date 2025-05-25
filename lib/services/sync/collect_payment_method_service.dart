import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/repositories/collect_payment_method/collect_payment_method_read_repository.dart';
import 'package:syncman_new/repositories/collect_payment_method/collect_payment_method_write_repository.dart';

class CollectPaymentMethodService {
  final CollectPaymentMethodReadRepository _collectPaymentMethodReadRepository;
  final CollectPaymentMethodWriteRepository _collectPaymentMethodWriteRepository;

  CollectPaymentMethodService(
    this._collectPaymentMethodReadRepository,
    this._collectPaymentMethodWriteRepository,
  );

  Future<List<CollectPaymentMethod>> query({
    String? updatedAt,
    int? page,
  }) async {
    print('=== CollectPaymentMethodService.query ===');
    print('UpdatedAt: $updatedAt');
    print('Page: $page');
    
    final result = await _collectPaymentMethodReadRepository.query(
      updatedAt: updatedAt,
      page: page,
    );
    
    print('=== Query Result ===');
    print('Number of payment methods found: ${result.length}');
    for (var method in result) {
      print('Payment Method: ${method.descripcion}');
      print('ID: ${method.id}');
      print('Cuenta: ${method.cuenta}');
      print('------------------------');
    }
    
    return result;
  }

  Future<CollectPaymentMethod> getById(String id) async {
    final paymentMethod = await _collectPaymentMethodReadRepository.getById(id);
    if (paymentMethod == null) {
      throw Exception('Método de pago no encontrado');
    }

    return paymentMethod;
  }

  Future<CollectPaymentMethod> getByDescripcion(String descripcion) async {
    final paymentMethod = await _collectPaymentMethodReadRepository.getByDescripcion(descripcion);
    if (paymentMethod == null) {
      throw Exception('Método de pago no encontrado');
    }

    return paymentMethod;
  }

  Future<void> updateOrCreate(CollectPaymentMethod paymentMethod) async {
    await _collectPaymentMethodWriteRepository.updateOrCreate(paymentMethod);
  }
} 