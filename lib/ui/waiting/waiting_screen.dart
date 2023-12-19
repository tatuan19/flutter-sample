import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sample/common/themes/sizes.dart';
import 'package:sample/common/widgets/buttons/scroll_arrow_button.dart';
import 'package:sample/common/widgets/buttons/grey_button.dart';
import 'package:sample/common/widgets/custom_app_bar.dart';
import 'package:sample/ui/router/app_router.gr.dart';
import 'package:sample/ui/router/router_key.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'use_youtube_player_controller.dart';

@RoutePage()
class WaitingScreen extends HookWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();
    final dateEnded = useState(false);
    final shouldScrollDown = useState(true);

    final introVideoController = useYoutubePlayerController(
      initialVideoId: 'q7y4av-Dr4I',
      flags: const YoutubePlayerFlags(mute: true, captionLanguage: 'ja'),
    );

    final fullScreenVideoController = useYoutubePlayerController(
      initialVideoId: 'q7y4av-Dr4I',
      flags: const YoutubePlayerFlags(autoPlay: false, captionLanguage: 'ja'),
    );

    void scrollToTop() {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }

    void scrollToBottom() {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }

    final isWaitingRoute = context.router.current.name == WaitingRoute.name;
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        kBottomNavigationBarHeight;

    return Scaffold(
      appBar: const CustomAppBar(title: Text('オンラインで参加')),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideoPlayer(controller: introVideoController),
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
                      child: Stack(children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: ScrollArrowButton(
                          onPressed: () {
                            shouldScrollDown.value
                                ? scrollToBottom()
                                : scrollToTop();
                            shouldScrollDown.value = !shouldScrollDown.value;
                          },
                          size: 80.0,
                          color: Colors.white),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: VideoPlayer(controller: fullScreenVideoController),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: !dateEnded.value
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20.0),
                                      child: GreyButton(
                                        height: ButtonHeight.large,
                                        onPressed: () async {
                                          final result = await context.router
                                              .push(const CallRoute());

                                          if (result != null &&
                                              result == RouterKey.dateEnded) {
                                            dateEnded.value = true;
                                          }
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
                                      const Expanded(
                                        child: Text(
                                          '今後もスキップする（後で設定画面から変更できます）',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: FontSize.small,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : const Padding(
                                padding: EdgeInsets.symmetric(vertical: 100),
                                child: Text('THANK YOU!',
                                    style: TextStyle(
                                      fontSize: FontSize.huge,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ))))
                  ])))
          ],
        ),
      ),
    );
  }
}

class VideoPlayer extends HookWidget {
  const VideoPlayer({super.key, required this.controller});

  final YoutubePlayerController controller;

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
