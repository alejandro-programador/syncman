import 'package:syncman_new/models/valija_model.dart';

abstract class ValijaWriteRepository {
  Future<void> updateOrCreate(Valija valija);
} 