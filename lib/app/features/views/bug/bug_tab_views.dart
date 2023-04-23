part of bug;

class BugTabViews extends StatelessWidget {
  const BugTabViews({Key? key, required this.controller}) : super(key: key);

  // final Responsive screenType;
  // final TabController taskTabController;
  final BugController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> controller.isLoadingDataTable.value ?
        const Center( child: CircularProgressIndicator())
        : SizedBox(
            width: MediaQuery.of(context).size.width,
            height: controller.screenType != Responsive.desktop
                ? MediaQuery.of(context).size.height * 4
                : MediaQuery.of(context).size.height / 1.15,
            child: TabBarView(
              controller: controller.taskTabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                //Board View
               controller._bugTableList.isEmpty ? const TaskPlannerNoData() :  ProjectBody(
                 child: controller.screenType == Responsive.desktop
                     ? _buildDesktopBoardView(context)
                     : _buildMobileTabletBoardView(context),
               ),

                //Table View
                BugTable(
                  taskController: controller,
                ),

              ],
            )
    )
    );
  }

  Widget _buildDesktopBoardView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.critical,
                taskStatusLabel: AppStrings.critical,
                bugList: controller.criticalBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.major,
                taskStatusLabel: AppStrings.major,
                bugList: controller.majorBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.medium,
                taskStatusLabel: AppStrings.medium,
                bugList: controller.mediumBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.minor,
                taskStatusLabel: AppStrings.minor,
                bugList: controller.minorBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.trivial,
                taskStatusLabel: AppStrings.trivial,
                bugList: controller.trivialBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
      ],
    );
  }

  Widget _buildMobileTabletBoardView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.critical,
                taskStatusLabel: AppStrings.critical,
                bugList: controller.criticalBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.major,
                taskStatusLabel: AppStrings.major,
                bugList: controller.majorBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.medium,
                taskStatusLabel: AppStrings.medium,
                bugList: controller.mediumBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.minor,
                taskStatusLabel: AppStrings.minor,
                bugList: controller.minorBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
        Expanded(
            child: _buildBoardViewSingleTaskColumn(
                context: context,
                type: BugFlag.trivial,
                taskStatusLabel: AppStrings.trivial,
                bugList: controller.trivialBugs)),
        const SizedBox(
          height: kSpacing / 2,
        ),
      ],
    );
  }

  Widget _buildBoardViewSingleTaskColumn(
      {required BuildContext context,
      required BugFlag type,
      required String taskStatusLabel,
      required List<Bug> bugList}) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildHeadingFeaturedBugFlag(type, taskStatusLabel),
          const SizedBox(
            height: kSpacing,
          ),
          Expanded(
            child: bugList.isNotEmpty ? ListView.builder(
              // Let the ListView know how many items it needs to build.
              itemCount: bugList.length,
              // Provide a builder function. This is where the magic happens.
              // Convert each item into a widget based on the type of item it is.
              itemBuilder: (context, index) {
                final item = bugList[index];
                logger.d(item.description);
                logger.d(controller.screenType);
                logger.d(controller.taskTabController);
                  return BugCard(
                    screenType: controller.screenType,
                    taskTabController: controller.taskTabController,
                    bug: item,
                  );
              },
            ) : const SizedBox()
          ),
        ]);
  }

  Widget _buildHeadingFeaturedBugFlag(BugFlag type, String label) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(children: [
        Container(
          width: 30,
          height: 20,
          decoration: BoxDecoration(
              color: bugFlagColorAccordingToBugFlag(type).withOpacity(0.6) ??
                  Colors.grey.withOpacity(0.5),
              border: Border.all(color: Colors.white70),
              borderRadius: const BorderRadius.horizontal(
                  left: Radius.circular(10), right: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: bugFlagColorAccordingToBugFlag(type).withOpacity(0.6) ??
                      Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 2,
                ),
                BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0.1,
                    blurRadius: 0.2)
              ]),
          child: const SizedBox(),
        ),
        const SizedBox(
          width: kSpacing / 1.5,
        ),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold))
      ]),
    );
  }
}
