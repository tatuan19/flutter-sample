import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

YoutubePlayerController useYoutubePlayerController({
  required String initialVideoId,
  required YoutubePlayerFlags flags,
}) {
  final controller = useMemoized(
    () => YoutubePlayerController(
      initialVideoId: initialVideoId,
      flags: flags,
    ),
  );

  useEffect(() {
    return () {
      controller.dispose();
    };
  }, const []);

  return controller;
}
