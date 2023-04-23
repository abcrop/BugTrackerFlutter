library home;

import 'dart:math';

import 'package:daily_task/app/features/model/BugModel.dart';
import 'package:daily_task/app/features/model/UserModel.dart';
import 'package:daily_task/app/utils/helpers/app_helpers.dart';
import 'package:daily_task/app/utils/services/rest_api_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../config/routes/app_pages.dart';
import '../../../constants/app_constants.dart';
import '../../../shared_components/cached_image.dart';
import '../../../shared_components/header_space_between.dart';
import '../../../shared_components/side_bar.dart';
import '../../../shared_components/task_planner_scaffold.dart';
import '../../../shared_components/text_space_icon.dart';
import '../../model/ActivityModel.dart';
import '../../model/HomeModel.dart';
import '../../model/ProjectModel.dart';

part '../../bindings/home_binding.dart';
part '../../controllers/home_controller.dart';
part '../home/home_summary.dart';
part '../home/card_summary.dart';
part '../home/home_activity.dart';

class HomeScreen extends GetView<HomeController>{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TaskPlannerScaffold(
      mobileWidget: (context, constraints) {
        return SingleChildScrollView(
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: _buildTaskContent(
              onPressedMenu: () => controller.openDrawer(),
            ),
          ),
        );
      },
      tabletWidget: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: constraints.maxWidth > 800 ? 8 : 7,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: _buildTaskContent(
                  onPressedMenu: () => controller.openDrawer(),
                ),
              ),
            ),
          ],
        );
      },
      desktopWidget: (context, constraints) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: constraints.maxWidth > 1313 ? 3 : 2,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: SideBar(),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: const VerticalDivider(),
            ),
            Flexible(
              flex: constraints.maxWidth > 1350 ? 11 : 9,
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: _buildTaskContent(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTaskContent({Function()? onPressedMenu}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (onPressedMenu != null)
                Padding(
                  padding: const EdgeInsets.only(right: kSpacing),
                  child: IconButton(
                    onPressed: onPressedMenu,
                    icon: const Icon(Icons.menu),
                  ),
                ),
            ],
          ),
          const SizedBox(height: kSpacing / 2),

          HomeSummary(
            summaryLabel: "Complete Summary" ,
            summaryDataList: controller.completeSummaryData,
          ),

          const SizedBox(height: kSpacing),

          HomeSummary(
            summaryLabel: "Bugs Summary" ,
            summaryDataList: controller.bugsSummaryData,
          ),

          const SizedBox(height: kSpacing),

          ActivitySummary(data: controller.listOfActivity, getxPref: controller.getxPref, isLoading: controller.isLoading)
        ],
      ),
    );
  }

}
