part of bug;

class BugController extends GetxController with GetSingleTickerProviderStateMixin{
  final GlobalKey<SfDataGridState> _bugTableGlobalKey =
  GlobalKey<SfDataGridState>();

  var bugMock = MockBug();
  late BugTableDataSource _bugTableDataSource;
  late Responsive screenType;
  late TabController taskTabController;

  var rowsPerPage = dataRowPerPage.obs;
  final String tag = "Bug";
  final isLoadingDataTable = false.obs;
  final _bugTableList = <Bug>[].obs;
  final _bugBoardList = <Bug>[].obs;
  final _tempBugTableList = <Bug>[];
  final taskCurrentTabIndex = 0.obs;

  final List<Bug> criticalBugs = <Bug>[].obs;
  final List<Bug> majorBugs = <Bug>[].obs;
  final List<Bug> mediumBugs = <Bug>[].obs;
  final List<Bug> minorBugs = <Bug>[].obs;
  final List<Bug> trivialBugs = <Bug>[].obs;
  final List<Tab> taskTabs = <Tab>[
    Tab(
      child: Row(
        children: const [
          Icon(Icons.dashboard),
          SizedBox(
            width: kSpacing / 4,
          ),
          Text("Board View", style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    ),
    Tab(
        child: Row(
          children: const [
            Icon(Icons.table_chart_rounded),
            SizedBox(
              width: kSpacing / 4,
            ),
            Text("Table View", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        )),
  ];

  final TextEditingController searchController = TextEditingController();
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  void onInit() {
    super.onInit();
    screenType = Responsive.desktop;
    taskTabController = TabController(
      length: taskTabs.length,
      vsync: this,
    );
    _getAllBugs();
    _bugTableDataSource = BugTableDataSource(
      bugTableList: _bugTableList.value,
      rowsPerPage: rowsPerPage.value,
      screenType: screenType,
    );
  }

  _updateRowsPerPage(int? value) {
    rowsPerPage(value);
    _bugTableDataSource = BugTableDataSource(
      bugTableList: _bugTableList.value,
      rowsPerPage: value,
      screenType: screenType,
    );
  }

  // Future<List<int>> _createExcelWorksheet() {
  //   final SyncfusionXlsio.Workbook workbook =
  //   _taskTableGlobalKey.currentState!.exportToExcelWorkbook(
  //       excludeColumns: [
  //         AppStrings.action,
  //         AppStrings.details,
  //       ],
  //       exportColumnWidth: false,
  //       exportRowHeight: false,
  //       defaultColumnWidth: 95,
  //       defaultRowHeight: 50,
  //       cellExport: (DataGridCellExcelExportDetails details) {
  //         if (details.cellType == DataGridExportCellType.columnHeader) {
  //           details.excelRange.cellStyle.backColor = '#e75480';
  //         } else if (details.cellType == DataGridExportCellType.row) {
  //           details.excelRange.cellStyle.backColor = '#FFC0CB';
  //         }
  //       });
  //   // final SyncfusionXlsio.Worksheet worksheet = workbook.worksheets[0];
  //   // _taskTableGlobalKey.currentState!.exportToExcelWorksheet(worksheet);
  //   final List<int> bytes = workbook.saveAsStream();
  //   return Future.value(bytes);
  // }
  //
  // _exportToExcelWorksheet() async {
  //   var bytes = await _createExcelWorksheet();
  //
  //   return AnchorElement(
  //       href:
  //       "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
  //     ..setAttribute("download", "TaskList-${randomStringName(6)}.xlsx")
  //     ..click();
  // }


  _getAllBugs() {
    _bugTableList.clear();
    _bugBoardList.clear();
    _tempBugTableList.clear();

    _bugTableList(bugMock.listOfBugs!);
    _bugBoardList(bugMock.listOfBugs!);
    _tempBugTableList.addAll(_bugTableList.value);
    _sortBugs();
  }

  _sortBugs() {
    criticalBugs.clear();
    majorBugs.clear();
    mediumBugs.clear();
    minorBugs.clear();
    trivialBugs.clear();

    for(Bug bug in _bugBoardList) {
      switch(bug.bugFlag!) {
        case BugFlag.critical:
          criticalBugs.add(bug);
          break;

        case BugFlag.major:
          majorBugs.add(bug);
          break;

        case BugFlag.medium:
          mediumBugs.add(bug);
          break;

        case BugFlag.minor:
          minorBugs.add(bug);
          break;

        case BugFlag.trivial:
          trivialBugs.add(bug);
          break;
      }
    }
  }

  _onSearch() {
    isLoadingDataTable(true);

    if (searchController.text.isEmpty) {
      logger.d("empty text $_tempBugTableList");
      _bugTableList.clear();
      _bugTableList.assignAll(_tempBugTableList);

      // _bugTableDataSource.handleChange();
      isLoadingDataTable(false);
      return;
    }

    if (searchController.text.isNotEmpty) {
      _bugTableList.clear();
      _tempBugTableList.forEach((bug) {
        if (bug.title!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          _bugTableList.add(bug);
        }
      });
      isLoadingDataTable(false);
      // _bugTableDataSource.handleChange();
    }
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

class AddEditBugController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final String _tag = "Bug";
  late final Bug? bug;
  var isAdd = false.obs;
  var popupTitle = "".obs;

  var pickedPhoto = PlatformFile(name: "", size: 0).obs;
  var uploadedPhotoUrl = "".obs;
  var uploadedUserId = "";
  final isSameImage = false.obs;
  final isUploadImageLoading = false.obs;
  FilePickerResult? filePickerResult;

  final isLoading = false.obs;

  final bugFlagList = BugFlag.values;
  final bugStatusList = BugStatus.values;
  final bugFlag = BugFlag.trivial.obs;
  final bugStatus = BugStatus.pending.obs;
  final reporter = User(id: "2q2", fullName: "fadf", image: "", email: "e@gmail.com", userType: UserType.admin, password: "", role: "", dateCreated: 1, userName: "he").obs;
  final assignedTo = User(id: "2q2", fullName: "fadf", image: "", email: "e@gmail.com", userType: UserType.admin, password: "", role: "", dateCreated: 1, userName: "he").obs;

  final isPasswordVisible = false.obs;
  final isCPasswordVisible = false.obs;

  List<User>? userList;
  var mockBug = MockBug();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController logcatController = TextEditingController();
  TextEditingController appVersionController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref().child("profile_images");

  AddEditBugController(this.bug);


  @override
  void onInit() {
    super.onInit();
    getAllUsers();

    if (bug == null) {
      isAdd(true);
      popupTitle("Add Bug");
    } else {
      popupTitle("Edit Bug");
      uploadedUserId = bug!.id!;
      titleController.text = bug!.title!;
      descriptionController.text = bug!.description!;
      logcatController.text = bug!.logcat!;
      appVersionController.text = bug!.appVersion!;
      uploadedPhotoUrl(bug!.screenshot!);
      reporter(bug!.reporter);
      assignedTo(bug!.assignedTo!);
      bugStatus(bug!.bugStatus!);
      bugFlag(bug!.bugFlag!);

    }
  }

  updateBugStatus(BugStatus? bugStatus) {
    this.bugStatus(bugStatus!);
  }

  updateBugFlag(BugFlag? bugFlag) {
    this.bugFlag(bugFlag!);
  }

  onChangeBugReporterDropdownItem(User? option) {
    reporter(option!);
  }

  onChangeBugAssignedToDropdownItem(User? option) {
    assignedTo(option!);
  }

  getAllUsers() {
    userList = mockBug.listOfUsers;
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
    final uploadUserProfile = ref.putData(compressedImageBytes!,
        SettableMetadata(contentType: 'image/$extension'));

    uploadUserProfile.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.success:
          uploadedPhotoUrl(await taskSnapshot.ref.getDownloadURL());
          isUploadImageLoading(false);
          logger.d(
              "successful image upload imageName $fileName , url ${uploadedPhotoUrl.value}");

          // Update Previous Image Url
          // FirebaseFirestore.instance
          //     .collection(FireConstants.colUser)
          //     .doc(uploadedUserId)
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

  userSnackBar({String? title = "Bug Screen", String? description}) {
    Get.snackbar(
      title!,
      description!,
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.8),
      maxWidth: 500,
      margin: const EdgeInsets.symmetric(vertical: kSpacing),
    );
  }

  addUser() {

  }

  editUser() {
    Map<String, dynamic> map = {};

    if (bug!.title != titleController.text) {
      map[SpringBootKeys.title] = titleController.text;
    }
    if (bug!.description != descriptionController.text) {
      map[SpringBootKeys.description] = descriptionController.text;
    }
    if (bug!.logcat != logcatController.text) {
      map[SpringBootKeys.logcat] = logcatController.text;
    }
    if (bug!.appVersion != appVersionController.text) {
      map[SpringBootKeys.appVersion] = appVersionController.text;
    }
    if(bug!.bugStatus !=bugStatus.value) {
      map[SpringBootKeys.bugStatus] =bugStatusToString(bugStatus.value);
    }
    if(bug!.bugFlag !=bugFlag.value) {
      map[SpringBootKeys.bugFlag] =bugFlagToString(bugFlag.value);
    }
    if(bug!.reporter!.id != reporter!.value!.id){
      map[SpringBootKeys.reporter] = reporter.value.toMap();
    }

    if(bug!.assignedTo!.id != assignedTo!.value!.id) {
      map[SpringBootKeys.assignedTo] = assignedTo.value.toMap();
    }

    if(pickedPhoto.value.name.isNotEmpty) {
      map[SpringBootKeys.image] = "";
    }

    if (map.isNotEmpty) {}
  }

  resetFields() {
    titleController.text = "";
    logcatController.text = "";
    descriptionController.text = "";
    appVersionController.text = "";
  }
}

class MockBug {
  List<Bug>? listOfBugs;

  List<User> listOfUsers = [
    User(id: "1", fullName: "Amrit Punya Kasi", userType: UserType.admin, userName: "amrit90", password: "amrit123", email: "amrit@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",role: "Read Write",dateCreated: 1680988500000 ),
    User(id: "2", fullName: "Sunita Karki",  userType: UserType.developer,userName: "sunita90", password: "sunita123", email: "sunita@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1678857767096_045.jpg?alt=media&token=42c24e3e-a170-4b6b-96fe-8c9c7f75d4c3",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "3", fullName: "Sobraj Nuepane",  userType: UserType.tester,userName: "sobraj90", password: "sobraj123", email: "sobraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680676988030_daylily-flower-and-buds-blur2.jpg?alt=media&token=86ed2339-d74d-4a30-a43d-e1d149d3764d",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "4", fullName: "Biraj Suman",  userType: UserType.admin,userName: "biraj90", password: "biraj123", email: "biraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "5", fullName: "Kemraj Adhikari",  userType: UserType.tester,userName: "khemraj761", password: "khemraj123", email: "khemraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "6", fullName: "Hemlal Bhandari",  userType: UserType.developer,userName: "hemlal761", password: "hemlal123", email: "hemlal@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "7", fullName: "Binit Bhat", userType: UserType.admin, userName: "binit761", password: "binit123", email: "binit@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "8", fullName: "Biraj Pariyar",  userType: UserType.endUser,userName: "biraj761", password: "biraj123", email: "biraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "9", fullName: "Hirit juman",  userType: UserType.tester,userName: "biraj761", password: "biraj123", email: "biraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "10", fullName: "Ridii Badahur",  userType: UserType.developer,userName: "biraj761", password: "biraj123", email: "biraj@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "11", fullName: "Sulal Badahur",  userType: UserType.developer,userName: "sulal761", password: "sulal123", email: "sulal@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "12", fullName: "Suhana Badahur",  userType: UserType.tester,userName: "suhana761", password: "suhana123", email: "suhana@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
    User(id: "13", fullName: "Unik Badahur",  userType: UserType.tester,userName: "x761", password: "daat123", email: "daat@gmail.com", image: "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",role: "Read Write",dateCreated: 1680563700000 ),
  ];

  var bugFlags = BugFlag.values;
  var bugStatuses = BugStatus.values;

  MockBug(){
    listOfBugs = [
      Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),
      Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),
      Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),
      Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),
      Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),Bug(
        id: "1",
        title: "Bug1",
        description: "This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.This bug is so annoying.",
        assignedTo: listOfUsers[Random().nextInt(13)],
        appVersion: "Version1 Beta",
        bugFlag: bugFlags[Random().nextInt(5)],
        bugStatus: bugStatuses[Random().nextInt(4)],
        reporter: listOfUsers[Random().nextInt(13)],
        logcat:
        "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower" +
            "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
        screenshot:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        dateCreated: 1680794100000,
      ),
    ];
  }

}