import 'package:auto_route/auto_route.dart';
import 'package:rlg/presentation/routes/router.gr.dart';

// **********************
// Old Auto route Syntax:
// **********************
/*@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, initial: true),
    AutoRoute(page: SignUpPage, initial: false),
    AutoRoute(page: HomePage , initial: false),
    AutoRoute(page: TodoDetail, initial: false, fullscreenDialog:  true)
  ]

)
class $AppRouter {}*/

// **********************
// New Auto route Syntax:
// **********************
@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType =>
      const RouteType.material(); //.cupertino, .adaptive ..etc

  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: HomeRoute.page,),
    AutoRoute(page: SignUpRoute.page),
    AutoRoute(page: SplashRoute.page,  path: '/'),
    AutoRoute(page: TomorrowQuestDetail.page),
    AutoRoute(page: ActivityRoute.page)
  ];
}