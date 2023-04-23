part of project;

class ProjectResponseListView extends StatelessWidget {
  ProjectResponseListView(
      {Key? key,
      required this.screenType,
      this.projectList,
      this.isGridLoading,
      this.deleteThisProject})
      : super(key: key);

  final Responsive screenType;
  final RxList<ProjectListDataResponse>? projectList;
  final RxBool? isGridLoading;
  final Function(String id)? deleteThisProject;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 1.13,
        child: Obx(
          () => isGridLoading!.value
              ? const CircularProgressIndicator()
              : ProjectBody(
                  child: projectList!.value.isEmpty
                      ? const TaskPlannerNoData()
                      : ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: projectList!.length,
                          itemBuilder: (context, index) => ProjectTile(
                            data: projectList![index],
                            deleteThisProject: deleteThisProject,
                            screenType: screenType,
                          ),
                        ),
                ),
        ));
  }
}
