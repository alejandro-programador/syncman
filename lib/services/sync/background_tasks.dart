import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/services/sync/sync_manager.dart';
// import 'package:workmanager/workmanager.dart';

Map<String, Future<void> Function()> taksMap = {
  'loadData': loadData,
};

void callbackDispatcher() {
  // Workmanager().executeTask((task, inputData) async {
  //   final taskFunction = taksMap[task];
  //   if (taskFunction == null) return Future.value(true);

  //   try {
  //     await taskFunction();
  //   } catch (e) {
  //     return Future.value(false);
  //   }

  //   return Future.value(true);
  // });
}

Future<void> loadData() async {
  final prefs = await SharedPreferences.getInstance();
  final isOpen = prefs.getBool('isAppOpen') ?? false;

  if (isOpen) {
    return;
  }

  final syncManager = SyncManager();
  await syncManager.init();
  await syncManager.syncAll();

  final now = DateTime.now();
  final formattedDate = DateFormat('dd/MM/yyyy HH:mm:ss').format(now);

  await prefs.setString('lastLoadDataDate', formattedDate);
}
