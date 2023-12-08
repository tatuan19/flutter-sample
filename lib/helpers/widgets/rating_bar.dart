import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';

class CustomRatingBar extends StatefulWidget {
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
  _CustomRatingBarState createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.maxRating,
        (index) => InkWell(
          onTap: () {
            double newRating = ((index + 1) + widget.minRating).toDouble();
            setState(() {
              rating = newRating;
            });
            widget.onRatingUpdate(newRating);
          },
          child: Column(children: [
            Icon(
              (index + 1) + widget.minRating <= rating
                  ? widget.ratedIcon
                  : widget.unratedIcon,
              size: widget.itemSize,
              color: (index + 1) + widget.minRating <= rating
                  ? widget.ratedColor
                  : widget.unratedColor,
            ),
            const SizedBox(height: 5.0),
            if (index == 0)
              Text(
                '良くない',
                style: TextStyle(
                    fontSize: FontSize.small, color: widget.unratedColor),
              ),
            if (index + 1 == widget.maxRating)
              Text(
                '良い',
                style: TextStyle(
                    fontSize: FontSize.small, color: widget.unratedColor),
              ),
          ]),
        ),
      ),
    );
  }
}
