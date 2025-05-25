import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_read_repository.dart';

class LocalDashboardReadRepository implements DashboardReadRepository {
  final Database _database;

  LocalDashboardReadRepository(this._database);

  @override
  Future<Dashboard> query({
    String? updatedAt,
    int? page,
  }) async {
    try {
      print('\n=== Querying Dashboard from Database ===');
      
      final db = _database;
      
      // Primero verificamos si la tabla existe
      final tables = await db.query('sqlite_master', 
        where: 'type = ? AND name = ?',
        whereArgs: ['table', 'dashboard']
      );
      
      if (tables.isEmpty) {
        print('Dashboard table does not exist');
        return Dashboard.emptyDashboard;
      }
      
      // Consultamos los datos
      final List<Map<String, dynamic>> maps = await db.query('dashboard');
      
      if (maps.isEmpty) {
        print('No dashboard data found in database');
        return Dashboard.emptyDashboard;
      }
      
      final dashboard = Dashboard.fromMap(maps.first);
      print('\n=== Dashboard Data Found ===');
      print('Monto Vencido: ${dashboard.montoVencido}');
      print('Monto No Vencido: ${dashboard.montoNoVencido}');
      print('Monto Adeudado: ${dashboard.montoAdeudado}');
      print('Pedidos Creados: ${dashboard.pedidosCreados}');
      print('Pedidos Parcialmente: ${dashboard.pedidosParcialmente}');
      print('Pedidos Procesados: ${dashboard.pedidosProcesados}');
      print('Clientes Deudores: ${dashboard.clientesDeudores}');
      print('Clientes Solventes: ${dashboard.clientesSolventes}');
      print('Clientes Con Pedidos Hoy: ${dashboard.clientesConPedidosHoy}');
      print('Clientes Sin Pedidos Hoy: ${dashboard.clientesSinPedidosHoy}');
      print('Proyección Total Vendido: ${dashboard.proyeccionTotalVendido}');
      print('Proyección Total Vendido Acum: ${dashboard.proyeccionTotalVendidoAcum}');
      print('Proyección Cantidad Productos: ${dashboard.proyeccionCantidadProductos}');
      print('Proyección Cantidad Productos Acum: ${dashboard.proyeccionCantidadProductosAcum}');
      print('Proyección Cantidad Clientes: ${dashboard.proyeccionCantidadClientes}');
      print('Proyección Cantidad Clientes Acum: ${dashboard.proyeccionCantidadClientesAcum}');
      print('Created At: ${dashboard.createdAt}');
      print('Updated At: ${dashboard.updatedAt}');
      
      return dashboard;
    } catch (e, stackTrace) {
      print('Error querying dashboard from database: $e');
      print('Stack trace: $stackTrace');
      return Dashboard.emptyDashboard;
    }
  }
}