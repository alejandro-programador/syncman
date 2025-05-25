import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncman_new/extensions/theme_extension.dart';
import 'package:syncman_new/theme/theme.dart';

class CustomCard extends StatefulWidget {
  final String title;
  final String amount;
  final double percent;
  final String percentText;
  final Widget? bottomCard;
  final VoidCallback? onTap;

  const CustomCard(
      {super.key,
      required this.title,
      required this.amount,
      required this.percent,
      required this.percentText,
      this.bottomCard,
      this.onTap});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: context.textTheme.labelSmall?.copyWith(
                              color: AppTheme.greyColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '\$${widget.amount}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 72,
                    child: CircularPercentIndicator(
                      radius: 40.0,
                      lineWidth: 12,
                      percent: widget.percent,
                      center: Text(
                        widget.percentText,
                        style: context.textTheme.bodyMedium,
                      ),
                      progressColor: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              if (widget.bottomCard != null) widget.bottomCard!,
            ],
          ),
        ),
      ),
    );
  }
}
