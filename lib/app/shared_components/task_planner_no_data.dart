import 'package:flutter/cupertino.dart';

import '../constants/app_constants.dart';

class TaskPlannerNoData extends StatelessWidget {
  const TaskPlannerNoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "No data available to show.",
            style: TextStyle(
                fontSize: fontNormal * 2, fontWeight: FontWeight.w700),
          ),
        ),
        Image.asset(
          ImageRasterPath.emptyGif,
          height: 100,
          width: 100,
        )
      ],
    ));
  }
}
