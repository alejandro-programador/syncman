import 'package:syncman_new/models/configuration_model.dart';
import 'package:syncman_new/repositories/configuration/configuration_read_repository.dart';
import 'package:syncman_new/repositories/configuration/configuration_write_repository.dart';

class ConfigurationService {
  final ConfigurationReadRepository _configurationReadRepository;
  final ConfigurationWriteRepository _configurationWriteRepository;

  ConfigurationService(this._configurationReadRepository, this._configurationWriteRepository);

  Future<Configuration> get() async {
    final configuration = await _configurationReadRepository.get();
    if (configuration == null) {
      throw Exception('Configuration not found');
    }

    return configuration;
  }

  Future<void> updateOrCreate(Configuration configuration) async {
    await _configurationWriteRepository.updateOrCreate(configuration);
  }
} 