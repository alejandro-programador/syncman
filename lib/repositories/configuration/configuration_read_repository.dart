import 'package:syncman_new/models/configuration_model.dart';

abstract class ConfigurationReadRepository {
  Future<Configuration?> get();
}
