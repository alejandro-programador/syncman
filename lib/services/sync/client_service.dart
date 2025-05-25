import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/repositories/client/client_read_repository.dart';
import 'package:syncman_new/repositories/client/client_write_repository.dart';

class ClientService {
  final ClientReadRepository _clientReadRepository;
  final ClientWriteRepository _clientWriteRepository;

  ClientService(this._clientReadRepository, this._clientWriteRepository);

  Future<List<Client>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _clientReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Client> getById(String id) async {
    final client = await _clientReadRepository.getById(id);
    if (client == null) {
      throw Exception('Client not found');
    }

    return client;
  }

  Future<Client> getByCodigo(String codigo) async {
    final client = await _clientReadRepository.getByCodigo(codigo);
    if (client == null) {
      throw Exception('Client not found');
    }

    return client;
  }

  Future<void> updateOrCreate(Client client) async {
    await _clientWriteRepository.updateOrCreate(client);
  }
}
