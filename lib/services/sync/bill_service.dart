import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/repositories/bill/bill_read_repository.dart';
import 'package:syncman_new/repositories/bill/bill_write_repository.dart';

class BillService {
  final BillReadRepository _billReadRepository;
  final BillWriteRepository _billWriteRepository;

  BillService(this._billReadRepository, this._billWriteRepository);

  Future<List<Bill>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _billReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Bill> getById(String id) async {
    final bill = await _billReadRepository.getById(id);
    if (bill == null) {
      throw Exception('Bill not found');
    }
    return bill;
  }

  Future<Bill> getByCodigo(String codigo) async {
    final bill = await _billReadRepository.getByCodigo(codigo);
    if (bill == null) {
      throw Exception('Bill not found');
    }
    return bill;
  }

  Future<List<Bill>> getByClientId(String clientId, {int page = 0, int pageSize = 20}) async {
    return await _billReadRepository.getByClientId(clientId, page: page, pageSize: pageSize);
  }

  Future<void> updateOrCreate(Bill bill) async {
    await _billWriteRepository.updateOrCreate(bill);
  }
} 