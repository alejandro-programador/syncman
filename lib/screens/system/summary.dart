import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';
import 'package:syncman_new/widgets/notification.dart';

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "Resumen",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsView()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.5,
              children: [
                _buildSummaryCard(context, 'NO VENCIDO', 'US\$ 31,092', Colors.white),
                _buildSummaryCard(context, 'VENCIDO', 'US\$ 31,092', Colors.red.shade100),
                _buildSummaryCard(context, '31-60', 'US\$ 0', Colors.white),
                _buildSummaryCard(context, '61-90', 'US\$ 6.876.872', Colors.white),
                _buildSummaryCard(context, '0-30', 'US\$ 0', Colors.white),
                _buildSummaryCard(context, '90+', 'US\$ 6.890.86', Colors.white),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: _buildListItem(context, isHeader: true),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: _buildListItem(context),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context, String title, String amount, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppTheme.greyColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(amount,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  )),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context, {bool isHeader = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        shape: BoxShape.rectangle,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(isHeader ? 'CLIENTE' : 'CENTRO GASTRONÓMICO\nMISTER CHEF C.A.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isHeader ? AppTheme.greyColor : Colors.black,
                      )),
            ],
          ),
          Text(isHeader ? 'DÍAS TRANSCURRIDOS' : '105',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isHeader ? AppTheme.greyColor : Colors.black,
                  )),
          Text(isHeader ? 'MONTO' : 'US\$ 1.239,07',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: isHeader ? AppTheme.greyColor : Colors.black,
                  )),
        ],
      ),
    );
  }
}
