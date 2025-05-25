import 'package:flutter/material.dart';
import 'package:syncman_new/api/api_service.dart';
import 'package:syncman_new/models/client_model.dart';
import 'package:syncman_new/services/sync/client_service.dart';

class ClientsProvider with ChangeNotifier {
  final ClientService _clientService;
  List<Client> _clients = [];
  List<dynamic> _clientCart = [];
  Map<String, dynamic> _clientProfile = {};
  bool _isLoading = false;

  List<Client> get clients => _clients;
  List<dynamic> get clientCart => _clientCart;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get clientProfile => _clientProfile;

  ClientsProvider(this._clientService);

  Future<void> fetchClientCart(String clientID) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().getRequest('/clientes/$clientID');
      if (response != null && response.statusCode == 200) {
        _clientCart = response.data["carrito"];
      } else {
        throw Exception('Error al obtener perfil de cliente. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener perfil de cliente: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void addProductToClientCart(Map<String, dynamic> product) async {
    _clientCart.add(product);
    notifyListeners();
  }

  Future<void> saveCart(String clientID, List<dynamic> data) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiService().putRequest(
        '/clientes/carrito/$clientID',
        data: {"carrito": data},
      );
      if (response != null && response.statusCode == 200) {
      } else {
        throw Exception('Error al obtener perfil de cliente. status: $response');
      }
    } catch (e) {
      throw Exception('Error al obtener perfil de cliente: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchClientByID(String clientID) async {
    _isLoading = true;
    notifyListeners();

    Client? foundItem = _clients.firstWhere(
      (item) => item.id == clientID,
      orElse: () => Client.emptyClient, // Devuelve null si no se encuentra
    );

    _clientProfile = foundItem.toMap();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchClientData(String clientDNI) async {
    _isLoading = true;
    notifyListeners();

    final fetchClient = await _clientService.getByCodigo(clientDNI);
    _clientProfile = fetchClient.toMap();

    _isLoading = false;
    notifyListeners();
  }

  // Obtener datos desde la base local
  Future<void> loadClients() async {
    _isLoading = true;
    notifyListeners();

    final clientsList = await _clientService.query();
    _clients = clientsList;

    _isLoading = false;
    notifyListeners();
  }
}
