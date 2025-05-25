import 'package:syncman_new/models/bill_model.dart';

abstract class BillWriteRepository {
  Future<void> updateOrCreate(Bill bill);
} 