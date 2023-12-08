import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sample/helpers/theme/sizes.dart';
import 'package:sample/helpers/widgets/grey_button.dart';
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
            selectedIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(Icons.home_outlined),
            label: 'オンラインで参加',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.brunch_dining,
              color: Colors.white,
            ),
            icon: Icon(Icons.brunch_dining_outlined),
            label: '店舗で参加',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            icon: Icon(Icons.message_outlined),
            label: 'メッセージ',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
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
      // TODO: Remove animation when floating button appears
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
        child: GreyButton(
            height: ButtonSize.large,
            onPressed: () {
              context.router.push(const WaitingRoute());
            },
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '席に案内してもらう',
                  style: TextStyle(
                    fontSize: FontSize.large,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '(お相手が見つかると、1on1が開始します。)',
                  style: TextStyle(
                    fontSize: FontSize.small,
                    color: Colors.white,
                  ),
                ),
              ],
            )));
  }
}
