part of bug;

class BugTable extends StatelessWidget {
  const BugTable({Key? key, required this.taskController}) : super(key: key);

  final BugController taskController;

  @override
  Widget build(BuildContext context) {
    return ProjectBody(
      child: _buildTableView(context),
    );
  }

  Widget _buildTableView(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraint) {
      return _buildDataTable(context, constraint);
    });
  }

  Widget _buildDataTable(BuildContext context, var constraint) {
    List<Widget> children = [];

    children.add(
      Obx(()=>taskController.isLoadingDataTable.value ?
      Container(
        height: constraint.maxHeight - 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.6),
        ),
        child: const CircularProgressIndicator(),
      ):
      Column(children: [
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
              key: taskController._bugTableGlobalKey,
              source: taskController._bugTableDataSource,
              columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
              columnSizer: taskController._customColumnSizer,
              rowHeight: 60,
              rowsPerPage: taskController.rowsPerPage.value,
              allowFiltering: true,
              allowSorting: true,
              allowMultiColumnSorting: true,
              allowTriStateSorting: true,
              showSortNumbers: true,
              allowColumnsResizing: true,
              columnWidthMode: ColumnWidthMode.auto,
              columns: <GridColumn>[
                GridColumn(
                  minimumWidth: 150,
                  maximumWidth: 180,
                  columnName: AppStrings.title,
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
                        AppStrings.title,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 220,
                  maximumWidth: 270,
                  allowFiltering: false,
                  allowSorting: false,
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.advancedFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.description,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.description,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 170,
                  maximumWidth: 220,
                  allowSorting: false,
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.bugStatus,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.bugStatus,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 170,
                  maximumWidth: 220,
                  allowSorting: false,
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.bugFlag,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.bugFlag,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnName: AppStrings.reporter,
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  allowFiltering: false,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.reporter,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnName: AppStrings.assignedTo,
                  allowFiltering: false,
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.assignedTo,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnName: AppStrings.hiddenReporter,
                  visible: false,
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.hiddenReporter,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnName: AppStrings.hiddenAssignedTo,
                  visible: false,
                  columnWidthMode: ColumnWidthMode.fitByColumnName,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.hiddenAssignedTo,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 170,
                  maximumWidth: 220,
                  allowSorting: false,
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.checkboxFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.appVersion,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.appVersion,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 180,
                  maximumWidth: 240,
                  allowSorting: false,
                  allowFiltering: false,
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.logcat,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.logcat,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 180,
                  maximumWidth: 240,
                  allowSorting: false,
                  allowFiltering: false,
                  columnWidthMode: ColumnWidthMode.auto,
                  columnName: AppStrings.screenshot,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.screenshot,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  allowSorting: false,
                  filterPopupMenuOptions:
                  const FilterPopupMenuOptions(
                    filterMode:FilterMode.advancedFilter,
                    canShowSortingOptions: false,
                    canShowClearFilterOption: true,
                    showColumnName: false, ),
                  columnName: AppStrings.dateCreated,
                  label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        AppStrings.dateCreated,
                        softWrap: true,
                      )),
                ),
                GridColumn(
                  minimumWidth: 240,
                  maximumWidth: 280,
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
          child: Align(child: _buildDataPager()),
        )
      ])
      )
    );

    return Stack(children: children,);
  }

  Widget _buildDataPager() {
    var pageCount =
    taskController._bugTableList.isEmpty ? 1.0 :
    (taskController._bugTableList.length  /
        taskController.rowsPerPage.value).ceil().toDouble();

    return SfDataPagerTheme(
      data: SfDataPagerThemeData(
        brightness: Brightness.light,
        selectedItemColor: AppTheme.basic.primaryColor,
      ),
      child: SfDataPager(
          delegate: taskController._bugTableDataSource,
          direction: Axis.horizontal,
          visibleItemsCount: 10,
          availableRowsPerPage:  const <int>[dataRowPerPage, dataRowPerPage + 5, dataRowPerPage + 10 ],
          pageCount: pageCount,
          onPageNavigationStart: (pageIndex) {
            taskController.isLoadingDataTable(true);
          },
          onPageNavigationEnd: (pageIndex) {
            taskController.isLoadingDataTable(false);
          },
        onRowsPerPageChanged: (int? rowsPerPage) {
          taskController._updateRowsPerPage(rowsPerPage!);
        },
      ),
    );
  }
}
