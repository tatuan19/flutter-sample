// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:sample/views/login_view.dart' as _i1;
import 'package:sample/views/main_view.dart' as _i2;
import 'package:sample/views/register_view.dart' as _i3;
import 'package:sample/views/voice_channel/voice_channel_view.dart' as _i4;
import 'package:sample/views/waiting_view.dart' as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.LoginView(),
      );
    },
    MainRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MainView(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.RegisterView(),
      );
    },
    VoiceChatRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.VoiceChannelView(),
      );
    },
    WaitingRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.WaitingView(),
      );
    },
  };
}

/// generated route for
/// [_i1.LoginView]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MainView]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.RegisterView]
class RegisterRoute extends _i6.PageRouteInfo<void> {
  const RegisterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.VoiceChannelView]
class VoiceChatRoute extends _i6.PageRouteInfo<void> {
  const VoiceChatRoute({List<_i6.PageRouteInfo>? children})
      : super(
          VoiceChatRoute.name,
          initialChildren: children,
        );

  static const String name = 'VoiceChatRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.WaitingView]
class WaitingRoute extends _i6.PageRouteInfo<void> {
  const WaitingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          WaitingRoute.name,
          initialChildren: children,
        );

  static const String name = 'WaitingRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
