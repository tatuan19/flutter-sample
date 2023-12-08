import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/helpers/theme/sizes.dart';
import 'package:sample/helpers/widgets/grey_button.dart';
import 'package:sample/helpers/widgets/sound_wave.dart';
import 'package:sample/views/voice_channel/widgets/bottom_action_bar.dart';
import 'package:sample/views/voice_channel/widgets/countdown_timer_text.dart';
import 'package:sample/views/voice_channel/widgets/guidance.dart';

@RoutePage()
class VoiceChannelView extends StatefulWidget {
  const VoiceChannelView({super.key});

  @override
  State<VoiceChannelView> createState() => _VoiceChannelViewState();
}

class _VoiceChannelViewState extends State<VoiceChannelView> {
  int uid = 0; // uid of the local user
  GuidanceStep step = GuidanceStep.duringConversation;
  Duration remainingTime = const Duration(seconds: 10);
  Duration? remindThreshold = const Duration(seconds: 5);

  late RtcEngine agoraEngine;

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
                  height: 500,
                  width: double.maxFinite,
                  color: Colors.black.withOpacity(0.5),
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: _guidedance()),
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
            step = GuidanceStep.waiting;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            step = GuidanceStep.beginning;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            step = GuidanceStep.ending;
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
      step = GuidanceStep.ending;
    });
    agoraEngine.leaveChannel();
  }

  Widget _guidedance() {
    Widget topChild;
    Widget centerChild;
    Widget bottomChild;

    if (step == GuidanceStep.duringConversation ||
        step == GuidanceStep.reminder) {
      topChild = CountdownTimerText(
          duration: remainingTime,
          remindThreshold: remindThreshold,
          onRemindThresholdReached: () {
            setState(() {
              remainingTime = remindThreshold ?? const Duration(seconds: 0);
              remindThreshold = null;
              step = GuidanceStep.reminder;
            });
          },
          onTimerEnd: () {
            setState(() {
              step = GuidanceStep.rating;
            });
          });
    } else {
      topChild = const SizedBox(height: 1);
    }

    switch (step) {
      case GuidanceStep.waiting:
        centerChild = const WaitingGuidance();
      case GuidanceStep.beginning:
        centerChild = const BeginningGuidance();
      case GuidanceStep.duringConversation:
        centerChild = const DuringConversationGuidance();
      case GuidanceStep.reminder:
        centerChild = const ReminderGuidance();
      case GuidanceStep.rating:
        centerChild = RatingGuidance(onRatingUpdate: (rating) {});
      case GuidanceStep.ending:
        centerChild = const EndingGuidance();
      default:
        centerChild = const WaitingGuidance();
    }

    if (step == GuidanceStep.rating) {
      bottomChild = Column(children: [
        GreyButton(
            width: 200,
            onPressed: () {},
            child: const Text(
              '評価する',
              style: TextStyle(
                  fontSize: FontSize.large,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
        const SizedBox(height: 20.0),
        const Text('自分がつけた評価は、相手には分かりません。',
            style: TextStyle(fontSize: FontSize.small, color: Colors.white))
      ]);
    } else if (step == GuidanceStep.ending) {
      bottomChild = const SizedBox(height: 1);
    } else {
      bottomChild = const Column(children: [
        UserSoundWave(),
        SizedBox(height: 30.0),
        BottomActionBar()
      ]);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        topChild,
        centerChild,
        SafeArea(top: false, child: bottomChild)
      ],
    );
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
