part of bug;

class BugBinding extends Bindings {
@override
void dependencies() {
  Get.lazyPut(() => BugController());
}
}
