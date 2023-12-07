import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/helpers/theme/size.dart';
import 'package:sample/helpers/widgets/icon_label_button.dart';
import 'package:sample/helpers/widgets/outlined_text.dart';
import 'package:sample/helpers/widgets/sound_wave.dart';

@RoutePage()
class VoiceChatView extends StatefulWidget {
  const VoiceChatView({super.key});

  @override
  State<VoiceChatView> createState() => _VoiceChatViewState();
}

class _VoiceChatViewState extends State<VoiceChatView> {
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  int remainTime = 100;
  late RtcEngine agoraEngine; // Agora engine instance

  @override
  void initState() {
    super.initState();
    setupVoiceSDKEngine();
  }

  @override
  void dispose() async {
    super.dispose();
    await agoraEngine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black.withOpacity(0.2),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 40.0,
            ),
            onPressed: () {
              context.router.pop();
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          SizedBox(height: 200, child: status()),
                          const Padding(
                              padding: EdgeInsets.only(top: 20, bottom: 30),
                              child: UserSoundWave()),
                          const SafeArea(top: false, child: BottomActionBar())
                          // Row(
                          //   children: <Widget>[
                          //     const SizedBox(width: 10),
                          //     Expanded(
                          //       child: ElevatedButton(
                          //         child: const Text("Join"),
                          //         onPressed: () => {joinChannel()},
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: <Widget>[
                          //     const SizedBox(width: 10),
                          //     Expanded(
                          //       child: ElevatedButton(
                          //         child: const Text("Leave"),
                          //         onPressed: () => {leave()},
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      )),
                )),
          ]),
        ));
  }

  Future<void> setupVoiceSDKEngine() async {
    // retrieve or request microphone permission
    await [Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(
        const RtcEngineContext(appId: "f3de06bbd5204c9ea642ae7e8516394e"));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void joinChannel() async {
    // Set channel options including the client role and channel profile
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    await agoraEngine.joinChannel(
      token:
          "007eJxTYGA0W97P6Z0aYfs/v9RNVt47KMOqPv6fnIx2yb8t849Jz1dgSDNOSTUwS0pKMTUyMEm2TE00MzFKTDVPtTA1NDO2NEk1yC5MbQhkZFA7foiFkQECQXwWhpLU4hIGBgBaJByq",
      channelId: "test",
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  Widget status() {
    List<Widget> content = [];

    if (!_isJoined) {
      content = [
        const Text(
          'ただ今待機中です',
          style: TextStyle(
            fontSize: FontSize.large,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30.0),
        const Text(
          '待ち時間：約3分',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const Text(
          '待ち人数：男性2名待ち',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 30.0),
        const Text(
          'お客様は2番目にご案内いたします',
          style: TextStyle(
            fontSize: FontSize.large,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        )
      ];
    } else if (_remoteUid == null) {
      content = [
        const Text(
          'まもなく\n1on1が開始します',
          style: TextStyle(
            fontSize: FontSize.large,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30.0),
        const SizedBox(
            height: 70.0,
            child: LoadingIndicator(
              indicatorType: Indicator.ballSpinFadeLoader,
              colors: [Colors.white],
            ))
      ];
    } else if (remainTime > 180) {
      content = [
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
        TopicRow(topics: suggestedTopics['start']!),
      ];
    } else if (remainTime > 0) {
      content = [
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
      ];
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: content);
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

class UserSoundWave extends StatelessWidget {
  const UserSoundWave({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/my_avatar.png'),
        ),
        SizedBox(height: 60.0, child: SoundWave()),
        CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/sample_avatar.png'),
        )
      ],
    );
  }
}

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MoreOptionsButton(),
        ReactionButton(),
        MicroOffButton(),
        SpeakerOffButton(),
      ],
    );
  }
}

class MoreOptionsButton extends StatelessWidget {
  const MoreOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconLabelButton(
      icon: Icons.more_vert,
      label: 'その他',
      onPressed: () {},
    );
  }
}

class ReactionButton extends StatelessWidget {
  const ReactionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconLabelButton(
      icon: Icons.add_reaction_outlined,
      label: 'リアクション',
      onPressed: () {},
    );
  }
}

class MicroOffButton extends StatefulWidget {
  const MicroOffButton({super.key});

  @override
  State<MicroOffButton> createState() => _MicroOffButtonState();
}

class _MicroOffButtonState extends State<MicroOffButton> {
  @override
  Widget build(BuildContext context) {
    return IconLabelButton(
      icon: Icons.mic,
      label: 'マイクをオフ',
      onPressed: () {},
    );
  }
}

class SpeakerOffButton extends StatefulWidget {
  const SpeakerOffButton({super.key});

  @override
  State<SpeakerOffButton> createState() => _SpeakerOffButtonState();
}

class _SpeakerOffButtonState extends State<SpeakerOffButton> {
  @override
  Widget build(BuildContext context) {
    return IconLabelButton(
      icon: Icons.volume_up,
      label: 'スピーカーをオフ',
      onPressed: () {},
    );
  }
}
