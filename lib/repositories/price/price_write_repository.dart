import 'package:syncman_new/models/price_model.dart';

abstract class PriceWriteRepository {
  Future<void> updateOrCreate(Price price);
} 