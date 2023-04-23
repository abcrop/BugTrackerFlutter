part of project;

class ProjectTile extends StatelessWidget {
  final ProjectListDataResponse data;
  final Responsive screenType;
  final Function(String id)? deleteThisProject;

  const ProjectTile({
    Key? key,
    required this.data,
    required this.screenType,
    this.deleteThisProject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBoardTaskCard(context);
  }

  Widget _buildBoardTaskCard(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 15.0),
        child: ListTile(
            tileColor: Colors.blueAccent.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 5.0),
            leading: _buildLeadingUserInfo(context),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: IntrinsicHeight(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _projectInfoAndCount("Ongoing Bugs", data.openBugs!, Colors.red),
                            const VerticalDivider(
                              thickness: 1,
                              width: 5,
                              color: Colors.grey,
                            ),
                            _projectInfoAndCount("Completed Bugs", data.openBugs!, Colors.green),

                          ],
                        ),
                      ),
                    ),
                  ),
                 Expanded(child:  IntrinsicHeight(
                   child: SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         _projectInfoAndCount("Critical Bugs", data.criticalBugs!, Colors.red),
                         const VerticalDivider(
                                thickness: 1,
                                width: 5,
                                color: Colors.grey,
                              ),
                         _projectInfoAndCount("Major Bugs", data.majorBugs!, Colors.orange),
                         const VerticalDivider(
                                thickness: 1,
                                width: 5,
                                color: Colors.grey,
                              ),
                         _projectInfoAndCount("Medium Bugs", data.mediumBugs!, Colors.purple),
                         const VerticalDivider(
                                thickness: 1,
                                width: 5,
                                color: Colors.grey,
                              ),
                         _projectInfoAndCount("Minor Bugs", data.minorBugs!, Colors.green),
                         const VerticalDivider(
                                thickness: 1,
                                width: 5,
                                color: Colors.grey,
                              ),
                         _projectInfoAndCount("Trivial Bugs", data.trivialBugs!, Colors.black),

                       ],
                     ),
                   ),
                 ))
                ],
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => {_showEditProjectDialog(data.project!)},
                      child: const Tooltip(
                        message: "Edit Project",
                        child: Icon(Icons.edit, color: Colors.black54),
                      ),
                    ),
                    const SizedBox(
                      width: kSpacing,
                    ),
                    InkWell(
                      onTap: () => {_showDeleteFileDialog()},
                      child: const Tooltip(
                          message: "Delete Project",
                          child: Icon(Icons.delete, color: Colors.black54)),
                    ),
                  ]),
            )
        )
    );
  }

  Widget _projectInfoAndCount(String label, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Text(
          label,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: color
          )
      ),
      const SizedBox(width: kSpacing),

      Text(
          count.toString(),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: color
          )
      )

          ]),
    );
  }

  Widget _buildLeadingUserInfo(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatarWithAdminIndicator(
              imageUrl: data.project!.image,
              isAdmin: false,
            ),
          ),
          const SizedBox(width: kSpacing / 3),

          ///To textoverflow to become ellipsis use Expanded inside Row/Column
          Expanded(
              child:Tooltip(
                richMessage: WidgetSpan(
                    alignment: PlaceholderAlignment.baseline,
                    baseline: TextBaseline.alphabetic,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: Text(
                        data.project!.description!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )),
                decoration: BoxDecoration(
                  color: AppTheme.basic.primaryColor,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(4)),
                ),
                preferBelow: false,
                verticalOffset: 10,
                textAlign: TextAlign.justify,
                child: Text(
                  data.project!.name!,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
          ),
        ]),
      ),
    );
  }

  _showEditProjectDialog(Project project) async {
    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: false,
        onWillPop: () async => false,
        title: "",
        content: SizedBox(
            width: dialogWidth,
            height: dialogHeight,
            child: AddEditProject(
              project: project,
            )));
  }

  _showDeleteFileDialog() {
    return Get.defaultDialog(
        onWillPop: () async => false,
        title: "Delete Project",
        middleText: "Do you want to delete ${data.project!.name} ?",
        textConfirm: "Yes",
        radius: kBorderRadius,
        confirmTextColor: Colors.white,
        textCancel: "No",
        barrierDismissible: false,
        onCancel: () => Get.back(),
        onConfirm: () {
          deleteThisProject!(data.project!.id!);
          Get.back();
        });
  }

  directorySnackBar({String? title = "Project Screen", String? description}) {
    Get.snackbar(
      title!,
      description!,
      colorText: Colors.white,
      backgroundColor: Colors.black.withOpacity(0.8),
      maxWidth: 500,
      margin: const EdgeInsets.symmetric(vertical: kSpacing),
    );
  }
}
