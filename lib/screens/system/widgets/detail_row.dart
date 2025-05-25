import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  final bool isDropdown;
  final VoidCallback? onTap;

  const DetailRow({
    super.key,
    required this.label,
    required this.value,
    this.isBold = false,
    this.isDropdown = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.greyColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              isDropdown
                  ? GestureDetector(
                      onTap: onTap,
                      child: Row(
                        children: [
                          Text(
                            value,
                            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.keyboard_arrow_right, size: 24),
                        ],
                      ),
                    )
                  : Text(
                      value,
                      style: TextStyle(
                        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
} 