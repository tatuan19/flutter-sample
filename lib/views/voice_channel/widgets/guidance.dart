import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:sample/helpers/animations/fade_and_scale_transition.dart';
import 'package:sample/helpers/theme/sizes.dart';

enum GuidanceStep {
  waiting,
  beginning,
  duringConversation,
  reminder,
  rating,
  ending
}

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
  const BeginningGuidance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FadeAndScaleAnimation(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ]));
  }
}

class DuringConversationGuidance extends StatelessWidget {
  const DuringConversationGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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

class ReminderGuidance extends StatelessWidget {
  const ReminderGuidance({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeAndScaleAnimation(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
    ]));
  }
}

class RatingGuidance extends StatelessWidget {
  const RatingGuidance({super.key, required this.onRatingUpdate});

  final ValueChanged<double> onRatingUpdate;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text(
        '1on1が終了しました\nきなこさんのマナーを評価してください',
        style: TextStyle(
          fontSize: FontSize.large,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30.0),
      RatingBar(
        ratingWidget: RatingWidget(
            empty: const Icon(
              Icons.star_outlined,
              color: Colors.amber,
            ),
            half: const Icon(Icons.star_half, color: Colors.amber),
            full: const Icon(Icons.star, color: Colors.amber)),
        onRatingUpdate: onRatingUpdate,
        initialRating: 3,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        minRating: 1,
        allowHalfRating: true,
        updateOnDrag: true,
      ),
    ]);
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

class TopicRow extends StatelessWidget {
  const TopicRow({super.key, required this.topics});

  final List<String> topics;

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
