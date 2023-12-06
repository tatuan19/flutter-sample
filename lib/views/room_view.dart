import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/routes.dart';
import '../enums/menu_action.dart';
import '../utilities/dialogs/logout_dialog.dart';

class RoomsView extends StatefulWidget {
  const RoomsView({super.key});

  @override
  State<RoomsView> createState() => _RoomsViewState();
}

class _RoomsViewState extends State<RoomsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Room'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (action) async {
              switch (action) {
                case MenuAction.logout:
                  final confirmed = await showLogOutDialog(context);
                  if (confirmed) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute,
                      (_) => false,
                    );
                  }
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: MenuAction.logout,
                child: Text('Logout'),
              ),
            ],
          ),
        ],
      ),
      body: const Column(
        children: <Widget>[
          Text('You are in the room'),
        ],
      ),
    );
  }
}
