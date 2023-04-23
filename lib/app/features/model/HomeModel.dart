import 'package:daily_task/app/features/model/ActivityModel.dart';

import '../../constants/app_constants.dart';
import '../../utils/helpers/app_helpers.dart';

class Home {
  Home(
      {this.totalBugs,
      this.totalApps,
      this.totalDevelopers,
      this.totalTesters,
      this.openBugs,
      this.closedBugs,
      this.criticalBugs,
      this.majorBugs,
      this.activityList});

  final int? totalBugs;
  final int? totalApps;
  final int? totalDevelopers;
  final int? totalTesters;

  final int? openBugs;
  final int? closedBugs;
  final int? criticalBugs;
  final int? majorBugs;

  final List<Activity>? activityList;



  factory Home.fromMap(Map<dynamic, dynamic> map) {
    logger.d(map.values);
    return Home(
        totalBugs: map.containsKey(SpringBootKeys.totalBugs)
            ? map[SpringBootKeys.totalBugs] as int
            : 0,
      totalApps: map.containsKey(SpringBootKeys.totalApps)
          ? map[SpringBootKeys.totalApps] as int
          : 0,
      totalDevelopers: map.containsKey(SpringBootKeys.totalDevelopers)
          ? map[SpringBootKeys.totalDevelopers] as int
          : 0,
      totalTesters: map.containsKey(SpringBootKeys.totalTesters)
          ? map[SpringBootKeys.totalTesters] as int
          : 0,
      openBugs: map.containsKey(SpringBootKeys.openBugs)
          ? map[SpringBootKeys.openBugs] as int
          : 0,
      closedBugs: map.containsKey(SpringBootKeys.closedBugs)
          ? map[SpringBootKeys.closedBugs] as int
          : 0,
      criticalBugs: map.containsKey(SpringBootKeys.criticalBugs)
          ? map[SpringBootKeys.criticalBugs] as int
          : 0,
      majorBugs: map.containsKey(SpringBootKeys.majorBugs)
          ? map[SpringBootKeys.majorBugs] as int
          : 0,
      activityList: map.containsKey(SpringBootKeys.activityList)
          ? List.from(map[SpringBootKeys.activityList].map<dynamic>((item)=> Activity.fromMap(item)))
          : <Activity>[],

    );
  }
}
