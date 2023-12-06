import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/views/waiting_view.dart';

@RoutePage()
class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.green,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'オンラインで参加',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.brunch_dining),
            icon: Icon(Icons.brunch_dining_outlined),
            label: '店舗で参加',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.message),
            icon: Icon(Icons.message_outlined),
            label: 'メッセージ',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'マイページ',
          ),
        ],
      ),
      body: <Widget>[
        const WaitingView(),
        const Text('Index 1: 店舗で参加'),
        const Text('Index 2: メッセージ'),
        const Text('Index 3: マイページ'),
      ][currentPageIndex],
    );
  }
}
