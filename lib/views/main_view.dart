import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/views/routes/app_router.gr.dart';
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
      floatingActionButton: buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? buildFloatingActionButton() {
    return currentPageIndex == 0 ? const EnterRoomButton() : null;
  }
}

class EnterRoomButton extends StatelessWidget {
  const EnterRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.router.push(const WaitingRoute());
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  backgroundColor: Colors.grey[700]),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '席に案内してもらう',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '(お相手が見つかると、1on1が開始します。)',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
