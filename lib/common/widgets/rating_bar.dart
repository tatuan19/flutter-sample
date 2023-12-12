import 'package:flutter/material.dart';
import 'package:sample/common/themes/sizes.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CustomRatingBar extends HookWidget {
  const CustomRatingBar({
    super.key,
    this.maxRating = 5,
    this.minRating = 0,
    required this.initialRating,
    required this.itemSize,
    required this.ratedIcon,
    required this.unratedIcon,
    required this.ratedColor,
    required this.unratedColor,
    required this.onRatingUpdate,
  });

  final int maxRating;
  final int minRating;
  final double initialRating;
  final double itemSize;
  final IconData ratedIcon;
  final IconData unratedIcon;
  final Color ratedColor;
  final Color unratedColor;
  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    final rating = useState<double>(initialRating);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        maxRating,
        (index) => InkWell(
          onTap: () {
            final newRating = (index + 1 + minRating).toDouble();
            rating.value = newRating;
            onRatingUpdate(newRating);
          },
          child: Column(
            children: [
              Icon(
                (index + 1 + minRating) <= rating.value
                    ? ratedIcon
                    : unratedIcon,
                size: itemSize,
                color: (index + 1 + minRating) <= rating.value
                    ? ratedColor
                    : unratedColor,
              ),
              const SizedBox(height: 5.0),
              if (index == 0)
                Text(
                  '良くない',
                  style:
                      TextStyle(fontSize: FontSize.small, color: unratedColor),
                ),
              if (index + 1 == maxRating)
                Text(
                  '良い',
                  style:
                      TextStyle(fontSize: FontSize.small, color: unratedColor),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
