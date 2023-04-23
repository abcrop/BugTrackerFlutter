library app_helpers;

import 'dart:math';

import 'package:daily_task/app/features/model/ActivityModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../config/routes/app_pages.dart';
import '../../config/themes/app_theme.dart';
import '../../constants/app_constants.dart';

part 'extension.dart';
part 'type.dart';

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeHeaderCellWidth(GridColumn column, TextStyle style) {
    style = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeHeaderCellWidth(column, style);
  }

  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    textStyle = const TextStyle(fontWeight: FontWeight.bold);

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}

calculateAlertHeight(BuildContext context, Responsive screenType) {
  return MediaQuery.of(context).size.height - MediaQuery.of(context).size.height * 0.3;
}

calculateAlertWidth(BuildContext context, Responsive screenType) {
  var width = 0.0;

  if ( screenType == Responsive.desktop ) {
    width = MediaQuery
        .of(context)
        .size
        .width - MediaQuery
        .of(context)
        .size
        .width*0.45;
  }
  else if ( screenType == Responsive.tablet) {
    width = MediaQuery
        .of(context)
        .size
        .width - MediaQuery
        .of(context)
        .size
        .width*0.2;
  }
  else if ( screenType == Responsive.mobile) {
    width = MediaQuery
        .of(context)
        .size
        .width;
  }

  return width;
}

class HeightWidth {
  final double width;
  final double height;

  const HeightWidth({required this.width, required this.height});
}

randomStringName(int len) {
  var r = Random();
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

String currentFormattedDateString() {
  return DateFormat.yMMMd().format(DateTime.now());
}

int anyDateTimeToMilliseconds(DateTime dateTime) {
  return dateTime.millisecondsSinceEpoch;
}

DateTime anyMillisecondsToDateTime(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time);
}

int getCurrentTimeInMilliseconds() {
return DateTime.now().millisecondsSinceEpoch;
}

String milliSecondsToDateTimeString(int time) {
return DateFormat.yMd().add_jm().format(DateTime.fromMillisecondsSinceEpoch(time));
}

String milliSecondsToDateString(int time) {
  return DateFormat("yyyy-MM-dd").format(DateTime.fromMillisecondsSinceEpoch(time));
}

String milliSecondsToTimeString(int time) {
  return DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(time));
}

// extractDateFromMergedDateAndTime(int time) {
//   return TimeOfDay.now().hour ;
// }

TimeOfDay extractTimeFromMergedDateAndTime(int time) {
  return TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(time));
}

int mergeTaskDateAndTimeInMilliseconds(DateTime date , TimeOfDay time) {
  final mergedDateTime = DateFormat("yyyy-MM-dd hh:mm aaa").parse(
    '${DateFormat("yyyy-MM-dd").format(date)} ${time.format(Get.context!)}'.replaceAll('pm', 'PM').replaceAll('am', 'AM'),
  );

  // var dateTimeString = DateFormat("yyyy-MM-dd").format(date) + " " + time.format(Get.context!) + ":00.000";
  // // var duration = Duration(hours: time.hour , minutes: time.minute);
  // // date.add(duration);
  return anyDateTimeToMilliseconds(mergedDateTime);
}

TimeOfDay repeatAtStringToTimeOfDay(String taskTime) {
  return taskTime.length != 5 ? const TimeOfDay(hour:0, minute: 0) : TimeOfDay(hour: int.parse(taskTime.substring(0,2)), minute: int.parse(taskTime.substring(3,5)));
}

String timeOfDayToRepeatAtString(TimeOfDay timeOfDay) {
  var temp = "${timeOfDay.hour < 10 ? "0${timeOfDay.hour}" : timeOfDay.hour}:${timeOfDay.minute < 10 ? "0${timeOfDay.minute}" : timeOfDay.minute}";
  return temp;
}

String timeOfDayToHumanReadableTime(TimeOfDay timeOfDay) {
  return timeOfDay.format(Get.context!);
}

formatDateToParsableString(DateTime datetime) {
  return DateFormat("yyyy-MM-dd").format(datetime);
}

DateTime currentDayValidTaskEndTime(DateTime datetime) {
  var currentDateString =  formatDateToParsableString(datetime);
  var currentDateOnly = DateTime.parse(currentDateString);
  return currentDateOnly.add(const Duration(hours: 23, minutes: 59, seconds: 59, milliseconds: 0, microseconds: 0));
}

DateTime currentDayValidTaskStartTime(DateTime datetime) {
  var currentDateString = formatDateToParsableString(datetime);
  var currentDateOnly = DateTime.parse(currentDateString);
  return currentDateOnly.add(const Duration(hours: 0, minutes: 0, seconds: 0, milliseconds: 0, microseconds: 0));
}

capitalizeEachFirstWordFormatter(String value){
  try{
    var strings = value.split(" ");
    String finalName = "";

    for(var str in strings) {
      finalName += str[0].toUpperCase() + str.substring(1, str.length).toLowerCase() + " ";
    }
    return finalName;
  }catch(e) {
    return value;
  }
}

emailFormatter(String email) {
  return email.toLowerCase();
}


stringToUserType(String val){
  var lowerVal = val.toLowerCase();
  if(lowerVal == UserType.admin.name.toLowerCase() ) {
    return UserType.admin;
  } else if(lowerVal == UserType.developer.name.toLowerCase()) {
    return UserType.developer;
  } else if (lowerVal == UserType.tester.name.toLowerCase()) {
    return UserType.tester;
  }  else if (lowerVal == UserType.endUser.name.toLowerCase()) {
    return UserType.endUser;
  }
}

userTypeToString(UserType userType) {
  if(userType == UserType.admin ) {
    return UserType.admin.name.toUpperCase();
  } else if(userType == UserType.developer) {
    return UserType.developer.name.toUpperCase();
  } else if (userType == UserType.tester) {
    return UserType.tester.name.toUpperCase();
  } else if (userType == UserType.endUser) {
    return UserType.endUser.name.toUpperCase();
  } else {
    return UserType.admin.name.toUpperCase();
  }
}

stringToBugStatus(String val){
  var lowerVal = val.toLowerCase();

  if(lowerVal == BugStatus.pending.name.toLowerCase() ) {
    return BugStatus.pending;
  } else if(lowerVal == BugStatus.ongoing.name.toLowerCase()) {
    return BugStatus.ongoing;
  } else if (lowerVal == BugStatus.done.name.toLowerCase()) {
    return BugStatus.done;
  } else if (lowerVal == BugStatus.cancelled.name.toLowerCase()) {
    return BugStatus.cancelled;
  }

  return BugStatus.pending;
}

bugStatusToString(BugStatus taskStatus ){

  if(taskStatus == BugStatus.pending ) {
    return BugStatus.pending.name.toUpperCase();
  } else if(taskStatus == BugStatus.ongoing) {
    return BugStatus.ongoing.name.toUpperCase();
  } else if (taskStatus == BugStatus.done) {
    return BugStatus.done.name.toUpperCase();
  } else if (taskStatus == BugStatus.cancelled) {
    return BugStatus.cancelled.name.toUpperCase();
  } else {
    return BugStatus.pending.name.toUpperCase();
  }
}

stringToBugFlag(String val){
  var lowerVal = val.toLowerCase();

  if(lowerVal == BugFlag.critical.name.toLowerCase()) {
    return BugFlag.critical;
  } else if(lowerVal == BugFlag.major.name.toLowerCase()) {
    return BugFlag.major;
  } else if (lowerVal == BugFlag.medium.name.toLowerCase()) {
    return BugFlag.medium;
  } else if (lowerVal == BugFlag.minor.name.toLowerCase()) {
    return BugFlag.minor;
  } else if (lowerVal == BugFlag.trivial.name.toLowerCase()) {
    return BugFlag.trivial;
  }
  return BugFlag.trivial;
}

bugFlagToString(BugFlag medicationType ){

  if(medicationType == BugFlag.critical ) {
    return BugFlag.critical.name.toUpperCase();
  } else if(medicationType == BugFlag.major) {
    return BugFlag.major.name.toUpperCase();
  } else if (medicationType == BugFlag.medium) {
    return BugFlag.medium.name.toUpperCase();
  } else if (medicationType == BugFlag.minor) {
    return BugFlag.minor.name.toUpperCase();
  } else if (medicationType == BugFlag.trivial) {
    return BugFlag.trivial.name.toUpperCase();
  } else {
    return BugFlag.trivial.name.toUpperCase();
  }
}

stringToActivityType(String val){
  var lowerVal = val.toLowerCase();

  if(lowerVal == ActivityType.postedNewBug.name ) {
    return ActivityType.postedNewBug;
  } else if(lowerVal == ActivityType.changesBugStatus.name) {
    return ActivityType.changesBugStatus;
  }
  return ActivityType.postedNewBug;
}

activityTypeToString(ActivityType activityType ){

  if(activityType == ActivityType.postedNewBug ) {
    return ActivityType.postedNewBug.name.toUpperCase();
  } else if(activityType == ActivityType.changesBugStatus) {
    return ActivityType.changesBugStatus.name.toUpperCase();
  } else {
    return ActivityType.postedNewBug.name.toUpperCase();
  }
}

userTypeColorAccordingToUserType(UserType type) {
  switch (type) {
    case UserType.admin:
      return Colors.blue;

    case UserType.tester:
      return Colors.orange;

    case UserType.developer:
      return Colors.green;

    case UserType.endUser:
      return Colors.purple;

    default:
      return Colors.yellow;
  }
}

bugStatusColorAccordingToBugStatus(BugStatus type) {
  switch (type) {
    case BugStatus.pending:
      return Colors.purple;

    case BugStatus.ongoing:
      return Colors.orange;

    case BugStatus.done:
      return Colors.green;

    case BugStatus.cancelled:
      return Colors.red;

      default:
      return Colors.yellow;
  }
}

bugFlagColorAccordingToBugFlag(BugFlag flag) {
  switch (flag) {
    case BugFlag.critical:
      return Colors.red;

    case BugFlag.major:
      return Colors.orange;

    case BugFlag.medium:
      return Colors.pink;

    case BugFlag.minor:
      return Colors.blue;

    case BugFlag.trivial:
      return Colors.green;

    default:
      return Colors.yellow;
  }
}


Color activityColorAccordingToActivityType(ActivityType type) {
  switch (type) {
    case ActivityType.postedNewBug:
      return Colors.lightBlue;
      break;

    case ActivityType.changesBugStatus:
      return Colors.pink;
      break;

    default:
      break;
  }
  return Colors.black;
}

descriptionMaker(Activity activity){
  if(activity.activityType == ActivityType.postedNewBug){
    return "${activity.user!.fullName} has posted a new bug ( ${activity.bug!.title} | ${activity.bug!.bugFlag!.name} ) for project ${activity.project!.name}";
  }
  else if(activity.activityType == ActivityType.changesBugStatus) {
    return "${activity.user!.fullName} has changes bug status to ${activity.bug!.bugStatus!.name} for project ${activity.project!.name}";
  }
}

InputDecoration taskPlannerInputDecorationForDropdown({
  String? hintText,
  String? errorText,
  Icon? prefixIcon,
  Function()? onSearch
}) {
  return InputDecoration(
    filled: true,
    hintText: hintText!,
    errorText: errorText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    fillColor: iconGrey.withOpacity(0.15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(
          color: AppTheme.basic.primaryColor.withOpacity(0.7), width: 5.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(color: iconGrey.withOpacity(0.4), width: 2.0),
    ),
    prefixIcon: prefixIcon,
    suffix: const Text('Hour*',
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600)),

  );
}

InputDecoration taskPlannerInputDecoration({
  String? hintText,
  String? errorText,
  Icon? prefixIcon,
  Icon? suffixIcon,
  bool? showSuffixIcon = false,
  Function()? onSearch
}) {
  return InputDecoration(
    filled: true,
    hintText: hintText!,
    errorText: errorText,
    contentPadding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
    fillColor: iconGrey.withOpacity(0.15),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(
          color: AppTheme.basic.primaryColor.withOpacity(0.7), width: 5.0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
      borderSide: BorderSide(color: iconGrey.withOpacity(0.4), width: 2.0),
    ),
    prefixIcon: prefixIcon,
  );
}

InputDecoration taskPlannerPasswordInputDecoration(
    {String? hintText,
    String? errorText,
    Icon? prefixIcon,
    Icon? suffixIconOriginal,
    Icon? suffixIconChange,
    bool? isSuffixVisible,
    Function(bool value)? onTapVisibilityIcon}) {
  return InputDecoration(
      filled: true,
      hintText: hintText!,
      errorText: errorText,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      fillColor: iconGrey.withOpacity(0.15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(
            color: AppTheme.basic.primaryColor.withOpacity(0.7), width: 5.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
        borderSide: BorderSide(color: iconGrey.withOpacity(0.4), width: 2.0),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: InkWell(
          onTap: () => {onTapVisibilityIcon!(!isSuffixVisible!)},
          child: isSuffixVisible! ? suffixIconOriginal : suffixIconChange));
}
