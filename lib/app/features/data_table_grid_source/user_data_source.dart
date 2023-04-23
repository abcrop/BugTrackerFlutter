part of user;

class UserTableDataSource extends DataGridSource {
  // use it for paginated data only
  List<User> _paginatedUsers = [];

  //Third data prepared to show for each row
  List<DataGridRow> _userRows = <DataGridRow>[];

  final List<User> userTableList;

  final int? rowsPerPage;

  final Responsive? screenType;

  @override
  List<DataGridRow> get rows => _userRows;

  UserTableDataSource(
      {required this.userTableList, this.rowsPerPage, this.screenType});

  void buildPaginatedDataGridRows() {
    logger.d(
        "printing _paginatedUser from BuildPaginatedDataGridRows ${_paginatedUsers.length}");
    _userRows = _paginatedUsers
        .map<DataGridRow>((User user) => DataGridRow(cells: <DataGridCell>[
              DataGridCell<User>(columnName: AppStrings.fullName, value: user),
              DataGridCell<String>(
                  columnName: AppStrings.hiddenFullName, value: user.fullName),
              DataGridCell<String>(
                  columnName: AppStrings.email, value: user.email),
              DataGridCell<String>(
                  columnName: AppStrings.userName, value: user.userName),
              DataGridCell<String>(
                columnName: AppStrings.userType,
                value: userTypeToString(user.userType!),
              ),
              DataGridCell<String>(
                  columnName: AppStrings.password, value: user.password),
              DataGridCell<String>(
                  columnName: AppStrings.role, value: user.role),
              DataGridCell<DateTime>(
                  columnName: AppStrings.dateCreated,
                  value: anyMillisecondsToDateTime(user.dateCreated!)),
              DataGridCell<User>(columnName: AppStrings.action, value: user),
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

    ///full name
    if (columnString == AppStrings.fullName.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Align(
            alignment: Alignment.center,
            child: CircleAvatarWithAdminIndicator(
              imageUrl: getImage(cellValue as User),
              isAdmin: getIsAdmin(cellValue as User),
            ),
          ),
          const SizedBox(width: kSpacing / 3),

          ///To textoverflow to become ellipsis use Expanded inside Row/Column
          Expanded(
              child: getFullName(cellValue as User).length > 15
                  ? Tooltip(
                      richMessage: WidgetSpan(
                          alignment: PlaceholderAlignment.baseline,
                          baseline: TextBaseline.alphabetic,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Text(
                              getFullName(cellValue as User),
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
                        getFullName(cellValue as User),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    )
                  : Text(
                      getFullName(cellValue as User),
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
      return _buildAction(cellValue as User);
    }

    ///User type
    if (columnString == AppStrings.userType.trim().toLowerCase()) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color:
                userTypeColorAccordingToUserType(stringToUserType(cellValue))
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

  getIsAdmin(User user) {
    return user.userType == UserType.admin ? true : false;
  }

  getImage(User user) {
    return user.image;
  }

  getFullName(User user) {
    return user.fullName;
  }

  Widget _buildAction(User user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
          child: ElevatedButton(
            onPressed: () => {_showEditUserDialog(user)},
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
          onPressed: () => {_showDeleteUserDialog(user)},
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

    if (endIndex > userTableList.length) {
      endIndex = userTableList.length;
    }
    logger.d(" start index: $startIndex and end index: $endIndex");
    logger.d("old page index: $oldPageIndex and new page index: $newPageIndex");

    if (startIndex <= userTableList.length &&
        endIndex <= userTableList.length) {
      logger.d("data fetching next");
      //This logic: When the current pagination is in last page
      _paginatedUsers =
          userTableList.getRange(startIndex, endIndex).toList(growable: false);
    } else {
      logger.d("data fetching failed to do next");
      _paginatedUsers = [];
    }
    buildPaginatedDataGridRows();
    handleChange();
    return Future<bool>.value(true);
  }

  void handleChange() {
    logger.d("handle change ");
    notifyListeners();
  }

  _showEditUserDialog(User user) {
    BuildContext context = Get.context!;

    return Get.defaultDialog(
        backgroundColor: Colors.transparent,
        barrierDismissible: false,
        onWillPop: () async => false,
        title: "",
        content: SizedBox(
            width: calculateAlertWidth(context, screenType!),
            height: calculateAlertHeight(context, screenType!),
            child: AddEditUser(
              user: user,
            )));
  }

  void _deleteThisUser(User user) async {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    //
    // WriteBatch batch = firestore.batch();
    //
    // QuerySnapshot<Map<String, dynamic>> queryCodebaseSnapshot = await firestore
    //     .collection(FireConstants.colUser)
    //     .where(FireConstants.id, isEqualTo: user!.id)
    //     .get();
    // DocumentReference codebaseReference =
    //     queryCodebaseSnapshot.docs.first.reference;
    // DocumentReference userReference =
    //     firestore.collection(FireConstants.colUser).doc(user.id?.trim());
    //
    // batch.delete(codebaseReference);
    // batch.delete(userReference);
    //
    // batch.commit().then((value) {
    //   if (user.image!.isNotEmpty) {
    //     final Reference storageRef =
    //         FirebaseStorage.instance.refFromURL(user.image!);
    //
    //     storageRef.delete().then((value) {
    //       userSnackBar(description: "Successfully delete user.");
    //       return;
    //     });
    //   } else {
    //     userSnackBar(description: "Successfully delete user.");
    //   }
    //
    //   // var imageRef = storageRef.
    //   // imageRef.delete();
    // }).catchError((error) {
    //   logger.d("Something went wrong.");
    //   userSnackBar(
    //       description: "Something went wrong while deleting user. Try again.");
    // });
  }

  _showDeleteUserDialog(User user) {
    return Get.defaultDialog(
        onWillPop: () async => false,
        title: "Delete User",
        middleText: "Do you want to delete ${user.fullName} ?",
        textConfirm: "Yes",
        radius: kBorderRadius,
        confirmTextColor: Colors.white,
        textCancel: "No",
        barrierDismissible: false,
        onCancel: Get.back,
        onConfirm: () {
          _deleteThisUser!(user);
          Get.back();
        });
  }

  userSnackBar({String? title = "User Screen", String? description}) {
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
