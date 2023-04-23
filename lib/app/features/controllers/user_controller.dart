part of user;

class UserController extends GetxController{
  final GlobalKey<SfDataGridState> _logTableGlobalKey =
  GlobalKey<SfDataGridState>();

  var userMock = MockUser();
  late UserTableDataSource _userTableDataSource;
  late Responsive screenType;
  var rowsPerPage = dataRowPerPage.obs;
  final String tag = "User";
  final isLoadingDataTable = false.obs;
  final _userTableList = <User>[].obs;
  final _tempUserTableList = <User>[];

  final TextEditingController searchController = TextEditingController();
  final CustomColumnSizer _customColumnSizer = CustomColumnSizer();

  @override
  void onInit() {
    super.onInit();
    screenType = Responsive.desktop;
    _getAllUsers();
    _userTableDataSource = UserTableDataSource(
      userTableList: _userTableList.value,
      rowsPerPage: rowsPerPage.value,
      screenType: screenType,
    );
  }

  _updateRowsPerPage(int? value) {
    rowsPerPage(value);
    _userTableDataSource = UserTableDataSource(
      userTableList: _userTableList.value,
      rowsPerPage: value,
      screenType: screenType,
    );
  }

  _getAllUsers() {
    _userTableList.clear();
    _tempUserTableList.clear();

    _userTableList(userMock.listOfUsers!);
    _tempUserTableList.addAll(_userTableList.value);
  }

  _onSearch() {
    isLoadingDataTable(true);

    if (searchController.text.isEmpty) {
      logger.d("empty text $_tempUserTableList");
      _userTableList.clear();
      _userTableList.assignAll(_tempUserTableList);

      _userTableDataSource.handleChange();
      isLoadingDataTable(false);
      return;
    }

    if (searchController.text.isNotEmpty) {
      _userTableList.clear();
      _tempUserTableList.forEach((admin) {
        if (admin.fullName!
            .toLowerCase()
            .contains(searchController.text.toLowerCase())) {
          _userTableList.add(admin);
        }
      });
      isLoadingDataTable(false);
      _userTableDataSource.handleChange();
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

class AddEditUserController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final String _tag = "User";
  late final User? user;
  var isAdd = false.obs;
  var popupTitle = "".obs;

  var pickedPhoto = PlatformFile(name: "", size: 0).obs;
  var uploadedPhotoUrl = "".obs;
  var uploadedUserId = "";
  final isSameImage = false.obs;
  final isUploadImageLoading = false.obs;
  final userTypeList = UserType.values;
  FilePickerResult? filePickerResult;

  final isLoading = false.obs;

  final userType = UserType.tester.obs;

  final isPasswordVisible = false.obs;
  final isCPasswordVisible = false.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController roleController = TextEditingController();

  final storageRef = FirebaseStorage.instance.ref().child("profile_images");

  AddEditUserController(this.user);


  @override
  void onInit() {
    super.onInit();

    if (user == null) {
      isAdd(true);
      popupTitle("Add User");
    } else {
      popupTitle("Edit User");
      uploadedUserId = user!.id!;
      fullNameController.text = user!.fullName!;
      userNameController.text = user!.userName!;
      emailAddressController.text = user!.email!;
      passwordController.text = user!.password!;
      roleController.text = user!.role!;
      uploadedPhotoUrl(user!.image!);

    }
  }

  updateUserType(UserType? userType) {
    this.userType(userType!);
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

  addUser() {

  }

  editUser() {
    Map<String, dynamic> map = {};

    if (user!.fullName != fullNameController.text) {
      map[SpringBootKeys.fullName] = fullNameController.text;
    }
    if (user!.email != emailAddressController.text) {
      map[SpringBootKeys.email] = emailAddressController.text;
    }
    if (user!.password != passwordController.text) {
      map[SpringBootKeys.password] = passwordController.text;
    }
    if (user!.role != roleController.text) {
      map[SpringBootKeys.role] = roleController.text;
    }
    if (user!.userName != userNameController.text) {
      map[SpringBootKeys.userName] = userNameController.text;
    }
    if(user!.userType != userType.value) {
      map[SpringBootKeys.userType] = userTypeToString(userType.value);
    }

    if(pickedPhoto.value.name.isNotEmpty) {
      map[SpringBootKeys.image] = "";
    }

    if (map.isNotEmpty) {}
    }

  resetFields() {
    fullNameController.text = "";
    emailAddressController.text = "";
    roleController.text = "";
    userNameController.text = "";
    passwordController.text = "";
    cPasswordController.text = "";
  }
}

class MockUser {
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
}