// import 'package:workmanager/workmanager.dart';
import 'package:syncman_new/utils/load_data_utils.dart';
import 'package:syncman_new/services/sync/background_tasks.dart';

class WorkmanagerInitializer {
  static Future<void> initialize() async {
    // Inicializa Workmanager
    // await Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: true, // ! poner en false para producción
    // );

    // // Load data periodically
    // await Workmanager().registerPeriodicTask(
    //   "loadData", // ID único
    //   "loadData",
    //   frequency: const Duration(minutes: LoadDataUtils.workManagerTaskFrequencyMinutes),
    //   initialDelay: const Duration(minutes: 5), // tiempo de espera la primera vez
    //   constraints: Constraints(
    //     networkType: NetworkType.connected,
    //   ),
    // );
  }
}
