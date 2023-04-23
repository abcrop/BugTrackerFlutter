import 'package:daily_task/app/shared_components/selection_button.dart';
import 'package:daily_task/app/shared_components/side_bar_head.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/app_constants.dart';

class SideBar extends StatelessWidget {
  SideBar({Key? key}) : super(key: key);
  final _getxPref = GetStorage(GetxStorageConstants.getXPref);

  late String projectHeadImageUrl;
  late String projectHeadName;
  late int selectedScreenIndex;

  @override
  Widget build(BuildContext context) {
    projectHeadImageUrl = _getxPref.read(GetxStorageConstants.currentUserImage);
    projectHeadName = _getxPref.read(GetxStorageConstants.currentUserName);
    selectedScreenIndex =
        _getxPref.read(GetxStorageConstants.selectedScreenIndex);
    return _buildSidebar(context);
  }

  Widget _buildSidebar(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ProjectHead(
              data: ProjectHeadData(
                imageUrl: projectHeadImageUrl != null ? projectHeadImageUrl : "",
                name: projectHeadName != null ? projectHeadName : "Bug Tracker",
                userName: projectHeadName != null ? projectHeadName : "NCHL User",
              ),
              onPressed: () => {},
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _buildSideBarMenu(context),
          ),
          const Expanded(child: SizedBox(height: kSpacing)),
          Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Text(
              "2023 Bug Tracker",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSideBarMenu(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Dashboard",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.person,
          icon: EvaIcons.personOutline,
          label: "Users",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.cube,
          icon: EvaIcons.cubeOutline,
          label: "Projects",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.hash,
          icon: EvaIcons.hashOutline,
          label: "Bugs",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.activity,
          icon: EvaIcons.activityOutline,
          label: "Activity",
        ),
        SelectionButtonData(
          activeIcon: EvaIcons.logOut,
          icon: EvaIcons.logOutOutline,
          label: "Logout",
        ),
      ],
      // onSelected: (index, value) => {
      //   selectedScreenController.selected(index)
      // },
      selectedButtonIndex: selectedScreenIndex,
    );
  }
}
