import 'package:daily_task/app/features/views/user/user_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../features/views/activity/activity_screen.dart';
import '../../features/views/bug/bug_screen.dart';
import '../../features/views/home/home_screen.dart';
import '../../features/views/login/login_screen.dart';
import '../../features/views/project/project_screen.dart';
import '../../features/views/signup/signup_screen.dart';
import '../../utils/helpers/route_guard.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.home;

  static const unknownRoute = Routes.unknownRoute;

  static final routes = [
    //Home Screen
    GetPage(
      name: _Paths.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //User Screen
    GetPage(
      name: _Paths.user,
      page: () => const UserScreen(),
      binding: UserBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Bug Screen
    GetPage(
      name: _Paths.bug,
      page: () => const BugScreen(),
      binding: BugBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Project Screen
    GetPage(
      name: _Paths.project,
      page: () => const ProjectScreen(),
      binding: ProjectBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Activity Screen
    GetPage(
      name: _Paths.activity,
      page: () => const ActivityScreen(),
      binding: ActivityBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Login Screen
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Signup Screen
    GetPage(
      name: _Paths.signup,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
      preventDuplicates: true,
    ),

    //Logout text
    GetPage(
        name: _Paths.logout,
        // preventDuplicates: true,
        page: () => const Center(
            child: Text("Development onGoing for logout....",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        transition: Transition.noTransition,
        middlewares: [
          RouteGuard(),
        ]),

    //Unknown Route Screen
    GetPage(
      name: _Paths.unknownRoute,
      page: () => Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Color.fromARGB(231, 194, 24, 90),
        ),
        child: const SizedBox(),
      ),
      transition: Transition.noTransition,
      middlewares: [
        RouteGuard(),
      ],
    ),
  ];
}
