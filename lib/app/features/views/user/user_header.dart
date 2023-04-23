part of user;

class UserHeader extends StatelessWidget {
  const UserHeader(
      {Key? key, this.onSearch, this.screenType, this.searchController})
      : super(key: key);

  final Function()? onSearch;
  final Responsive? screenType;
  final TextEditingController? searchController;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Task Header
      ProjectHeader(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const BuildPageTitle(
              label: "User Management",
              iconData: Icons.supervised_user_circle,
            ),
            const Expanded(
                child: SizedBox()),

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
                    Text("Add User",
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
                hintText: "Search User",
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
            child: AddEditUser())
    );
  }
}
