part of activity;

class ActivityBinding extends Bindings {
@override
void dependencies() {
  Get.lazyPut(() => ActivityController());
}
}
