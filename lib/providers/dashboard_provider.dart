import 'package:flutter/material.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/services/sync/dashboard_service.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardService _dashboardService;
  Dashboard _dashboard = Dashboard.emptyDashboard;
  bool _isLoading = false;

  Dashboard get dashboard => _dashboard;
  bool get isLoading => _isLoading;

  DashboardProvider(this._dashboardService);

  // Obtener datos desde la base local
  Future<void> loadDashboard() async {
    try {
      print('\n=== INICIANDO CARGA DE DASHBOARD ===');
      _isLoading = true;
      notifyListeners();

      print('Consultando datos del dashboard...');
      final dashboardList = await _dashboardService.query();
      
      print('Cantidad de registros encontrados: ${dashboardList.length}');
      
      if (dashboardList.isNotEmpty) {
        _dashboard = dashboardList.first;
        print('\n=== DATOS DEL DASHBOARD CARGADOS ===');
        print('Monto Vencido: ${_dashboard.montoVencido}');
        print('Monto No Vencido: ${_dashboard.montoNoVencido}');
        print('Monto Adeudado: ${_dashboard.montoAdeudado}');
        print('Pedidos Creados: ${_dashboard.pedidosCreados}');
        print('Pedidos Parcialmente: ${_dashboard.pedidosParcialmente}');
        print('Pedidos Procesados: ${_dashboard.pedidosProcesados}');
        print('Clientes Deudores: ${_dashboard.clientesDeudores}');
        print('Clientes Solventes: ${_dashboard.clientesSolventes}');
        print('Clientes Con Pedidos Hoy: ${_dashboard.clientesConPedidosHoy}');
        print('Clientes Sin Pedidos Hoy: ${_dashboard.clientesSinPedidosHoy}');
        print('Proyección Total Vendido: ${_dashboard.proyeccionTotalVendido}');
        print('Proyección Total Vendido Acum: ${_dashboard.proyeccionTotalVendidoAcum}');
        print('Proyección Cantidad Productos: ${_dashboard.proyeccionCantidadProductos}');
        print('Proyección Cantidad Productos Acum: ${_dashboard.proyeccionCantidadProductosAcum}');
        print('Proyección Cantidad Clientes: ${_dashboard.proyeccionCantidadClientes}');
        print('Proyección Cantidad Clientes Acum: ${_dashboard.proyeccionCantidadClientesAcum}');
        print('Created At: ${_dashboard.createdAt}');
        print('Updated At: ${_dashboard.updatedAt}');
      } else {
        print('\n⚠️ No se encontraron datos del dashboard en la base de datos');
        print('Usando dashboard vacío con valores por defecto');
      }
    } catch (e, stackTrace) {
      print('\n❌ Error al cargar el dashboard:');
      print('Error: $e');
      print('Stack trace: $stackTrace');
    } finally {
      _isLoading = false;
      notifyListeners();
      print('\n=== FINALIZADA CARGA DE DASHBOARD ===\n');
    }
  }
} 