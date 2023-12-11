import 'package:flutter/material.dart';
import 'package:sample/common/widgets/buttons/icon_label_button.dart';

class BottomActionBar extends StatelessWidget {
  const BottomActionBar({
    super.key,
    required this.onToggleMute,
    required this.onToggleSpeaker,
    required this.muted,
    required this.speakerOff,
  });

  final bool muted;
  final bool speakerOff;
  final Function onToggleMute;
  final void Function() onToggleSpeaker;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const MoreOptionsButton(),
        const ReactionButton(),
        // Micro button
        IconLabelButton(
          icon: muted ? Icons.mic_off : Icons.mic,
          label: muted ? 'マイクをオン' : 'マイクをオフ',
          onPressed: () {
            onToggleMute();
          },
        ),
        // Speaker button
        IconLabelButton(
          icon: speakerOff ? Icons.volume_off : Icons.volume_up,
          label: speakerOff ? 'スピーカーをオン' : 'スピーカーをオフ',
          onPressed: () {
            onToggleSpeaker();
          },
        ),
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
