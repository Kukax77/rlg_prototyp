// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;
import 'package:rlg/domain/entities/tomorrowquest.dart' as _i8;
import 'package:rlg/presentation/activity/activity_page.dart' as _i1;
import 'package:rlg/presentation/home/home_page.dart' as _i2;
import 'package:rlg/presentation/signup/signup_page/signup_page.dart' as _i3;
import 'package:rlg/presentation/splash/splash_page.dart' as _i4;
import 'package:rlg/presentation/tomorrowquest_detail/tomorrowquests_detail_page.dart'
    as _i5;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    ActivityRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ActivityPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.HomePage(),
      );
    },
    SignUpRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SignUpPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.SplashPage(),
      );
    },
    TomorrowQuestDetail.name: (routeData) {
      final args = routeData.argsAs<TomorrowQuestDetailArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.TomorrowQuestDetail(
          key: args.key,
          tomorrowQuest: args.tomorrowQuest,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.ActivityPage]
class ActivityRoute extends _i6.PageRouteInfo<void> {
  const ActivityRoute({List<_i6.PageRouteInfo>? children})
      : super(
          ActivityRoute.name,
          initialChildren: children,
        );

  static const String name = 'ActivityRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SignUpPage]
class SignUpRoute extends _i6.PageRouteInfo<void> {
  const SignUpRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SignUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i5.TomorrowQuestDetail]
class TomorrowQuestDetail extends _i6.PageRouteInfo<TomorrowQuestDetailArgs> {
  TomorrowQuestDetail({
    _i7.Key? key,
    required _i8.TomorrowQuest? tomorrowQuest,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TomorrowQuestDetail.name,
          args: TomorrowQuestDetailArgs(
            key: key,
            tomorrowQuest: tomorrowQuest,
          ),
          initialChildren: children,
        );

  static const String name = 'TomorrowQuestDetail';

  static const _i6.PageInfo<TomorrowQuestDetailArgs> page =
      _i6.PageInfo<TomorrowQuestDetailArgs>(name);
}

class TomorrowQuestDetailArgs {
  const TomorrowQuestDetailArgs({
    this.key,
    required this.tomorrowQuest,
  });

  final _i7.Key? key;

  final _i8.TomorrowQuest? tomorrowQuest;

  @override
  String toString() {
    return 'TomorrowQuestDetailArgs{key: $key, tomorrowQuest: $tomorrowQuest}';
  }
}
