// lib/utils/config.dart

class LoadDataUtils {
  // Frecuencia para el Timer.periodic en minutos
  static const int foregroundTaskFrequencyMinutes = 5; // 1 minuto

  // Frecuencia para la tarea periódica de Workmanager en minutos
  static const int workManagerTaskFrequencyMinutes = 15; // min 15 minutos

  // Diferencia de minutos entre sincronizaciones de workmanager y Timer periodic
  static const int syncDataDifferenceMinutes = 1; // 5 minutos
}
