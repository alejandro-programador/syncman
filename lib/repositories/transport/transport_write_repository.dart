import 'package:syncman_new/models/transport_model.dart';

abstract class TransportWriteRepository {
  Future<void> updateOrCreate(Transport transport);
} 