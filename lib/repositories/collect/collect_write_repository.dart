import 'package:syncman_new/models/collect_model.dart';

abstract class CollectWriteRepository {
  Future<void> updateOrCreate(Collect collect);
} 