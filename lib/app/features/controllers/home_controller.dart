part of home;

class HomeController extends GetxController {
  final getxPref = GetStorage(GetxStorageConstants.getXPref);
  final isLoading = false.obs;

  var mock = MockHome();
  Home? homeData;
  List<CardSummaryData> completeSummaryData = [];
  List<CardSummaryData> bugsSummaryData = [];
  List<Activity> listOfActivity = [];
  final RestApiServices restApi = Get.find<RestApiServices>();

  @override
  void onInit() {
    super.onInit();
    getxPref.write(GetxStorageConstants.selectedScreenIndex, 0);
    isLoading(true);
    homeData = mock.homeData;

    completeSummaryData = [
      CardSummaryData(label: "Total Bugs",
          count: homeData!.totalBugs!.toString(),
          primary: Colors.blue),
      CardSummaryData(label: "Total Apps",
          count: homeData!.totalApps!.toString(),
          primary: Colors.pink),
      CardSummaryData(label: "Total Developers",
          count: homeData!.totalDevelopers!.toString(),
          primary: Colors.deepOrange),
      CardSummaryData(label: "Total Testers",
          count: homeData!.totalTesters!.toString(),
          primary: Colors.green),
    ];

    bugsSummaryData = [
      CardSummaryData(label: "Open Bugs",
          count: homeData!.openBugs!.toString(),
          primary: Colors.black54),
      CardSummaryData(label: "Closed Bugs",
          count: homeData!.closedBugs!.toString(),
          primary: Colors.cyan),
      CardSummaryData(label: "Critical Bugs",
          count: homeData!.criticalBugs!.toString(),
          primary: Colors.purple),
      CardSummaryData(label: "Major Bugs",
          count: homeData!.majorBugs!.toString(),
          primary: Colors.yellow),
    ];

    listOfActivity = homeData!.activityList!;
    getHomeData();
    isLoading(false);
  }

  void getHomeData() {
    restApi.getHomeData();
  }

  void openDrawer() {
    if (scafoldKey.currentState != null) {
      logger.d("printing drawer state");
      logger.wtf(scafoldKey.currentState?.hasDrawer);
      scafoldKey.currentState!.openDrawer();
    }
  }
}

class MockHome {
  List<User> listOfUsers = [
    User(
        id: "1",
        fullName: "Amrit Punya Kasi",
        userType: UserType.admin,
        userName: "amrit90",
        password: "amrit123",
        email: "amrit@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        role: "Read Write",
        dateCreated: 1680988500000),
    User(
        id: "2",
        fullName: "Sunita Karki",
        userType: UserType.developer,
        userName: "sunita90",
        password: "sunita123",
        email: "sunita@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1678857767096_045.jpg?alt=media&token=42c24e3e-a170-4b6b-96fe-8c9c7f75d4c3",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "3",
        fullName: "Sobraj Nuepane",
        userType: UserType.tester,
        userName: "sobraj90",
        password: "sobraj123",
        email: "sobraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680676988030_daylily-flower-and-buds-blur2.jpg?alt=media&token=86ed2339-d74d-4a30-a43d-e1d149d3764d",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "4",
        fullName: "Biraj Suman",
        userType: UserType.admin,
        userName: "biraj90",
        password: "biraj123",
        email: "biraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "5",
        fullName: "Kemraj Adhikari",
        userType: UserType.tester,
        userName: "khemraj761",
        password: "khemraj123",
        email: "khemraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "6",
        fullName: "Hemlal Bhandari",
        userType: UserType.developer,
        userName: "hemlal761",
        password: "hemlal123",
        email: "hemlal@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "7",
        fullName: "Binit Bhat",
        userType: UserType.admin,
        userName: "binit761",
        password: "binit123",
        email: "binit@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "8",
        fullName: "Biraj Pariyar",
        userType: UserType.tester,
        userName: "biraj761",
        password: "biraj123",
        email: "biraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "9",
        fullName: "Hirit juman",
        userType: UserType.tester,
        userName: "biraj761",
        password: "biraj123",
        email: "biraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "10",
        fullName: "Ridii Badahur",
        userType: UserType.developer,
        userName: "biraj761",
        password: "biraj123",
        email: "biraj@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "11",
        fullName: "Sulal Badahur",
        userType: UserType.developer,
        userName: "sulal761",
        password: "sulal123",
        email: "sulal@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
    User(
        id: "12",
        fullName: "Suhana Badahur",
        userType: UserType.tester,
        userName: "suhana761",
        password: "suhana123",
        email: "suhana@gmail.com",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
        role: "Read Write",
        dateCreated: 1680563700000),
  ];

  List<Project> listOfProject = [
    Project(
        id: "1",
        name: "Connect Ips",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "2",
        name: "Esewa",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680369300000),
    Project(
        id: "3",
        name: "Google",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680362100000),
    Project(
        id: "4",
        name: "Microsoft Teams",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "5",
        name: "Zoom App",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "6",
        name: "Khalti",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "7",
        name: "Developer1",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "8",
        name: "Nas Daily",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "9",
        name: "T1",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "10",
        name: "Triple Hemegony",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "11",
        name: "Porn Blocker",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
    Project(
        id: "12",
        name: "Money Tracker",
        description:
        "It's a bright invention that allows everyone to transfer money fast.",
        image:
        "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523475016_360_F_5353218_oI4iPnZs1AAk371NBj9CGvWJKu5Aydkd.jpg?alt=media&token=0c8dcdae-7487-4498-be3f-05d7385fde6c",
        dateCreated: 1680988500000),
  ];

  List<Bug> listOfBugs = [
    Bug(
      id: "1",
      title: "Bug1",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "6",
          fullName: "Hemlal Bhandari",
          userType: UserType.developer,
          userName: "hemlal761",
          password: "hemlal123",
          email: "hemlal@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "2",
      title: "Bug2",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "6",
          fullName: "Hemlal Bhandari",
          userType: UserType.developer,
          userName: "hemlal761",
          password: "hemlal123",
          email: "hemlal@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "3",
      title: "Bug3",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "10",
          fullName: "Ridii Badahur",
          userType: UserType.developer,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "4",
      title: "Bug4",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "11",
          fullName: "Sulal Badahur",
          userType: UserType.developer,
          userName: "sulal761",
          password: "sulal123",
          email: "sulal@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "5",
      title: "Bug5",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "6",
          fullName: "Hemlal Bhandari",
          userType: UserType.developer,
          userName: "hemlal761",
          password: "hemlal123",
          email: "hemlal@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "6",
      title: "Bug6",
      description: "This bug is so annoying.",
      assignedTo: User(
          id: "10",
          fullName: "Ridii Badahur",
          userType: UserType.developer,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
    Bug(
      id: "7",
      title: "Bug7",
      description: "This bug is so annoying.",
      assignedTo:
      User(
          id: "11",
          fullName: "Sulal Badahur",
          userType: UserType.developer,
          userName: "sulal761",
          password: "sulal123",
          email: "sulal@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      appVersion: "Version1 Beta",
      bugFlag: BugFlag.medium,
      bugStatus: BugStatus.ongoing,
      reporter: User(
          id: "8",
          fullName: "Biraj Pariyar",
          userType: UserType.tester,
          userName: "biraj761",
          password: "biraj123",
          email: "biraj@gmail.com",
          image:
          "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
          role: "Read Write",
          dateCreated: 1680563700000),
      logcat:
      "2022-12-29 04:00:18.823 30249-30321 ProfileInstaller        com.google.samples.apps.sunflower    D  Installing profile for com.google.samples.apps.sunflower",
      screenshot:
      "https://firebasestorage.googleapis.com/v0/b/task-planner-test-b65a8.appspot.com/o/profile_images%2F1680523357146_istockphoto-144289514-612x612.jpg?alt=media&token=551ffc8d-b5bb-4b2e-a8c8-aff0cd4a1700",
      dateCreated: 1680794100000,
    ),
  ];

  List<Activity> listOfActivities = [];

  Home? homeData;

  MockHome() {
    listOfActivities = [
      Activity(
        id: "1",
        activityType: ActivityType.postedNewBug,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      Activity(
        id: "2",
        activityType: ActivityType.postedNewBug,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      Activity(
        id: "3",
        activityType: ActivityType.changesBugStatus,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      Activity(
        id: "4",
        activityType: ActivityType.changesBugStatus,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      Activity(
        id: "5",
        activityType: ActivityType.changesBugStatus,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      Activity(
        id: "6",
        activityType: ActivityType.postedNewBug,
        user: listOfUsers[Random().nextInt(12)],
        bug: listOfBugs[Random().nextInt(7)],
        project: listOfProject[Random().nextInt(12)],
        dateCreated: 1680794100000,
      ),
      // Activity(
      //   id: "7",
      //   activityType: ActivityType.changesBugStatus,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
      // Activity(
      //   id: "8",
      //   activityType: ActivityType.postedNewBug,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
      // Activity(
      //   id: "9",
      //   activityType: ActivityType.changesBugStatus,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
      // Activity(
      //   id: "10",
      //   activityType: ActivityType.postedNewBug,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
      // Activity(
      //   id: "11",
      //   activityType: ActivityType.postedNewBug,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
      // Activity(
      //   id: "12",
      //   activityType: ActivityType.changesBugStatus,
      //   user: listOfUsers[Random().nextInt(12)],
      //   bug: listOfBugs[Random().nextInt(7)],
      //   project: listOfProject[Random().nextInt(12)],
      //   dateCreated: 1680794100000,
      // ),
    ];
    homeData = Home(
        totalBugs: 129,
        totalApps: 4,
        totalDevelopers: 12,
        totalTesters: 5,
        openBugs: 45,
        closedBugs: 84,
        criticalBugs: 10,
        majorBugs: 15,
        activityList: listOfActivities);
  }
}
