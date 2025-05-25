import 'package:flutter/material.dart';
import 'package:syncman_new/widgets/success_message.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return const SuccessMessageView(headerTitle: "Detalle de pedido", showPreview: false);
  }
}
