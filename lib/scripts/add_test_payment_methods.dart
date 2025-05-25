import 'package:syncman_new/models/collect_payment_method.dart';
import 'package:syncman_new/repositories/collect_payment_method/local_collect_payment_method_write_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<void> main() async {
  // Initialize database
  final database = openDatabase(
    join(await getDatabasesPath(), 'syncman.db'),
    onCreate: (db, version) async {
      await db.execute(CollectPaymentMethod.createPaymentMethodTable);
    },
    version: 1,
  );

  final repository = LocalCollectPaymentMethodWriteRepository(database);

  // Create first payment method with cuenta = true
  final paymentMethod1 = CollectPaymentMethod(
    id: '1',
    descripcion: 'Método de pago con cuenta',
    cuenta: true,
    sincronizado: false,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  // Create second payment method with cuenta = false
  final paymentMethod2 = CollectPaymentMethod(
    id: '2',
    descripcion: 'Método de pago sin cuenta',
    cuenta: false,
    sincronizado: false,
    isDeleted: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  try {
    await repository.create(paymentMethod1);
    await repository.create(paymentMethod2);
    print('Test payment methods added successfully!');
  } catch (e) {
    print('Error adding test payment methods: $e');
  }
} 