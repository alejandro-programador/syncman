import 'package:syncman_new/models/currency_model.dart';

abstract class CurrencyWriteRepository {
  Future<void> updateOrCreate(Currency currency);
} 