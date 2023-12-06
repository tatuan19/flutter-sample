// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:sample/views/login_view.dart' as _i1;
import 'package:sample/views/register_view.dart' as _i2;
import 'package:sample/views/room_view.dart' as _i3;
import 'package:sample/views/waiting_view.dart' as _i4;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterView(),
      );
    },
    RoomsRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RoomsView(),
      );
    },
    WaitingRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.WaitingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RegisterView]
class RegisterRoute extends _i5.PageRouteInfo<void> {
  const RegisterRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RoomsView]
class RoomsRoute extends _i5.PageRouteInfo<void> {
  const RoomsRoute({List<_i5.PageRouteInfo>? children})
      : super(
          RoomsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomsRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.WaitingView]
class WaitingRoute extends _i5.PageRouteInfo<void> {
  const WaitingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          WaitingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitingRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
