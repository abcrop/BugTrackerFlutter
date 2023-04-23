import 'package:cloud_firestore/cloud_firestore.dart';

import '../../constants/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';
import 'BugModel.dart';

class Project {
  Project({this.id, this.name, this.description, this.bug, this.image, this.dateCreated});

  final String? id;
  final String? name;
  final String? description;
  final Bug? bug;
  final String? image;
  final int? dateCreated;

  Map<String, dynamic> toMap() {
    return {
      SpringBootKeys.id: id,
      SpringBootKeys.name : name,
      SpringBootKeys.description: description,
      SpringBootKeys.bug: bug!.toMap(),
      SpringBootKeys.image: image,
      SpringBootKeys.dateCreated: getCurrentTimeInMilliseconds(),
    };
  }

  factory Project.fromMap(Map<dynamic, dynamic> map) {
    logger.d(map.values);
    return Project(
        id: map.containsKey(SpringBootKeys.id)
            ? map[SpringBootKeys.id] as String
            : "",
      name: map.containsKey(SpringBootKeys.name)
          ? map[SpringBootKeys.name] as String
          : "",
      description: map.containsKey(SpringBootKeys.description)
          ? map[SpringBootKeys.description] as String
          : "",
      bug: map.containsKey(SpringBootKeys.bug)
          ? Bug.fromMap(map[SpringBootKeys.bug])
          : Bug(title: "null"),
      image: map.containsKey(SpringBootKeys.image)
          ? map[SpringBootKeys.image] as String
          : "",
      dateCreated: map.containsKey(SpringBootKeys.dateCreated)
          ? map[SpringBootKeys.dateCreated] as int
          : 0,
    );
  }
}

class ProjectListDataResponse {
  ProjectListDataResponse({this.openBugs, this.closedBugs, this.criticalBugs, this.majorBugs, this.mediumBugs, this.minorBugs, this.trivialBugs,
    this.project,
  });

  final Project? project;

  final int? openBugs;
  final int? closedBugs;

  final int? criticalBugs;
  final int? majorBugs;
  final int? mediumBugs;
  final int? minorBugs;
  final int? trivialBugs;

factory ProjectListDataResponse.fromMap(Map<dynamic, dynamic> map) {
  logger.d(map.values);
  return ProjectListDataResponse(
    project: map.containsKey(SpringBootKeys.project)
        ? Project.fromMap(map[SpringBootKeys.project])
        : Project(name: "null"),
    openBugs: map.containsKey(SpringBootKeys.openBugs)
        ? map[SpringBootKeys.openBugs] as int
        : 0,
    majorBugs: map.containsKey(SpringBootKeys.majorBugs)
        ? map[SpringBootKeys.majorBugs] as int
        : 0,
    mediumBugs: map.containsKey(SpringBootKeys.mediumBugs)
        ? map[SpringBootKeys.mediumBugs] as int
        : 0,
    minorBugs: map.containsKey(SpringBootKeys.minorBugs)
        ? map[SpringBootKeys.minorBugs] as int
        : 0,
    trivialBugs: map.containsKey(SpringBootKeys.trivialBugs)
        ? map[SpringBootKeys.trivialBugs] as int
        : 0,
  );
}
}
