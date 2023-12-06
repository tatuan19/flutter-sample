import 'package:agora_uikit/agora_uikit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class VideoChatView extends StatefulWidget {
  const VideoChatView({super.key});

  @override
  State<VideoChatView> createState() => _VideoChatViewState();
}

class _VideoChatViewState extends State<VideoChatView> {
  final AgoraClient client = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: "f3de06bbd5204c9ea642ae7e8516394e",
        channelName: "test",
      ),
      enabledPermission: [
        Permission.camera,
        Permission.microphone,
      ]);

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        AgoraVideoViewer(client: client),
        AgoraVideoButtons(client: client)
      ],
    )));
  }
}

