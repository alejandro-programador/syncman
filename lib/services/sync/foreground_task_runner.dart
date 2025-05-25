import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/services/sync/sync_manager.dart';
import 'package:syncman_new/utils/load_data_utils.dart';

void startForegroundTask() {
  Timer.periodic(
      const Duration(minutes: 2),
      (timer) async {
    final prefs = await SharedPreferences.getInstance();
    final lastDateStr = prefs.getString('lastLoadDataDate');

    // if (lastDateStr != null) {
    //   final lastDate = DateFormat('dd/MM/yyyy HH:mm:ss').parse(lastDateStr);
    //   final difference = DateTime.now().difference(lastDate);

    //   // if (difference.inMinutes < LoadDataUtils.syncDataDifferenceMinutes) {
    //   //   return;
    //   // }
    // }

    await runHeavyTask();
  });
}

Future<void> runHeavyTask() async {
  try {
    final syncManager = SyncManager();
    await syncManager.init();
    await syncManager.syncAll();
  } catch (e) {
    // Error logging removed
  }
}
