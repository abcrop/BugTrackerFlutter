library login;

import 'package:daily_task/app/shared_components/project_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

part '../../bindings/login_binding.dart';
part '../../controllers/login_controller.dart';

class LoginScreen extends GetView<LoginController>{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ProjectHeader(child: Text("Login"))
    );
  }

}