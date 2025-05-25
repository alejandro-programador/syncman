import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class TextFieldRow extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const TextFieldRow({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
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
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
              labelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
              hintStyle: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
} 