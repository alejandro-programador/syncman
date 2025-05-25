import 'package:syncman_new/models/return_record_model.dart';

abstract class ReturnRecordWriteRepository {
  Future<void> updateOrCreate(ReturnRecord record);
  Future<void> delete(String id);
} 