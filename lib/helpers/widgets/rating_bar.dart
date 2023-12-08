import 'package:flutter/material.dart';

class CustomRatingBar extends StatefulWidget {
  const CustomRatingBar({
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
      children: List.generate(
        widget.maxRating,
        (index) => InkWell(
          onTap: () {
            double newRating = (index + widget.minRating).toDouble();
            setState(() {
              rating = newRating;
            });
            widget.onRatingUpdate(newRating);
          },
          child: Icon(
            index + widget.minRating <= rating
                ? widget.ratedIcon
                : widget.unratedIcon,
            size: widget.itemSize,
            color: index + widget.minRating <= rating
                ? widget.ratedColor
                : widget.unratedColor,
          ),
        ),
      ),
    );
  }
}
