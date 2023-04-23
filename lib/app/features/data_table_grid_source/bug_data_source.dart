part of bug;

class BugTableDataSource extends DataGridSource {
  // use it for paginated data only
  List<Bug> _paginatedBugs = [];

  //Third data prepared to show for each row
  List<DataGridRow> _bugRows = <DataGridRow>[];

  final List<Bug> bugTableList;

  final int? rowsPerPage;

  final Responsive? screenType;

  @override
  List<DataGridRow> get rows => _bugRows;

  BugTableDataSource(
      {required this.bugTableList, this.rowsPerPage, this.screenType});

  void buildPaginatedDataGridRows() {
    logger.d(
        "printing _paginatedBug from BuildPaginatedDataGridRows ${_paginatedBugs.length}");
    _bugRows = _paginatedBugs
        .map<DataGridRow>((Bug bug) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<String>(
                  columnName: AppStrings.title, value: bug.title),
              DataGridCell<String>(
                  columnName: AppStrings.description, value: bug.description),
              DataGridCell<String>(
                columnName: AppStrings.bugStatus,
                value: bugStatusToString(bug.bugStatus!),
              ),
              DataGridCell<String>(
                columnName: AppStrings.bugFlag,
                value: bugFlagToString(bug.bugFlag!),
              ),
              DataGridCell<User>(
                columnName: AppStrings.reporter,
                value: bug.reporter!,
              ),
              DataGridCell<User>(
                columnName: AppStrings.assignedTo,
                value: bug.assignedTo!,
              ),
              DataGridCell<String>(
                columnName: AppStrings.hiddenReporter,
                value: bug.reporter!.fullName,
              ),
              DataGridCell<String>(
                columnName: AppStrings.hiddenAssignedTo,
                value: bug.assignedTo!.fullName,
              ),
              DataGridCell<String>(
                  columnName: AppStrings.appVersion, value: bug.appVersion),
              DataGridCell<String>(
                  columnName: AppStrings.logcat, value: bug.logcat),
              DataGridCell<String>(
                  columnName: AppStrings.screenshot, value: bug.screenshot),
              DataGridCell<DateTime>(
                  columnName: AppStrings.dateCreated,
                  value: anyMillisecondsToDateTime(bug.dateCreated!)),
              DataGridCell<Bug>(columnName: AppStrings.action, value: bug),
            ]))
        .toList(growable: false);
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final List<Widget> children = <Widget>[];

    for (DataGridCell<dynamic> cell in row.getCells()) {
      children.add(_getWidget(cell.columnName, cell.value));
    }
    return DataGridRowAdapter(cells: children);
  }

  Widget _getWidget(String columnName, dynamic cellValue) {
    final columnString = columnName.trim().toLowerCase();

    ///Reporter
    if (columnString == AppStrings.reporter.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatarWithAdminIndicator(
              imageUrl: getImageReporter(cellValue as User),
              isAdmin: getIsAdminReporter(cellValue as User),
            ),
          ),
          const SizedBox(width: kSpacing / 3),

          ///To textoverflow to become ellipsis use Expanded inside Row/Column
          Expanded(
              child: getFullNameReporter(cellValue as User).length > 15
                  ? Tooltip(
                      richMessage: WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Text(
                              getFullNameReporter(cellValue as User),
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
                        getFullNameReporter(cellValue as User),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Text(
                      getFullNameReporter(cellValue as User),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
        ]),
      );
    }

    ///Assigned to
    if (columnString == AppStrings.assignedTo.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatarWithAdminIndicator(
              imageUrl: getImageAssignedTo(cellValue as User),
              isAdmin: getIsAdminAssignedTo(cellValue as User),
            ),
          ),
          const SizedBox(width: kSpacing / 3),

          ///To textoverflow to become ellipsis use Expanded inside Row/Column
          Expanded(
              child: getFullNameAssignedTo(cellValue as User).length > 15
                  ? Tooltip(
                      richMessage: WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Text(
                              getFullNameAssignedTo(cellValue as User),
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
                        getFullNameAssignedTo(cellValue as User),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Text(
                      getFullNameAssignedTo(cellValue as User),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    )),
        ]),
      );
    }

    ///action
    if (columnString == AppStrings.action.trim().toLowerCase()) {
      return _buildAction(cellValue as Bug);
    }

    ///description
    if(columnString == AppStrings.description.trim().toLowerCase()) {
      return Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
        child: cellValue.length > 15
            ? Tooltip(
          richMessage: WidgetSpan(
              alignment: PlaceholderAlignment.baseline,
              baseline: TextBaseline.alphabetic,
              child: Container(
                padding: const EdgeInsets.all(10),
                constraints: const BoxConstraints(maxWidth: 250),
                child: Text(
                  cellValue as String,
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
            cellValue as String,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
            : Text(
          cellValue as String,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        )
      );
    }
    ///Bug status
    if (columnString == AppStrings.bugStatus.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                bugStatusColorAccordingToBugStatus(stringToBugStatus(cellValue))
                        .withOpacity(0.8) ??
                    Colors.grey.withOpacity(0.5),
            border: Border.all(color: Colors.white70),
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10), right: Radius.circular(10)),
          ),
          child: Text(
            cellValue.toUpperCase(),
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    ///Bug Flag
    if (columnString == AppStrings.bugFlag.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: bugFlagColorAccordingToBugFlag(stringToBugFlag(cellValue))
                    .withOpacity(0.8) ??
                Colors.grey.withOpacity(0.5),
            border: Border.all(color: Colors.white70),
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(10), right: Radius.circular(10)),
          ),
          child: Text(
            cellValue.toUpperCase(),
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    ///date created
    if (columnString == AppStrings.dateCreated.trim().toLowerCase()) {
      return _buildDatetime(cellValue as DateTime);
    }

    ///logcat
    if (columnString == AppStrings.logcat.trim().toLowerCase()) {
      return _buildLogcat(cellValue as String);
    }

    ///screenshot
    if (columnString == AppStrings.screenshot.trim().toLowerCase()) {
      return _buildScreenshot(cellValue as String);
    }

    ///rest
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        cellValue,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.start,
      ),
    );
  }

  _buildLogcat(String? logcat) {
    return InkWell(
        onTap: () => {_showLogcatDialog(logcat)},
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            logcat!,
            overflow: TextOverflow.ellipsis,        textAlign: TextAlign.start,

          ),
        ));
  }

  _buildScreenshot(String? image) {
    return Center(
      child: InkWell(
          onTap: () => {_showScreenshotDialog(image)},
          child: SizedBox(
            child: Center(
              child: CachedImage(
                imageUrl: image!,
              ),
            ),
          )),
    );
  }

  _showLogcatDialog(String? logcat) async {
    BuildContext context = Get.context!;

    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: true,
        onWillPop: () async => true,
        title: "",
        content: SizedBox(
            // width: calculateAlertWidth(context, screenType),
            // height:  calculateAlertHeight(context, screenType),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.4,
            child: TaskPlannerPopup(
              popupTitle: "Logcat",
              onClose: () {
                Get.back();
              },
              child: Text(logcat!),
            )));
  }

  _showScreenshotDialog(String? image) async {
    BuildContext context = Get.context!;

    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: true,
        onWillPop: () async => true,
        title: "",
        content: SizedBox(
            // width: calculateAlertWidth(context, screenType),
            // height:  calculateAlertHeight(context, screenType),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.4,
            child: ShowImageAlert(
              image: image!,
            )));
  }

  Widget _buildDatetime(DateTime datetime) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(14.0, 6, 6, 6),
      child: Text(
        DateFormat.yMd().add_jm().format(datetime),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  getIsAdminReporter(User user) {
    return user!.userType == UserType.admin ? true : false;
  }

  getImageReporter(User user) {
    return user!.image;
  }

  getFullNameReporter(User user) {
    return user!.fullName!;
  }

  getIsAdminAssignedTo(User user) {
    return user!.userType == UserType.admin ? true : false;
  }

  getImageAssignedTo(User user) {
    return user!.image;
  }

  getFullNameAssignedTo(User user) {
    return user!.fullName!;
  }

  Widget _buildAction(Bug bug) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
          child: ElevatedButton(
            onPressed: () => {_showEditBugDialog(bug)},
            onLongPress: () => null,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.green),
              foregroundColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                AppStrings.edit,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: fontNormal),
              ),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => {_showDeleteBugDialog(bug)},
          onLongPress: () => null,
          style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.red),
            foregroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              AppStrings.delete,
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: fontNormal),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    logger.d("handle next page");

    int startIndex = newPageIndex * (rowsPerPage!);
    int endIndex = startIndex + (rowsPerPage!);

    if (endIndex > bugTableList.length) {
      endIndex = bugTableList.length;
    }
    logger.d(" start index: $startIndex and end index: $endIndex");
    logger.d("old page index: $oldPageIndex and new page index: $newPageIndex");

    if (startIndex <= bugTableList.length && endIndex <= bugTableList.length) {
      logger.d("data fetching next");
      //This logic: When the current pagination is in last page
      _paginatedBugs =
          bugTableList.getRange(startIndex, endIndex).toList(growable: false);
    } else {
      logger.d("data fetching failed to do next");
      _paginatedBugs = [];
    }
    buildPaginatedDataGridRows();
    handleChange();
    return Future<bool>.value(true);
  }

  void handleChange() {
    logger.d("handle change ");
    notifyListeners();
  }

  _showEditBugDialog(Bug bug) {
    BuildContext context = Get.context!;

    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: false,
        onWillPop: () async => false,
        title: "",
        content: SizedBox(
            width: calculateAlertWidth(context, screenType!),
            height: calculateAlertHeight(context, screenType!),
            child: AddEditBug(
              bug: bug,
            )));
  }

  void _deleteThisBug(Bug bug) async {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    // WriteBatch batch = firestore.batch();
    //
    // QuerySnapshot<Map<String, dynamic>> queryCodebaseSnapshot = await firestore
    //     .collection(FireConstants.colBug)
    //     .where(FireConstants.id, isEqualTo: bug!.id)
    //     .get();
    // DocumentReference codebaseReference =
    //     queryCodebaseSnapshot.docs.first.reference;
    // DocumentReference bugReference =
    //     firestore.collection(FireConstants.colBug).doc(bug.id?.trim());
    //
    // batch.delete(codebaseReference);
    // batch.delete(bugReference);
    //
    // batch.commit().then((value) {
    //   if (bug.image!.isNotEmpty) {
    //     final Reference storageRef =
    //         FirebaseStorage.instance.refFromURL(bug.image!);
    //
    //     storageRef.delete().then((value) {
    //       bugSnackBar(description: "Successfully delete bug.");
    //       return;
    //     });
    //   } else {
    //     bugSnackBar(description: "Successfully delete bug.");
    //   }
    //
    //   // var imageRef = storageRef.
    //   // imageRef.delete();
    // }).catchError((error) {
    //   logger.d("Something went wrong.");
    //   bugSnackBar(
    //       description: "Something went wrong while deleting bug. Try again.");
    // });
  }

  _showDeleteBugDialog(Bug bug) {
    return Get.defaultDialog(
        onWillPop: () async => false,
        title: "Delete Bug",
        middleText: "Do you want to delete ${bug.title} ?",
        textConfirm: "Yes",
        radius: kBorderRadius,
        confirmTextColor: Colors.white,
        textCancel: "No",
        barrierDismissible: false,
        onCancel: Get.back,
        onConfirm: () {
          _deleteThisBug!(bug);
          Get.back();
        });
  }

  bugSnackBar({String? title = "Bug Screen", String? description}) {
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
