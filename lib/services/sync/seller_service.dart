import 'package:syncman_new/models/seller_model.dart';
import 'package:syncman_new/repositories/seller/seller_read_repository.dart';
import 'package:syncman_new/repositories/seller/seller_write_repository.dart';

class SellerService {
  final SellerReadRepository _sellerReadRepository;
  final SellerWriteRepository _sellerWriteRepository;

  SellerService(this._sellerReadRepository, this._sellerWriteRepository);

  Future<List<Seller>> query({
    String? updatedAt,
    int? page,
  }) async {
    final sellers = await _sellerReadRepository.query(
      updatedAt: updatedAt,
      page: page,
    );

    return sellers;
  }

  Future<Seller> getById(String id) async {
    final seller = await _sellerReadRepository.getById(id);
    if (seller == null) {
      throw Exception('Seller not found');
    }

    return seller;
  }

  Future<void> updateOrCreate(Seller seller) async {
    await _sellerWriteRepository.updateOrCreate(seller);
  }
}
