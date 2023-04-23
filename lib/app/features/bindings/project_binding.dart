part of project;

class ProjectBinding extends Bindings {
@override
void dependencies() {
  Get.lazyPut(() => ProjectController());
}
}
