import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample/views/routes/app_router.gr.dart';

import '../enums/menu_action.dart';
import '../utilities/dialogs/logout_dialog.dart';

@RoutePage()
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
                    context.router.replace(const LoginRoute());
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
