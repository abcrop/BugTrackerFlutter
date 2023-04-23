part of project;

class ProjectController extends GetxController{
  var projectMock = MockProject();
  late Responsive screenType;
  var rowsPerPage = dataRowPerPage.obs;
  final String tag = "Project";
  final isLoadingGrid = false.obs;
  final _projectResponseList = <ProjectListDataResponse>[].obs;
  final _tempProjectResponseList = <ProjectListDataResponse>[];

  final TextEditingController searchController = TextEditingController();
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  void onInit() {
    super.onInit();
    screenType = Responsive.desktop;
    _getAllProjectResponses();
  }

  _getAllProjectResponses() {
    isLoadingGrid(true);
    _projectResponseList.clear();
    _tempProjectResponseList.clear();

    _projectResponseList(projectMock.listOfProjectListResponse!);
    _tempProjectResponseList.addAll(_projectResponseList.value);
    isLoadingGrid(false);
  }

  _onSearch() {
    isLoadingGrid(true);

    if (searchController.text.isEmpty) {
      logger.d("empty text $_tempProjectResponseList");
      _projectResponseList.clear();
      _projectResponseList.assignAll(_tempProjectResponseList);

      isLoadingGrid(false);
      return;
    }

    if (searchController.text.isNotEmpty) {
      _projectResponseList.clear();
      _tempProjectResponseList.forEach((project) {
        if (project.project!.name!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          _projectResponseList.add(project);
        }
      });
      isLoadingGrid(false);
    }
  }

  deleteThisProject(String? id){

  }

  @override
  void onClose() {
    // searchController.dispose();
    // firstCollectionListener.cancel();
    // nextCollectionListener.cancel();
    super.onClose();
  }

  void openDrawer() {
    // context.rootAncestorStateOfType(TypeMatcher<ScaffoldState>());
    if (scafoldKey.currentState != null) {
      scafoldKey.currentState!.openDrawer();
    }
  }
}

class AddEditProjectController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final String _tag = "Project";
  late final Project? project;
  var isAdd = false.obs;
  var popupTitle = "".obs;

  var pickedPhoto = PlatformFile(name: "", size: 0).obs;
  var uploadedPhotoUrl = "".obs;
  var uploadedProjectId = "";
  final isSameImage = false.obs;
  final isUploadImageLoading = false.obs;
  FilePickerResult? filePickerResult;

  final isLoading = false.obs;

  final isPasswordVisible = false.obs;
  final isCPasswordVisible = false.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref().child("profile_images");

  AddEditProjectController(this.project);


  @override
  void onInit() {
    super.onInit();

    if (project == null) {
      isAdd(true);
      popupTitle("Add Project");
    } else {
      popupTitle("Edit Project");
      uploadedProjectId = project!.id!;
      nameController.text = project!.name!;
      descriptionController.text = project!.description!;
      uploadedPhotoUrl(project!.image!);
    }
  }

  void pickImage() async {
    isUploadImageLoading(true);
    try {
      filePickerResult =
      await TaskPlannerFilePicker.FilePicker.platform.pickFiles(
        type: TaskPlannerFilePicker.FileType.image,
        allowMultiple: false,
        withReadStream: false,
        withData: true,
        lockParentWindow: false,
        allowCompression: true,
        onFileLoading: (TaskPlannerFilePicker.FilePickerStatus status) =>
            logger.d("$_tag :=> $status }"),
        //If type: FileType.custom, these are needed
        // allowedExtensions: [
        //   'png',
        //   'jpg',
        //   'jpeg',
        //   'gif',
        //   'heic',
        // ],
      );
      if (filePickerResult!.files.first.size > 512000) {
        userSnackBar(description: "Image size must be below 500 KB");
        return;
      }
      if (filePickerResult!.files.first.name == pickedPhoto.value.name) {
        isSameImage(true);
        userSnackBar(description: "This content is already selected.");
        return;
      }
      //Clear image url from the firebase, So it's not shown after image is picked
      uploadedPhotoUrl("");
      pickedPhoto(filePickerResult!.files.first);
      logger.d("print picked photo ${pickedPhoto.value}");
      logger.d("file picker result ${filePickerResult!}");
    } on PlatformException catch (e) {
      isUploadImageLoading(false);
      logger.d("$_tag : => ${e.message}");
    } catch (e) {
      isUploadImageLoading(false);
      logger.d("$_tag : => ${e.toString()}");
    } finally {
      isUploadImageLoading(false);
      // logger.d("${TAG} : => ${_pickedPhoto}");
    }
  }

  _uploadImage() async {
    isUploadImageLoading(true);

    String fileName = pickedPhoto.value.name;
    final extension = fileName.split(".").last;
    // Uint8List compressedImageBytes = await compressImageAsync(pickedPhoto.value.bytes!);
    Uint8List compressedImageBytes = pickedPhoto.value.bytes!;
    final imageId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storageRef.child("${imageId}_$fileName");
    final uploadAdminProfile = ref.putData(compressedImageBytes!,
        SettableMetadata(contentType: 'image/$extension'));

    uploadAdminProfile.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.success:
          uploadedPhotoUrl(await taskSnapshot.ref.getDownloadURL());
          isUploadImageLoading(false);
          logger.d(
              "successful image upload imageName $fileName , url ${uploadedPhotoUrl.value}");

          // Update Previous Image Url
          // FirebaseFirestore.instance
          //     .collection(FireConstants.colAdmin)
          //     .doc(uploadedProjectId)
          //     .update({
          //   "image":
          //   uploadedPhotoUrl.value.isNotEmpty ? uploadedPhotoUrl.value : ""
          // });
          break;
        case TaskState.error:
          logger.d("photo upload failed");
          userSnackBar(
              description: "Something went wrong while uploading image.");
          isUploadImageLoading(false);
          break;
        case TaskState.paused:
          logger.d("image uploading paused");
          break;
        case TaskState.running:
          logger.d("image uploading...");
          break;
        case TaskState.canceled:
          isUploadImageLoading(false);
          break;
      }
    });
  }

  userSnackBar({String? title = "User Screen", String? description}) {
    Get.snackbar(
      title!,
      description!,
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.8),
      maxWidth: 500,
      margin: const EdgeInsets.symmetric(vertical: kSpacing),
    );
  }

  addProject() {

  }

  editProject() {
    Map<String, dynamic> map = {};

    if (project!.name != nameController.text) {
      map[SpringBootKeys.fullName] = nameController.text;
    }
    if (project!.description != descriptionController.text) {
      map[SpringBootKeys.email] = descriptionController.text;
    }

    if(pickedPhoto.value.name.isNotEmpty) {
      map[SpringBootKeys.image] = "";
    }

    if (map.isNotEmpty) {}
  }

  resetFields() {
    nameController.text = "";
    descriptionController.text = "";
  }
}


class MockProject {
  List<Project> listOfProject = [
    Project(id: "1", name: "Connect Ips", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "2", name: "Esewa", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680369300000 ) ,
    Project(id: "3", name: "Google", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680362100000 ) ,
    Project(id: "4", name: "Microsoft Teams", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "5", name: "Zoom App", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "6", name: "Khalti", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "7", name: "Developer1", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "8", name: "Nas Daily", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "9", name: "T1", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "10", name: "Triple Hemegony", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "11", name: "Porn Blocker", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
    Project(id: "12", name: "Money Tracker", description: "It's a bright invention that allows everyone to transfer money fast.", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",dateCreated: 1680988500000 ) ,
  ];

  List<ProjectListDataResponse> listOfProjectListResponse = [];

  MockProject() {
    listOfProjectListResponse = [
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),
      ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),ProjectListDataResponse(
          openBugs: 9,
          closedBugs: 10,
          majorBugs: 3,
          criticalBugs: 2,
          mediumBugs: 1,
          minorBugs: 1,
          trivialBugs: 2,
          project: listOfProject[Random().nextInt(12)]
      ),







    ];
  }
}