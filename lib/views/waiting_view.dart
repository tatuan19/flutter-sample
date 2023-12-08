import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';
import 'package:sample/helpers/widgets/grey_button.dart';
import 'package:sample/views/routes/app_router.gr.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class WaitingView extends StatefulWidget {
  const WaitingView({super.key});

  @override
  State<WaitingView> createState() => _WaitingViewState();
}

class _WaitingViewState extends State<WaitingView> {
  final ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWaitingRoute = context.router.current.name == WaitingRoute.name;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        kBottomNavigationBarHeight;

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
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IntroVideoPlayer(),
            const RoomInfo(),
            if (isWaitingRoute)
              Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('images/background_blur.png'),
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.7),
                        BlendMode.darken,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: height,
                  child: SafeArea(
                      child: Column(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: () {
                          scrollToBottom();
                        },
                        iconSize: 60.0,
                        color: Colors.white,
                        highlightColor: Colors.transparent,
                      ),
                    ),
                    const FullScreenVideoPlayer(),
                    Column(children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20.0),
                          child: GreyButton(
                            height: ButtonSize.large,
                            onPressed: () {
                              context.router.push(const VoiceChatRoute());
                            },
                            child: const Text(
                              '説明をスキップする',
                              style: TextStyle(
                                fontSize: FontSize.large,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          )),
                      Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (value) {},
                            side: const BorderSide(
                                color: Colors.white, width: 2.0),
                          ),
                          const Text(
                            '今後もスキップする（後で設定画面から変更できます）',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: FontSize.small,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    ]),
                  ])))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      initialVideoId: 'u90AN5QpbXE',
      flags: const YoutubePlayerFlags(mute: true, captionLanguage: 'ja'),
    );
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class RoomInfo extends StatelessWidget {
  const RoomInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
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
                  style: TextStyle(
                      fontSize: FontSize.large, fontWeight: FontWeight.bold),
                ),
                Text(
                  '待ち人数：男性３名待ち',
                  style: TextStyle(
                      fontSize: FontSize.large, fontWeight: FontWeight.bold),
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
      initialVideoId: 'u90AN5QpbXE',
      flags: const YoutubePlayerFlags(autoPlay: false, captionLanguage: 'ja'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
      alignment: Alignment.center,
      child: YoutubePlayer(
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
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
