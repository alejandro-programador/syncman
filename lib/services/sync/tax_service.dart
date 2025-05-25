import 'package:syncman_new/models/tax_model.dart';
import 'package:syncman_new/repositories/tax/tax_read_repository.dart';
import 'package:syncman_new/repositories/tax/tax_write_repository.dart';

class TaxService {
  final TaxReadRepository _taxReadRepository;
  final TaxWriteRepository _taxWriteRepository;

  TaxService(this._taxReadRepository, this._taxWriteRepository);

  Future<List<Tax>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _taxReadRepository.getAllTaxes();
  }

  Future<Tax> getById(String id) async {
    final tax = await _taxReadRepository.getTaxById(id);
    if (tax == null) {
      throw Exception('Tax not found');
    }

    return tax;
  }

  Future<List<Tax>> getTaxesByDate(String date) async {
    return await _taxReadRepository.getTaxesByDate(date);
  }

  Future<void> updateOrCreate(Tax tax) async {
    try {
      final existingTax = await _taxReadRepository.getTaxById(tax.id);
      if (existingTax != null) {
        await _taxWriteRepository.updateTax(tax);
      } else {
        await _taxWriteRepository.createTax(tax);
      }
    } catch (e) {
      throw Exception('Failed to update or create tax: $e');
    }
  }
} 