import 'package:syncman_new/models/zone_model.dart';

abstract class ZoneWriteRepository {
  Future<void> updateOrCreate(Area area);
} 