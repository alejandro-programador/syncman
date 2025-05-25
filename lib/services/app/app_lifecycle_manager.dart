import 'package:flutter/material.dart';
import 'package:syncman_new/services/sync/foreground_task_runner.dart';
// import 'package:syncman_new/utils/shared_prefs_helper.dart';
import 'package:syncman_new/helper/shared_prefs_helper.dart';

class AppLifecycleManager extends StatefulWidget {
  final Widget child;

  const AppLifecycleManager({super.key, required this.child});

  @override
  State<AppLifecycleManager> createState() => _AppLifecycleManagerState();
}

class _AppLifecycleManagerState extends State<AppLifecycleManager>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // Registrar el observer
    WidgetsBinding.instance.addObserver(this);
    // Ejecutar didChangeAppLifecycleState cuando la app se inicia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      didChangeAppLifecycleState(AppLifecycleState.resumed);
    });
  }

  @override
  void dispose() {
    // Quitar el observer
    WidgetsBinding.instance.removeObserver(this);
    // Marcar app como cerrada
    setAppOpenFlag(false);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      // App en segundo plano
      setAppOpenFlag(false);
    } else if (state == AppLifecycleState.resumed) {
      // App en primer plano
      setAppOpenFlag(true);
      // 🔁 Ejecutar tarea periódica en foreground
      startForegroundTask();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
