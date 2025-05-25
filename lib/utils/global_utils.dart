// global.dart
library globals;

// Obtener la fecha de hace 30 días
DateTime thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

// Formatear correctamente con 3 decimales y 'Z'
String maxDaysFormatted = "${thirtyDaysAgo.toUtc().toIso8601String().substring(0, 23)}Z";
