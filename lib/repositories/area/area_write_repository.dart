import 'package:syncman_new/models/zone_model.dart';

abstract class AreaWriteRepository {
  Future<void> updateOrCreate(Area area);
}
