library activity;

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../../constants/app_constants.dart';
import '../../../shared_components/buildPageTitle.dart';
import '../../../shared_components/cached_image.dart';
import '../../../shared_components/project_header.dart';
import '../../../shared_components/search_field.dart';
import '../../../shared_components/side_bar.dart';
import '../../../shared_components/task_planner_scaffold.dart';
import '../../../utils/helpers/app_helpers.dart';
import '../../model/ActivityModel.dart';
import '../../model/BugModel.dart';
import '../../model/ProjectModel.dart';
import '../../model/UserModel.dart';

part '../../bindings/activity_binding.dart';
part '../../controllers/activity_controller.dart';
part '../activity/activity_header.dart';
part '../activity/activity_list.dart';

class ActivityScreen extends GetView<ActivityController>{
  const ActivityScreen({Key? key}) : super(key: key);

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

          ActivityHeader(
            screenType: controller.screenType,
            searchController: controller.searchController,
            onSearch: controller._onSearch,
          ),

          const SizedBox(height: kSpacing),

          ActivityList(
            data: controller._activityList.value,
            isLoading: controller.isLoading,
          )
        ],
      ),
    );
  }


}