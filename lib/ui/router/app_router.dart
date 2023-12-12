import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(
          page: WaitingRoute.page,
        ),
        AutoRoute(page: CallRoute.page),
        AutoRoute(page: PostRoute.page),
      ];
}
