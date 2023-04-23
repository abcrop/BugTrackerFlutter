// library app_helpers;

import 'package:daily_task/app/config/routes/app_pages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';

import '../../constants/app_constants.dart';
import '../../services/AuthService.dart';

// part 'extension.dart';
// part 'type.dart';

/// User cannot go to the dashboard screen if he doesn’t have a login token.
class RouteGuard extends GetMiddleware {
  @override
  int? get priority => 1;

  late AuthService authService;

  @override
  RouteSettings? redirect(String? route) {
    authService = Get.find<AuthService>();
    logger.d("print route $route current route ${Get.currentRoute}");
    if(route == Routes.login && authService.isLoggedIn()) {
      //When User want to goto /login and User is already logged :- redirect to the /home
      return const  RouteSettings(name : Routes.home);
    }

    else if(route == Routes.login && !authService.isLoggedIn()) {
      //When User want to goto /login and User is not logged in :- direct to the /login as a null(so infinite redirect to /login can be prevented)
      return null;
    }

    else if(route != Routes.login && authService.isLoggedIn()) {
      //When User want to goto /other (other than /login) and User is already logged :- direct to the /other ( as a null)
      return null;
    }

    else if(route != Routes.login && !authService.isLoggedIn()) {
      //When User want to goto /other (other than /login) and User is not logged in :- redirect to the /login
      return const  RouteSettings(name : Routes.login);
    }

  }
}
