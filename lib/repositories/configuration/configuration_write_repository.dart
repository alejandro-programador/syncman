import 'package:syncman_new/models/configuration_model.dart';

abstract class ConfigurationWriteRepository {
  Future<void> updateOrCreate(Configuration configuration);
}
