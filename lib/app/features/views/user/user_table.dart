part of user;

class UserTable extends StatelessWidget {
  const UserTable({Key? key, required this.userController}) : super(key: key);

  // final Responsive screenType;
  // final TabController taskTabController;
  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.17,
      child: ProjectBody(
        child: _buildTableView(context),
      ),
    );
  }

  Widget _buildTableView(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context,
            BoxConstraints constraint) {
          return _buildDataTable(context, constraint);
        });
  }

  Widget _buildDataTable(BuildContext context, var constraint) {
    List<Widget> children = [];

    children.add(
        Obx(() => userController.isLoadingDataTable.value ?
        Container(
          height: constraint.maxHeight - 70,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
          ),
          child: const CircularProgressIndicator(),
        ) :
        Column(
          children: [
            SizedBox(
                width: constraint.maxWidth,
                height: constraint.maxHeight - 70,
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                      filterIconColor: Colors.pink,
                      filterIconHoverColor: Colors.purple,
                      sortOrderNumberBackgroundColor: Colors.tealAccent,
                      sortOrderNumberColor: Colors.pink
                  ),
                  child: SfDataGrid(
                    key: userController._logTableGlobalKey,
                    source: userController._userTableDataSource,
                    columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
                    columnSizer: userController._customColumnSizer,
                    rowHeight: 60,
                    rowsPerPage: userController.rowsPerPage.value,
                    allowFiltering: true,
                    allowSorting: true,
                    allowMultiColumnSorting: true,
                    allowTriStateSorting: true,
                    showSortNumbers: true,
                    allowColumnsResizing: true,
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: <GridColumn>[
                      GridColumn(
                        minimumWidth: 260,
                        maximumWidth: 350,
                        columnName: AppStrings.fullName,
                        columnWidthMode: ColumnWidthMode.auto,
                        visible: true,
                        allowFiltering: false,
                        allowSorting: true,
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.fullName,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 300,
                        columnName: AppStrings.hiddenFullName,
                        allowFiltering: false,
                        allowSorting: true,
                        visible: false,
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.hiddenFullName,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 350,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.email,
                        filterIconPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        filterPopupMenuOptions:
                        const FilterPopupMenuOptions(
                          filterMode:FilterMode.checkboxFilter,
                          canShowSortingOptions: true,
                          canShowClearFilterOption: true,
                          showColumnName: false, ),
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.email,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 350,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.userName,
                        filterIconPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        filterPopupMenuOptions:
                        const FilterPopupMenuOptions(
                          filterMode:FilterMode.checkboxFilter,
                          canShowSortingOptions: true,
                          canShowClearFilterOption: true,
                          showColumnName: false, ),
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.userName,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 350,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.userType,
                        filterIconPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        filterPopupMenuOptions:
                        const FilterPopupMenuOptions(
                          filterMode:FilterMode.checkboxFilter,
                          canShowSortingOptions: true,
                          canShowClearFilterOption: true,
                          showColumnName: false, ),
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.userType,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 350,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.password,
                        allowFiltering: false,
                        allowSorting: false,
                        filterIconPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        filterPopupMenuOptions:
                        const FilterPopupMenuOptions(
                          filterMode:FilterMode.checkboxFilter,
                          canShowSortingOptions: true,
                          canShowClearFilterOption: true,
                          showColumnName: false, ),
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.password,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 100,
                        maximumWidth: 130,
                        allowFiltering: false,
                        allowSorting: false,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.role,
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.role,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 350,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.dateCreated,
                        filterIconPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        filterPopupMenuOptions:
                        const FilterPopupMenuOptions(
                          filterMode:FilterMode.advancedFilter,
                          canShowSortingOptions: true,
                          canShowClearFilterOption: true,
                          showColumnName: false, ),
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.dateCreated,
                              softWrap: true,
                            )),
                      ),
                      GridColumn(
                        minimumWidth: 200,
                        maximumWidth: 200,
                        allowFiltering: false,
                        allowSorting: false,
                        columnWidthMode: ColumnWidthMode.auto,
                        columnName: AppStrings.action,
                        label: Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              AppStrings.action,
                              softWrap: true,
                            )
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.12),
                  border: Border(
                      top: BorderSide(
                          width: .5,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.12)))),
              child: _buildDataPager()
            )
          ],
        )
        )
    );

    return Stack(children: children,);
  }


  Widget _buildDataPager() {

    var pageCount =
    userController._userTableList.isEmpty ? 1.0 :
    (userController._userTableList.length  /
        userController.rowsPerPage.value).ceil().toDouble();

    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Brightness.light,
        selectedItemColor: AppTheme.basic.primaryColor,
      ),
      child: SfDataPager(
          delegate: userController._userTableDataSource,
          direction: Axis.horizontal,
          visibleItemsCount: 10,
          availableRowsPerPage:  const <int>[dataRowPerPage, dataRowPerPage + 5, dataRowPerPage + 10 ],
        onRowsPerPageChanged: (int? rowsPerPage) {
            userController._updateRowsPerPage(rowsPerPage!);
        },
          pageCount: pageCount,
        onPageNavigationStart: (pageIndex) {
            userController.isLoadingDataTable(true);
        },
        onPageNavigationEnd: (pageIndex) {
          userController.isLoadingDataTable(false);
        },
      ),
    );
  }
}
