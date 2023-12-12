import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sample/common/themes/sizes.dart';
import 'package:sample/common/widgets/outlined_text.dart';
import 'package:sample/ui/call/hooks/use_count_down_timer.dart';

class CountdownTimerText extends HookWidget {
  const CountdownTimerText({
    super.key,
    required this.duration,
    required this.onTimerEnd,
    required this.remindThreshold,
    required this.onRemindThresholdReached,
  });

  final Duration duration;
  final Function onTimerEnd;
  final Duration remindThreshold;
  final Function onRemindThresholdReached;

  @override
  Widget build(BuildContext context) {
    final remainingTime = useCountdownTimer(
      duration: duration,
      onTimerEnd: onTimerEnd,
      remindThreshold: remindThreshold,
      onRemindThresholdReached: onRemindThresholdReached,
    );

    final minutes =
        remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          '残り時間：',
          style: TextStyle(color: Colors.white),
        ),
        if (remainingTime.compareTo(remindThreshold) <= 0)
          OutlinedText(
            text: '$minutes:$seconds',
            fontWeight: FontWeight.bold,
            textColor: Colors.white,
            borderColor: Colors.red,
          )
        else
          Text(
            '$minutes:$seconds',
            style: const TextStyle(
              fontSize: FontSize.small,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
      ],
    );
  }
}
