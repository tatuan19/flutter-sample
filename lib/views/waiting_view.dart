import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/views/routes/app_router.gr.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
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
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntroVideoPlayer(),
            RoomInfo(),
            FullScreenVideoPlayer(),
          ],
        ),
      ),
    );
  }
}

class IntroVideoPlayer extends StatefulWidget {
  const IntroVideoPlayer({super.key});

  @override
  State<IntroVideoPlayer> createState() => _IntroVideoPlayerState();
}

class _IntroVideoPlayerState extends State<IntroVideoPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'kcJ8ZS87Tdc',
      flags: const YoutubePlayerFlags(mute: true),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
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

class FullScreenVideoPlayer extends StatefulWidget {
  const FullScreenVideoPlayer({super.key});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  late YoutubePlayerController _controller;
  bool skipVideo = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'kcJ8ZS87Tdc',
      flags: const YoutubePlayerFlags(autoPlay: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return Container(
      height: height,
      color: Colors.black, // Set black background color
      child: Stack(
        alignment: Alignment.center,
        children: [
          YoutubePlayer(
            controller: _controller,
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
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.arrow_downward,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Icon(
                Icons.arrow_downward,
                size: 40.0,
                color: Colors.white,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(children: [
                  ElevatedButton(
                    onPressed: () {
                      _controller.pause();
                      context.router.push(const VideoChatRoute());
                    },
                    child: const Text('説明をスキップする'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                        value: skipVideo,
                        onChanged: (value) {
                          setState(() {
                            skipVideo = value!;
                          });
                        },
                      ),
                      const Text(
                        '今後もスキップする（後で設定画面から変更できます）',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ])),
          )
        ],
      ),
    );
  }
}
