import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/helpers/widgets/sound_wave.dart';
import 'package:sample/views/voice_channel/widgets/bottom_action_bar.dart';
import 'package:sample/views/voice_channel/widgets/guidance.dart';

@RoutePage()
class VoiceChannelView extends StatefulWidget {
  const VoiceChannelView({super.key});

  @override
  State<VoiceChannelView> createState() => _VoiceChannelViewState();
}

class _VoiceChannelViewState extends State<VoiceChannelView> {
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  int remainTime = 0;
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
                          SizedBox(height: 200, child: _guidedance()),
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

  Widget _guidedance() {
    if (!_isJoined) {
      return const WaitingGuidance();
    } else if (_remoteUid == null) {
      return const BeginningGuidance();
    } else if (remainTime > 180) {
      return DuringConversationGuidedance(remainTime: remainTime);
    } else if (remainTime > 0) {
      return TimeReminderGuidance(remainTime: remainTime);
    } else {
      return const EndingGuidance();
    }
  }
}

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
