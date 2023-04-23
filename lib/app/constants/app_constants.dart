library app_constants;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

part 'api_path.dart';
part 'app_strings.dart';
part 'assets_path.dart';
part 'api_constants.dart';

final scafoldKey = GlobalKey<ScaffoldState>();

const kFontColorPallets = [
  Color.fromRGBO(26, 31, 56, 1),
  Color.fromRGBO(72, 76, 99, 1),
  Color.fromRGBO(149, 149, 163, 1),
];
const kBorderRadius = 10.0;
const kSpacing = 20.0;

const fontHeading = 18.0;
const fontNormal = 15.0;

const dialogWidth = 600.0;
const dialogHeight = 26 * kSpacing;

const appVersion = "v1.0.0";

const searchWidth = 200.0;

const Color iconBlackLight = Colors.black26;
const Color iconBlack = Colors.black87;
const Color iconGrey = Colors.grey;

const logoSizeSmall = 20.0;
const logoSizeMedium = 30.0;
const logoSizeBig = 40.0;

const int dataPerTableFetch = 15;
const int dataRowPerPage = 10;
const int dataPerGridFolder = 4;
const int dataPerGridFetch = 2;

const int fetchCurrentTaskForMonth = 3;
const int weeklyDays = 7;
const int fortnightDays = 15;
const int monthlyDays = 30;

const int filterFirstDateOfCalender = 365;
const int firstOrlastDateOfCalender = 90;

//initialize logger
var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true),
);

//GetX Storage Constants
class GetxStorageConstants {
  static const String getXPref = "TaskPlannerStorage";

  static const String currentUserId = "currentUserId";
  static const String currentUserName = "currentUserName";
  static const String currentUserImage = "currentUserImage";

  static const String currentUserContact = "currentUserContact";
  static const String selectedScreenIndex = "SelectedScreenIndex";
}

//Spring boot constants
class SpringBootKeys {
  /* Common Fields */
  static const String id = "id";
  static const String name = "name";
  static const String dateCreated = "dateCreated";

  /* Bug Model Fields */
  static const String title = "title";
  static const String description = "description";
  static const String logcat = "logcat";
  static const String bugStatus = "bugStatus";
  static const String bugFlag = "bugFlag";
  static const String reporter = "reporter";
  static const String assignedTo = "assignedTo";
  static const String appVersion = "appVersion";
  static const String screenshot = "screenshot";

  /* Activity Model Fields  */
  static const String user = "user";
  static const String project = "project";
  static const String bug = "bug";

  /* Home Model Fields  */
  static const String totalBugs = "totalBugs";
  static const String totalApps = "totalApps";
  static const String totalDevelopers = "totalDevelopers";
  static const String totalTesters = "totalTesters";
  static const String openBugs = "openBugs";
  static const String closedBugs = "closedBugs";
  static const String criticalBugs = "criticalBugs";
  static const String majorBugs = "majorBugs";
  static const String activityList = "activityList";

  /* Project Model Fields  */
  static const String image = "image";

  /* Project Model Response Fields  */
  static const String mediumBugs = "mediumBugs";
  static const String minorBugs = "minorBugs";
  static const String trivialBugs = "trivialBugs";

  /* User Model Fields */
  static const String fullName = "fullName";
  static const String password = "password";
  static const String email = "email";
  static const String userName = "userName";
  static const String userType = "userType";
  static const String role = "role";
}