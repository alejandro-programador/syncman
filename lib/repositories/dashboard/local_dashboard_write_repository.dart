import 'package:sqflite/sqflite.dart';
import 'package:syncman_new/models/dashboard_model.dart';
import 'package:syncman_new/repositories/dashboard/dashboard_write_repository.dart';

class LocalDashboardWriteRepository implements DashboardWriteRepository {
  final Database _database;

  LocalDashboardWriteRepository(this._database);

  @override
  Future<void> saveDashboard(Dashboard dashboard) async {
    try {
      print('\n=== Saving Dashboard to Database ===');
      print('Monto Vencido: ${dashboard.montoVencido}');
      print('Monto No Vencido: ${dashboard.montoNoVencido}');
      print('Monto Adeudado: ${dashboard.montoAdeudado}');
      print('Pedidos Creados: ${dashboard.pedidosCreados}');
      print('Pedidos Parcialmente: ${dashboard.pedidosParcialmente}');
      print('Pedidos Procesados: ${dashboard.pedidosProcesados}');
      print('Clientes Deudores: ${dashboard.clientesDeudores}');
      print('Clientes Solventes: ${dashboard.clientesSolventes}');
      
      final db = _database;
      
      // Verificamos si la tabla existe
      final tableExists = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
        ['dashboard']
      );
      
      if (tableExists.isEmpty) {
        print('Dashboard table does not exist, creating it...');
        await db.execute(Dashboard.createDashboardTable);
        print('Dashboard table created successfully');
      }
      
      // Usamos una transacción para asegurar la integridad de los datos
      await db.transaction((txn) async {
        // Primero eliminamos todos los registros existentes
        await txn.delete('dashboard');
        print('Existing dashboard records deleted');
        
        // Insertamos el nuevo dashboard
        final result = await txn.insert(
          'dashboard',
          dashboard.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        
        print('New dashboard saved with ID: $result');
        
        // Verificamos que los datos se hayan guardado correctamente
        final savedData = await txn.query('dashboard');
        if (savedData.isNotEmpty) {
          final savedDashboard = Dashboard.fromMap(savedData.first);
          print('\n=== Verifying Saved Dashboard Data ===');
          print('Monto Vencido: ${savedDashboard.montoVencido}');
          print('Monto No Vencido: ${savedDashboard.montoNoVencido}');
          print('Monto Adeudado: ${savedDashboard.montoAdeudado}');
          print('Pedidos Creados: ${savedDashboard.pedidosCreados}');
          print('Pedidos Parcialmente: ${savedDashboard.pedidosParcialmente}');
          print('Pedidos Procesados: ${savedDashboard.pedidosProcesados}');
          print('Clientes Deudores: ${savedDashboard.clientesDeudores}');
          print('Clientes Solventes: ${savedDashboard.clientesSolventes}');
        } else {
          print('Warning: No data found after saving');
        }
      });
    } catch (e, stackTrace) {
      print('Error saving dashboard: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
} 