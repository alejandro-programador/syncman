import 'package:flutter/material.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/theme/theme.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Notificaciones",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationsView()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset('assets/icons/notification.png',
                  width: 28, height: 28),
            ),
          )
        ],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Hoy',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const NotificationCard(
                title: 'Cobro #12',
                description: 'Se encuentra procesado de manera exitosa.',
                time: 'Hace 1 hora'),
            const NotificationCard(
                title: 'Cobro #12',
                description: 'Se encuentra procesado de manera exitosa.',
                time: 'Hace 1 hora'),
            const NotificationCard(
                title: 'Cobro #12',
                description: 'Se encuentra procesado de manera exitosa.',
                time: 'Hace 1 hora'),
            const SizedBox(height: 16),
            Text(
              'Ayer',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            const NotificationCard(
                title: 'Cobro #12',
                description: 'Se encuentra procesado de manera exitosa.',
                time: 'Hace 1 hora'),
            const NotificationCard(
                title: 'Cobro #12',
                description: 'Se encuentra procesado de manera exitosa.',
                time: 'Hace 1 hora'),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Borrar todo',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;

  const NotificationCard({
    required this.title,
    required this.description,
    required this.time,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.greyColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  time,
                  style: context.textTheme.labelMedium?.copyWith(
                      color: AppTheme.greyColor, fontFamily: 'Poppins'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
