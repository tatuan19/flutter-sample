import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: MainRoute.page, initial: false),
        AutoRoute(page: WaitingRoute.page),
        AutoRoute(page: VoiceChatRoute.page, initial: true),
      ];
}
