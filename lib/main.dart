import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:syncman_new/database/app_database.dart';
import 'package:syncman_new/helper/shared_prefs_helper.dart';
import 'package:syncman_new/providers/app_providers.dart';
import 'package:syncman_new/routes/routes.dart';
import 'package:syncman_new/services/app/app_lifecycle_manager.dart';
import 'package:syncman_new/services/sync/workmanager_initializer.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/utils/shared_prefs_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setAppOpenFlag(true); // Marcar app como abierta

  // Load evnironment variables
  await dotenv.load(fileName: ".env");

  // Inicializar Workmanager
  await WorkmanagerInitializer.initialize();

  bool hasAuthToken = await containsKey('authToken');

  runApp(
    AppProviders(
      database: AppDatabase.instance,
      child: AppLifecycleManager(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          initialRoute: hasAuthToken ? Routes.login : Routes.welcome,
          onGenerateRoute: Routes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}
