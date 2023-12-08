import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:sample/helpers/theme/sizes.dart';
import 'package:sample/helpers/widgets/outlined_text.dart';

class CountdownTimerText extends StatefulWidget {
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
  // ignore: library_private_types_in_public_api
  _CountdownTimerTextState createState() => _CountdownTimerTextState();
}

class _CountdownTimerTextState extends State<CountdownTimerText> {
  late CountdownTimer _countdownTimer;
  late int _start;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _start = widget.duration.inSeconds;
    _remainingTime = widget.duration;
    _countdownTimer = CountdownTimer(
      widget.duration,
      const Duration(seconds: 1),
    );
    startTimer();
  }

  @override
  dispose() {
    super.dispose();
    _countdownTimer.cancel();
  }

  void startTimer() {
    var sub = _countdownTimer.listen(null);
    sub.onData((duration) {
      setState(() {
        _remainingTime = Duration(seconds: _start - duration.elapsed.inSeconds);
      });
      if (_remainingTime == widget.remindThreshold) {
        widget.onRemindThresholdReached();
      }
    });

    sub.onDone(() {
      widget.onTimerEnd();
      sub.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes =
        _remainingTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds =
        _remainingTime.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text(
        '残り時間：',
        style: TextStyle(color: Colors.white),
      ),
      if (_remainingTime.compareTo(widget.remindThreshold) <= 0)
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
              fontWeight: FontWeight.bold),
        )
    ]);
  }
}
