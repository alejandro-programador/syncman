import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncman_new/models/bill_model.dart';
import 'package:syncman_new/providers/bill_selection_provider.dart';
import 'package:syncman_new/repositories/bill/api_bill_read_repository.dart';
import 'package:syncman_new/api/api_service.dart';

class BillService {
  Future<void> loadClientId(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final clientId = prefs.getString('id_cliente_cobro');

      if (clientId != null && clientId.isNotEmpty) {
        final apiBillRepo = ApiBillReadRepository(ApiService());
        final bills = await apiBillRepo.getByClientId(clientId);

        if (context.mounted) {
          final billSelectionProvider = Provider.of<BillSelectionProvider>(context, listen: false);
          billSelectionProvider.setClientBills(bills);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('No se encontró el ID del cliente'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // Error logging removed
    }
  }

  Future<void> clearClientId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('id_cliente_cobro');
  }
} 