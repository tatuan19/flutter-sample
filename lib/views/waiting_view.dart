import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  late YoutubePlayerController _introVideoController;
  late YoutubePlayerController _tutorialVideoController;

  @override
  void initState() {
    _introVideoController = YoutubePlayerController(
      initialVideoId: 'kcJ8ZS87Tdc',
      flags: const YoutubePlayerFlags(mute: true),
    );

    _tutorialVideoController = YoutubePlayerController(
      initialVideoId: 'kcJ8ZS87Tdc',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: true),
    );
    super.initState();
  }

  @override
  void dispose() {
    _introVideoController.dispose();
    _tutorialVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'オンラインで参加',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayerWidget(controller: _introVideoController),
            const RoomInfo(),
            YoutubePlayerWidget(controller: _tutorialVideoController),
          ],
        ),
      ),
    );
  }
}

class RoomInfo extends StatelessWidget {
  const RoomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                Icon(Icons.radio_button_on, color: Colors.green, size: 20.0),
                SizedBox(width: 5.0),
                Text(
                  'ただ今の状況',
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w100,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '待ち時間：約５分',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '待ち人数：男性３名待ち',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class YoutubePlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;

  const YoutubePlayerWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      showVideoProgressIndicator: true,
      bottomActions: [
        ProgressBar(
          isExpanded: true,
          colors: const ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.redAccent,
          ),
        ),
      ],
    );
  }
}
