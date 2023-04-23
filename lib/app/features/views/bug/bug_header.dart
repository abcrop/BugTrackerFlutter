part of bug;

class BugHeader extends StatelessWidget {
  const BugHeader(
      {Key? key, this.onSearch, this.screenType, this.searchController, this.taskTabController, this.taskTabs, this.taskCurrentTabIndex})
      : super(key: key);

  final Function()? onSearch;
  final Responsive? screenType;
  final TextEditingController? searchController;
  final TabController? taskTabController;
  final List<Tab>? taskTabs;
  final RxInt? taskCurrentTabIndex;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Task Header
      ProjectHeader(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const BuildPageTitle(
              label: "Bugs Management",
              iconData: Icons.bug_report_sharp,
            ),
            // const Expanded(
            //     child: SizedBox()),

            const SizedBox(width: kSpacing /2,),
            //tab view
            Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: taskTabController,
                    physics: screenType == Responsive.mobile ? const ClampingScrollPhysics() : const AlwaysScrollableScrollPhysics(),
                    // const NeverScrollableScrollPhysics(),
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: taskTabs!,
                    onTap: (selectedIndex) {
                      taskCurrentTabIndex!(selectedIndex);
                    },
                  )),
            ),

            //Export
            ElevatedButton(
              onPressed: () => {_showAddUserDialog(context)},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    //icon
                    const Icon(
                      Icons.add,
                      size: fontNormal,
                    ),
                    const SizedBox(width: kSpacing / 4),
                    //text
                    Text("Submit Bug",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenType != Responsive.desktop
                                ? 12.0
                                : 15.0)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: kSpacing /2 ,),
            // const SizedBox(
            //   width: kSpacing/1.5,
            // ),

            //Search
            SizedBox(
              width: searchWidth + 50,
              height: 40,
              child: TaskPlannerSearchField(
                hintText: "Search Bugs",
                controller: searchController ,
                onSearch: onSearch,
              ),
            )
          ],
        ),
      ),

      const SizedBox(
        height: kSpacing / 2,
      ),
    ]);
  }

  _showAddUserDialog(BuildContext context) async {
    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: false,
        title: "",
        onWillPop: () async => false,
        content:  SizedBox(
            width: calculateAlertWidth(context, screenType!),
            height: calculateAlertHeight(context, screenType!),
            child: AddEditBug())
    );
  }
}
