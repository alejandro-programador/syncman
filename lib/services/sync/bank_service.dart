import 'package:syncman_new/models/bank_model.dart';
import 'package:syncman_new/repositories/bank/bank_read_repository.dart';
import 'package:syncman_new/repositories/bank/bank_write_repository.dart';

class BankService {
  final BankReadRepository _bankReadRepository;
  final BankWriteRepository _bankWriteRepository;

  BankService(this._bankReadRepository, this._bankWriteRepository);

  Future<List<Bank>> query({
    String? updatedAt,
    int? page,
  }) async {
    final banks = await _bankReadRepository.query(
      updatedAt: updatedAt,
      page: page,
    );

    return banks;
  }

  Future<Bank> getById(String id) async {
    final bank = await _bankReadRepository.getById(id);
    if (bank == null) {
      throw Exception('Bank not found');
    }

    return bank;
  }

  Future<void> updateOrCreate(Bank bank) async {
    await _bankWriteRepository.updateOrCreate(bank);
  }
}
