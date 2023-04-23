part of bug;

class BugCard extends StatelessWidget {
  BugCard({
    Key? key,
    required this.screenType,
    required this.taskTabController,
    required this.bug,
  }) : super(key: key);

  final Responsive screenType;
  final TabController taskTabController;
  final Bug bug;
  Rx<bool> isExpandedDescription = false.obs;

  @override
  Widget build(BuildContext context) {
    return _buildBoardTaskCard(context);
  }

  Widget _buildBoardTaskCard(BuildContext context) {
    return Card(
        shadowColor: Colors.black,
        elevation: 5.0,
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 20),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //Title and Repetition
              _buildTaskCardHeader(),
              const SizedBox(
                height: kSpacing / 2,
              ),

              //Description
              Obx(() => InkWell(
                  onTap: bug.description!.length > 100
                      ? () =>
                          isExpandedDescription(!isExpandedDescription.value)
                      : null,
                  child: !isExpandedDescription.value
                      ? Text(
                          bug.description!.length > 100
                              ? bug.description!.substring(0, 100) + "...."
                              : bug.description!,
                          textAlign: TextAlign.start,
                        )
                      : Text(
                          bug.description!,
                          textAlign: TextAlign.start,
                        ))),
              const SizedBox(
                height: kSpacing / 2,
              ),

              //Category and User
              _buildTaskCardCategoryAndUser(context),

              const SizedBox(
                height: kSpacing / 2,
              ),

              //Bug Status
              _buildBugStatus(),
            ],
          ),
        ));
  }

  Widget _buildTaskCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            bug.title!,
            style: const TextStyle(
              fontSize: fontNormal,
              color: Colors.black,
              fontWeight: FontWeight.w800,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          width: kSpacing / 5,
        ),
        const Tooltip(
          message: "Bug",
          child: Icon(
            Icons.bug_report_outlined,
            color: iconBlackLight,
            size: logoSizeSmall,
          ),
        )
      ],
    );
  }

  Widget _buildBugStatus() {
    return Tooltip(
      message: "Bug Status",
      child: Card(
        color:
            bugStatusColorAccordingToBugStatus(bug.bugStatus!).withAlpha(199),
        elevation: 3.0,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
            child: Text(
              bug.bugStatus!.name.toUpperCase(),
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            )),
      ),
    );
  }

  Widget _buildTaskCardCategoryAndUser(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          CircleAvatarWithAdminIndicator(
              isAdmin: bug.reporter!.userType == UserType.admin ? true : false,
              imageUrl: bug.reporter!.image,
              imageTooltipMsg: "Bug Reported By: ${bug.reporter!.fullName}",
              size: const HeightWidth(width: 35, height: 35)),
          const Expanded(
            child: SizedBox(
              width: kSpacing / 2.5,
            ),
          ),
          CircleAvatarWithAdminIndicator(
              isAdmin:
                  bug.assignedTo!.userType == UserType.admin ? true : false,
              imageUrl: bug.assignedTo!.image,
              imageTooltipMsg: "Bug Assigned To: ${bug.assignedTo!.fullName}",
              size: const HeightWidth(width: 35, height: 35)),
        ],
      ),
    );
  }
}
