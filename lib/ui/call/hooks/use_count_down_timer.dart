import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:quiver/async.dart';

Duration useCountdownTimer({
  required Duration duration,
  required Function onTimerEnd,
  required Duration remindThreshold,
  required Function onRemindThresholdReached,
}) {
  final start = duration.inSeconds;
  final remainingTime = useState<Duration>(duration);

  useEffect(() {
    final countdownTimer = CountdownTimer(
      duration,
      const Duration(seconds: 1),
    );

    void startTimer() {
      final sub = countdownTimer.listen(null);
      sub.onData((duration) {
        remainingTime.value =
            Duration(seconds: start - duration.elapsed.inSeconds);
        if (remainingTime.value == remindThreshold) {
          onRemindThresholdReached();
        }
      });

      sub.onDone(() {
        onTimerEnd();
        sub.cancel();
      });
    }

    startTimer();

    return () {
      countdownTimer.cancel();
    };
  }, const []);

  return remainingTime.value;
}
