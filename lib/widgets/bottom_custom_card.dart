import 'package:flutter/material.dart';
import 'package:syncman_new/theme/theme.dart';

class BottomCustomCard extends StatefulWidget {
  final String title;
  final String amount;
  final Color? color;
  final bool? arrowNext;

  const BottomCustomCard(
      {super.key,
      required this.title,
      required this.amount,
      this.color,
      this.arrowNext});

  @override
  State<BottomCustomCard> createState() => _BottomCustomCardState();
}

class _BottomCustomCardState extends State<BottomCustomCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppTheme.greyColor, fontWeight: FontWeight.w600),
          ),
          Text(
            '\$${widget.amount}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: widget.color ?? Colors.black),
          ),
        ]),
        if (widget.arrowNext == true)
          const Row(
            children: [
              SizedBox(width: 40),
              Icon(
                Icons.arrow_right_outlined,
                size: 30,
              ),
            ],
          )
      ],
    );
  }
}
