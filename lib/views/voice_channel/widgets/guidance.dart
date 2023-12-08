import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sample/helpers/theme/sizes.dart';
import 'package:sample/helpers/widgets/outlined_text.dart';

class WaitingGuidance extends StatelessWidget {
  const WaitingGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'ただ今待機中です',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 30.0),
      Text(
        '待ち時間：約3分',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      Text(
        '待ち人数：男性2名待ち',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      SizedBox(height: 30.0),
      Text(
        'お客様は2番目にご案内いたします',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      )
    ]);
  }
}

class BeginningGuidance extends StatelessWidget {
  const BeginningGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'まもなく\n1on1が開始します',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 30.0),
      SizedBox(
          height: 70.0,
          child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [Colors.white],
          ))
    ]);
  }
}

class DuringConversationGuidedance extends StatelessWidget {
  final int remainTime;

  const DuringConversationGuidedance({super.key, required this.remainTime});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TimeCounter(remainTime: remainTime),
      const SizedBox(height: 20.0),
      const Text(
        '1on1が開始しました\nまずは自己紹介をしましょう',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30.0),
      TopicRow(topics: suggestedTopics['start']!)
    ]);
  }
}

class TimeReminderGuidance extends StatelessWidget {
  final int remainTime;

  const TimeReminderGuidance({super.key, required this.remainTime});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TimeCounter(remainTime: remainTime),
      const SizedBox(height: 20.0),
      const Text(
        '残り時間、\n1on1を楽しみましょう',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30.0),
      TopicRow(topics: suggestedTopics['end']!)
    ]);
  }
}

class RatingGuidance extends StatelessWidget {
  const RatingGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center, children: []);
  }
}

class EndingGuidance extends StatelessWidget {
  const EndingGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
        mainAxisAlignment: MainAxisAlignment.center, children: []);
  }
}

class TimeCounter extends StatelessWidget {
  final int remainTime;

  const TimeCounter({super.key, required this.remainTime});

  @override
  Widget build(BuildContext context) {
    var minutes = remainTime ~/ 60;
    var seconds = (remainTime % 60);
    Color timeColor = remainTime < 180 ? Colors.red : Colors.white;

    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      const Text(
        '残り時間：',
        style: TextStyle(color: Colors.white),
      ),
      if (remainTime < 180)
        OutlinedText(
          text: '$minutes:$seconds',
          fontWeight: FontWeight.bold,
          textColor: Colors.white,
          borderColor: Colors.red,
        )
      else
        Text(
          '$minutes:$seconds',
          style: TextStyle(
              fontSize: FontSize.small,
              color: timeColor,
              fontWeight: FontWeight.bold),
        )
    ]);
  }
}

class TopicRow extends StatelessWidget {
  final List<String> topics;

  const TopicRow({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: topics
            .map((topic) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(204, 185, 106, 77),
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Text(
                    topic,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: FontSize.small,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ))
            .toList());
  }
}

Map<String, List<String>> suggestedTopics = {
  'start': ['呼んでほしい名前', '仕事', '興味', 'マイブーム'],
  'end': ['休日に行ったところ', '恋人や結婚相手に求める条件']
};
