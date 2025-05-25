import 'package:syncman_new/models/transport_model.dart';
import 'package:syncman_new/repositories/transport/transport_read_repository.dart';
import 'package:syncman_new/repositories/transport/transport_write_repository.dart';

class TransportService {
  final TransportReadRepository _transportReadRepository;
  final TransportWriteRepository _transportWriteRepository;

  TransportService(this._transportReadRepository, this._transportWriteRepository);

  Future<List<Transport>> query({
    String? updatedAt,
    int? page,
  }) async {
    return await _transportReadRepository.query(updatedAt: updatedAt, page: page);
  }

  Future<Transport> getById(String id) async {
    final transport = await _transportReadRepository.getById(id);
    if (transport == null) {
      throw Exception('Transport not found');
    }
    return transport;
  }

  Future<Transport> getByCodigo(String codigo) async {
    final transport = await _transportReadRepository.getByCodigo(codigo);
    if (transport == null) {
      throw Exception('Transport not found');
    }
    return transport;
  }

  Future<void> updateOrCreate(Transport transport) async {
    await _transportWriteRepository.updateOrCreate(transport);
  }
} 