import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class NumberedStep extends StatelessWidget {
  final int stepNumber;
  final String title;
  final int stepIndex;
  final int currentStep;

  const NumberedStep({
    super.key,
    required this.stepNumber,
    required this.title,
    required this.stepIndex,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    bool isActive = currentStep == stepIndex;
    return Column(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: isActive ? Colors.blue : Colors.grey,
          child: Text(
            '$stepNumber',
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.black : AppTheme.greyColor,
              ),
        ),
      ],
    );
  }
} 