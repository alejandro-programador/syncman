import 'package:syncman_new/models/bank_model.dart';

abstract class BankWriteRepository {
  Future<void> updateOrCreate(Bank bank);
}
