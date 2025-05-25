import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/client_card.dart';

import 'package:syncman_new/widgets/notification.dart';

class InactiveClientView extends StatelessWidget {
  const InactiveClientView({super.key});

  @override
  Widget build(BuildContext context) {
    // String selectedCategory = "Todos";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Reporte de clientes inactivos", style: TextStyle(fontSize: 18)),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png', width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        color: AppTheme.greyBackground,
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 10, // Example list count
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, "/client-profile");
                    },
                    child: ClientCard(
                        title: "W-1467864",
                        description: index % 2 == 0
                            ? "Centro Gastronómico Mister Chef C.A."
                            : "Centro Gastronómico Mister Chef C.A.",
                        subtitle: index % 2 == 0
                            ? 'Ha comprado recientemente'
                            : 'Última compra hace un mes',
                        amount: "\$1,956.00",
                        articles: "70",
                        isRecent: index % 2 == 0,
                        daysAgo: "Hace dos días",
                        isInactive: true),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
