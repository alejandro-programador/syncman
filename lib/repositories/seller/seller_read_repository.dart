import 'package:syncman_new/models/seller_model.dart';

abstract class SellerReadRepository {
  Future<List<Seller>> query({
    String? updatedAt,
    int? page,
  });
  Future<Seller?> getById(String id);
  Future<Seller?> getByCodigo(String codigo);
}
