part of activity;

class ActivityHeader extends StatelessWidget {
  const ActivityHeader(
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
              label: "Activity Management",
              iconData: Icons.supervised_user_circle,
            ),
            const Expanded(
                child: SizedBox()),

            //Search
            SizedBox(
              width: searchWidth + 50,
              height: 40,
              child: TaskPlannerSearchField(
                hintText: "Search Activity",
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

}
