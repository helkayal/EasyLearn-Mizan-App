import 'package:flutter/material.dart';

class PercentageCircle extends StatelessWidget {
  final double percentage;
  final double amount;

  const PercentageCircle({
    super.key,
    required this.percentage,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            scale: 4,
            child: CircularProgressIndicator(
              value: percentage,
              strokeWidth: 3,
              backgroundColor: Theme.of(
                context,
              ).colorScheme.surface.withValues(alpha: 0.3),
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${(percentage * 100).toInt()}%",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                amount.toStringAsFixed(0),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
