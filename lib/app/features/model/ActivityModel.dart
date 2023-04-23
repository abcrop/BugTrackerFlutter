import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';
import 'BugModel.dart';
import 'ProjectModel.dart';
import 'UserModel.dart';

class Activity {
  Activity({this.id, this.user, this.project, this.bug, this.activityType,this.dateCreated});

  final String? id;
  final User? user;
  final Project? project;
  final Bug? bug;
  final ActivityType? activityType;
  final int? dateCreated;

  Map<String, dynamic> toMap() {
    return {
      SpringBootKeys.id: id,
      SpringBootKeys.user: user!.toMap(),
      SpringBootKeys.project: project!.toMap(),
      SpringBootKeys.bug: bug!.toMap(),
      SpringBootKeys.dateCreated: getCurrentTimeInMilliseconds(),
    };
  }

  factory Activity.fromMap(Map<dynamic, dynamic> map) {
    logger.d(map.values);
    return Activity(
        id: map.containsKey(SpringBootKeys.id)
            ? map[SpringBootKeys.id] as String
            : "",
        user: map.containsKey(SpringBootKeys.user)
            ? User.fromMap(map[SpringBootKeys.user])
            : User(fullName: "null"),
        project: map.containsKey(SpringBootKeys.project)
            ? Project.fromMap(map[SpringBootKeys.project])
            : Project(name: "null"),
        bug: map.containsKey(SpringBootKeys.bug)
            ? Bug.fromMap(map[SpringBootKeys.bug])
            : Bug(title: "null"),
        dateCreated: map.containsKey(SpringBootKeys.dateCreated)
            ? map[SpringBootKeys.dateCreated]
            : 0);
  }
}
