import 'package:syncman_new/models/client_model.dart';

abstract class ClientWriteRepository {
  Future<void> updateOrCreate(Client client);
}
