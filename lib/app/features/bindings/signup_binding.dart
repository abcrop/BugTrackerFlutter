part of signup;

class SignupBinding extends Bindings {
@override
void dependencies() {
  Get.lazyPut(() => SignupController());
}
}
