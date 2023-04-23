library bug;

import 'dart:math';
import 'dart:ui';

import 'package:daily_task/app/shared_components/cached_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:file_picker/file_picker.dart' as TaskPlannerFilePicker;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../config/themes/app_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../shared_components/ShowImageAlert.dart';
import '../../../shared_components/buildPageTitle.dart';
import '../../../shared_components/circle_image_with_admin_indicator.dart';
import '../../../shared_components/project_body.dart';
import '../../../shared_components/project_header.dart';
import '../../../shared_components/project_pop_up.dart';
import '../../../shared_components/search_field.dart';
import '../../../shared_components/side_bar.dart';
import '../../../shared_components/task_planner_dropdown2.dart';
import '../../../shared_components/task_planner_no_data.dart';
import '../../../shared_components/task_planner_scaffold.dart';
import '../../../shared_components/text_auto_complete_dropdown.dart';
import '../../../utils/helpers/app_helpers.dart';
import '../../model/BugModel.dart';
import '../../model/UserModel.dart';

part '../../bindings/bug_binding.dart';
part '../../controllers/bug_controller.dart';
part '../../data_table_grid_source/bug_data_source.dart';
part '../bug/add_edit_bug_alert.dart';
part '../bug/bug_header.dart';
part '../bug/bug_table.dart';
part '../bug/bug_tab_views.dart';
part '../bug/bug_card.dart';

class BugScreen extends GetView<BugController>{
  const BugScreen({Key? key}) : super(key: key);

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

          BugHeader(
            screenType: controller.screenType,
            searchController: controller.searchController,
            onSearch: controller._onSearch,
            taskTabController: controller.taskTabController,
            taskTabs: controller.taskTabs,
            taskCurrentTabIndex: controller.taskCurrentTabIndex,
          ),

          const SizedBox(height: kSpacing),

          BugTabViews(controller: controller)
        ],
      ),
    );
  }


}