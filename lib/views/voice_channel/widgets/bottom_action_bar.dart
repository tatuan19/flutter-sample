import 'package:flutter/material.dart';
import 'package:sample/helpers/widgets/icon_label_button.dart';

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
