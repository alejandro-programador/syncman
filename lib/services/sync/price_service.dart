import 'package:syncman_new/models/price_model.dart';
import 'package:syncman_new/repositories/price/price_read_repository.dart';
import 'package:syncman_new/repositories/price/price_write_repository.dart';

class PriceService {
  final PriceReadRepository _priceReadRepository;
  final PriceWriteRepository _priceWriteRepository;

  PriceService(this._priceReadRepository, this._priceWriteRepository);

  Future<List<Price>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _priceReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Price> getById(String id) async {
    final price = await _priceReadRepository.getById(id);
    if (price == null) {
      throw Exception('Price not found');
    }

    return price;
  }

  Future<Price> getByCodigo(String codigo) async {
    final price = await _priceReadRepository.getByCodigo(codigo);
    if (price == null) {
      throw Exception('Price not found');
    }

    return price;
  }

  Future<void> updateOrCreate(Price price) async {
    await _priceWriteRepository.updateOrCreate(price);
  }
} 