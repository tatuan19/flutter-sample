import 'package:agora_uikit/agora_uikit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'dart:developer' as devtools show log;

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
    try {
      await client.initialize();
    } catch (e) {
      devtools.log(e.toString());
    }
  }

  @override
  void dispose() {
    client.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        AgoraVideoViewer(client: client),
        Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 400.0,
                color: Colors.grey.withOpacity(0.3),
              ),
            ),
            // Content (within SafeArea)
            const SafeArea(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 400.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'ただ今待機中です',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            '待ち時間：  約3分',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '待ち人数：  男性2名待ち',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'お客様は2番目にご案内いたします',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )))
          ],
        ),
        AgoraVideoButtons(client: client)
      ],
    ));
  }
}
