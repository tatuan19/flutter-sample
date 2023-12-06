// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:sample/views/login_view.dart' as _i1;
import 'package:sample/views/main_view.dart' as _i2;
import 'package:sample/views/register_view.dart' as _i3;
import 'package:sample/views/room_view.dart' as _i4;
import 'package:sample/views/video_chat_view.dart' as _i5;
import 'package:sample/views/waiting_view.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    MainRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MainView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterView(),
      );
    },
    RoomsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.RoomsView(),
      );
    },
    VideoChatRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.VideoChatView(),
      );
    },
    WaitingRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.WaitingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainView]
class MainRoute extends _i7.PageRouteInfo<void> {
  const MainRoute({List<_i7.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RegisterView]
class RegisterRoute extends _i7.PageRouteInfo<void> {
  const RegisterRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.RoomsView]
class RoomsRoute extends _i7.PageRouteInfo<void> {
  const RoomsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          RoomsRoute.name,
          initialChildren: children,
        );

  static const String name = 'RoomsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.VideoChatView]
class VideoChatRoute extends _i7.PageRouteInfo<void> {
  const VideoChatRoute({List<_i7.PageRouteInfo>? children})
      : super(
          VideoChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'VideoChatRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.WaitingView]
class WaitingRoute extends _i7.PageRouteInfo<void> {
  const WaitingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          WaitingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitingRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
