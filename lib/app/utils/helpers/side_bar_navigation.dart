import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../config/routes/app_pages.dart';
import '../../constants/app_constants.dart';

Future<void> _signOut() async {
  logger.d("before sign out ${FirebaseAuth.instance.currentUser}");
  await FirebaseAuth.instance.signOut();
  logger.d("after sign out ${FirebaseAuth.instance.currentUser}");
}

void selectiveScreenNavigation(int selected) async {
  switch (selected) {
    case 0:
      Get.offAndToNamed(
        Routes.home,
      );
      break;

    case 1:
      Get.offAndToNamed(
        Routes.user,
      );
      break;

    case 2:
      Get.offAndToNamed(
        Routes.project,
      );
      break;

    case 3:
      Get.offAndToNamed(
        Routes.bug,
      );
      break;

    case 4:
      Get.offAndToNamed(
        Routes.activity,
      );
      break;

    case 5:
      {
        // await _signOut();
        Get.offAndToNamed(Routes.login,
            arguments: {'message': "Log in first to access dashboard."});
        break;
      }

    default:
      break;
  }
}
