import 'package:syncman_new/models/seller_model.dart';

abstract class SellerWriteRepository {
  Future<void> updateOrCreate(Seller seller);
}
