import 'package:syncman_new/models/currency_model.dart';
import 'package:syncman_new/repositories/currency/currency_read_repository.dart';
import 'package:syncman_new/repositories/currency/currency_write_repository.dart';

class CurrencyService {
  final CurrencyReadRepository _currencyReadRepository;
  final CurrencyWriteRepository _currencyWriteRepository;

  CurrencyService(this._currencyReadRepository, this._currencyWriteRepository);

  Future<List<Currency>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _currencyReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Currency> getById(String id) async {
    final currency = await _currencyReadRepository.getById(id);
    if (currency == null) {
      throw Exception('Currency not found');
    }

    return currency;
  }

  Future<Currency> getByCodigo(String codigo) async {
    final currency = await _currencyReadRepository.getByCodigo(codigo);
    if (currency == null) {
      throw Exception('Currency not found');
    }

    return currency;
  }

  Future<void> updateOrCreate(Currency currency) async {
    await _currencyWriteRepository.updateOrCreate(currency);
  }
} 