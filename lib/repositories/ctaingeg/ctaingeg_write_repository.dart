import 'package:syncman_new/models/ctaingeg_model.dart';

abstract class CtaIngrEgrWriteRepository {
  Future<void> updateOrCreate(CtaIngrEgr ctaIngrEgr);
} 