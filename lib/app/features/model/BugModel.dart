import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';
import 'ProjectModel.dart';
import 'UserModel.dart';

class Bug {
  Bug({this.id, this.title, this.description, this.logcat, this.bugStatus, this.bugFlag, this.project, this.reporter, this.assignedTo, this.appVersion, this.screenshot, this.dateCreated

  });

  final String? id;
  final String? title;
  final String? description;
  final String? logcat;
  final BugStatus? bugStatus;
  final BugFlag? bugFlag;
  final Project? project;
  final User? reporter;
  final User? assignedTo;
  final String? appVersion;
  final String? screenshot;
  final int? dateCreated;

  Map<String, dynamic> toMap() {
    return {
      SpringBootKeys.id: id,
      SpringBootKeys.title : title,
      SpringBootKeys.description : description,
      SpringBootKeys.logcat: logcat,
      SpringBootKeys.bugStatus: bugStatusToString(bugStatus!),
      SpringBootKeys.bugFlag: bugFlagToString(bugFlag!),
      SpringBootKeys.project: project!.toMap(),
      SpringBootKeys.reporter: reporter!.toMap(),
      SpringBootKeys.assignedTo: assignedTo!.toMap(),
      SpringBootKeys.appVersion: appVersion,
      SpringBootKeys.screenshot: screenshot,
      SpringBootKeys.dateCreated: getCurrentTimeInMilliseconds(),
    };
  }

  factory Bug.fromMap(Map<dynamic, dynamic> map) {
    logger.d(map.values);
    return Bug(
        id: map.containsKey(SpringBootKeys.id)
            ? map[SpringBootKeys.id] as String
            : "",
        title: map.containsKey(SpringBootKeys.title)
            ? map[SpringBootKeys.title] as String
            : "",
        description: map.containsKey(SpringBootKeys.description)
            ? map[SpringBootKeys.description] as String
            : "",
        logcat: map.containsKey(SpringBootKeys.logcat)
            ? map[SpringBootKeys.logcat] as String
            : "",
        bugStatus: map.containsKey(SpringBootKeys.bugStatus)
            ? stringToBugStatus(map[SpringBootKeys.bugStatus]) as BugStatus
            : BugStatus.pending,
        bugFlag: map.containsKey(SpringBootKeys.bugFlag)
            ? stringToBugStatus(map[SpringBootKeys.bugFlag]) as BugFlag
            : BugFlag.trivial,
        project: map.containsKey(SpringBootKeys.project)
            ? Project.fromMap(map[SpringBootKeys.project])
            : Project(name: "null"),
        reporter: map.containsKey(SpringBootKeys.reporter)
            ? User.fromMap(map[SpringBootKeys.reporter])
            : User(fullName: "null"),
        assignedTo: map.containsKey(SpringBootKeys.reporter)
            ? User.fromMap(map[SpringBootKeys.reporter])
            : User(fullName: "null"),
        appVersion: map.containsKey(SpringBootKeys.appVersion)
            ? map[SpringBootKeys.appVersion] as String
            : "",
        screenshot: map.containsKey(SpringBootKeys.screenshot)
            ? map[SpringBootKeys.screenshot] as String
            : "",
        dateCreated: map.containsKey(SpringBootKeys.dateCreated)
            ? map[SpringBootKeys.dateCreated]
            : 0);
  }
}
