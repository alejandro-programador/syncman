import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class DepositoField extends StatelessWidget {
  final TextEditingController controller;
  final String? error;

  const DepositoField({
    super.key,
    required this.controller,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppTheme.greyColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Card(
            color: Colors.white,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
                controller: controller,
                readOnly: true,
                enabled: false,
                decoration: InputDecoration(
                  labelText: "Depósito",
                  border: InputBorder.none,
                  labelStyle: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
            child: Text(
              error!,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.red,
                    fontSize: 12,
                  ),
            ),
          ),
      ],
    );
  }
} 