import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sample/common/themes/sizes.dart';
import 'package:sample/common/widgets/buttons/grey_button.dart';
import 'package:sample/common/widgets/sound_wave.dart';
import 'package:sample/ui/call/widgets/bottom_action_bar.dart';
import 'package:sample/ui/call/widgets/countdown_timer_text.dart';
import 'package:sample/ui/call/widgets/guidance.dart';
import 'package:sample/ui/router/router_key.dart';

import 'dart:developer' as devtools show log;

@RoutePage()
class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late RtcEngine _agoraEngine;

  int uid = 0; // uid of the local user
  int _waitingNumber = 2;
  bool _muted = false;
  bool _speakerOff = false;
  bool _hasVoiceCome = false;
  GuidanceStep _step = GuidanceStep.waiting;

  final appId = "f3de06bbd5204c9ea642ae7e8516394e";
  final token =
      "007eJxTYJDiNWP9Wh6i+c3cpO5mzOwbTLNtPopGCmQ1fQlb8UZr7gEFhjTjlFQDs6SkFFMjA5Nky9REMxOjxFTzVAtTQzNjS5NUrrqy1IZARoYJ7JUMjFAI4rMwlKQWlzAwAADDtR1/";
  final channelId = "test";
  final remainingTime = const Duration(seconds: 100);
  final remindThreshold = const Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    setupVoiceSDKEngine()
        .whenComplete(() => joinChannel())
        .onError((error, stackTrace) => {
              devtools.log(error.toString()),
              devtools.log(stackTrace.toString()),
            });

    waitForMyTurn();
  }

  Future<void> setupVoiceSDKEngine() async {
    // Retrieve or request microphone permission
    await [Permission.microphone].request();

    // Create an instance of the Agora engine
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine.initialize(RtcEngineContext(appId: appId));

    // Enables the audioVolumeIndication
    await _agoraEngine.enableAudioVolumeIndication(
        interval: 250, smooth: 8, reportVad: true);

    // Register the event handler
    _agoraEngine.registerEventHandler(RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() {
            _step = GuidanceStep.waiting;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          setState(() {
            _step = GuidanceStep.duringConversation;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          setState(() {
            _agoraEngine.leaveChannel();
            _step = GuidanceStep.rating;
          });
        },
        onAudioVolumeIndication: (
          RtcConnection connection,
          List<AudioVolumeInfo> speakers,
          int speakerNumber,
          int totalVolume,
        ) {
          setState(() {
            _hasVoiceCome = speakers.any((speaker) => speaker.vad == 1);
          });
        },
        onError: (err, msg) => {
              devtools.log(err.toString()),
              devtools.log(msg.toString()),
            }));
  }

  void joinChannel() async {
    ChannelMediaOptions options = const ChannelMediaOptions(
      clientRoleType: ClientRoleType.clientRoleBroadcaster,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    );

    try {
      await _agoraEngine.joinChannel(
        token: token,
        channelId: channelId,
        options: options,
        uid: uid,
      );
    } catch (e) {
      devtools.log(e.toString());
    }
  }

  void waitForMyTurn() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_waitingNumber == 0) {
        timer.cancel();
        setState(() {
          _step = GuidanceStep.beginning;
        });
      } else {
        setState(() {
          --_waitingNumber;
        });
      }
    });
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _agoraEngine.muteLocalAudioStream(_muted);
  }

  void _onToggerSpeaker() {
    setState(() {
      _speakerOff = !_speakerOff;
    });
    _agoraEngine.setEnableSpeakerphone(!_speakerOff);
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 450,
                    width: double.maxFinite,
                    color: Colors.black.withOpacity(0.5),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
                        child: _guidedance()),
                  )),
            ],
          ),
        ));
  }

  Widget _guidedance() {
    Widget centerChild;
    Widget countdownTimer;
    Widget bottomChild;

    switch (_step) {
      case GuidanceStep.waiting:
        centerChild = WaitingGuidance(waitingNumber: _waitingNumber);
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
        centerChild = WaitingGuidance(waitingNumber: _waitingNumber);
    }

    if (_step == GuidanceStep.duringConversation ||
        _step == GuidanceStep.reminder) {
      countdownTimer = CountdownTimerText(
          duration: remainingTime,
          remindThreshold: remindThreshold,
          onRemindThresholdReached: () {
            setState(() {
              _step = GuidanceStep.reminder;
            });
          },
          onTimerEnd: () {
            setState(() {
              _agoraEngine.leaveChannel();
              _step = GuidanceStep.rating;
            });
          });
    } else {
      countdownTimer = const SizedBox();
    }

    if (_step == GuidanceStep.rating) {
      bottomChild = Column(children: [
        GreyButton(
            width: 200,
            onPressed: () {
              setState(() {
                _step = GuidanceStep.ending;
              });
            },
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
    } else if (_step == GuidanceStep.ending) {
      bottomChild = Row(children: [
        Expanded(
            flex: 3,
            child: GreyButton(
                onPressed: () {
                  context.router.pop(RouterKey.dateEnded);
                },
                child: const Text('終了する',
                    style: TextStyle(
                        fontSize: FontSize.large,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)))),
        const SizedBox(width: 10.0),
        Expanded(
            flex: 6,
            child: GreyButton(
                onPressed: () {
                  context.router.pop();
                },
                child: const Text(
                  '1on1を続ける',
                  style: TextStyle(
                      fontSize: FontSize.large,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )))
      ]);
    } else {
      bool partnerJoined = _step != GuidanceStep.beginning;

      bottomChild = Column(children: [
        UserSoundWave(
            hasVoiceCome: _hasVoiceCome, partnerJoined: partnerJoined),
        const SizedBox(height: 30.0),
        BottomActionBar(
            muted: _muted,
            speakerOff: _speakerOff,
            onToggleMute: _onToggleMute,
            onToggleSpeaker: _onToggerSpeaker)
      ]);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        centerChild,
        countdownTimer,
        SafeArea(top: false, child: bottomChild)
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _agoraEngine.leaveChannel();
  }
}

class UserSoundWave extends StatelessWidget {
  const UserSoundWave(
      {super.key, required this.hasVoiceCome, required this.partnerJoined});

  final bool hasVoiceCome;
  final bool partnerJoined;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage('assets/my_avatar.png'),
        ),
        if (partnerJoined) ...[
          SizedBox(height: 60.0, child: SoundWave(hasVoiceCome: hasVoiceCome)),
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/sample_avatar.png'),
          )
        ]
      ],
    );
  }
}
