import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../config/themes/app_theme.dart';
import '../constants/app_constants.dart';
import '../utils/helpers/app_helpers.dart';

class TaskPlannerDropdown2<T> extends StatelessWidget {
  const TaskPlannerDropdown2(
      {Key? key,
        this.dropdownList,
        this.textEditingController,
      required this.selectedValue,
      required this.onChangeDropdownItem,
      required this.hintValue,
      this.isDropdownOpen})
      : super(key: key);

  final T? selectedValue;
  final String hintValue;
  final TextEditingController? textEditingController;
  final Function(T? value)? onChangeDropdownItem;
  final RxBool? isDropdownOpen;
  final List<T>? dropdownList;

  @override
  Widget build(BuildContext context) {
    return _returnSpecificDropDown(context);
  }

  Widget _returnSpecificDropDown(BuildContext context) {
    if(selectedValue is BugStatus) {
      return _buildDropdownForBugStatus(context);
    }
    else if (selectedValue is BugFlag) {
      return _buildDropdownForBugFlag(context);
    }
    else if (selectedValue is UserType) {
      return _buildDropdownForUserType(context);
    }
    return const SizedBox();
  }

  Widget _buildDropdownForUserType(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<UserType>(
          customButton: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(
                    width: 2,
                    color: AppTheme.basic.primaryColor.withOpacity(0.7))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    color: AppTheme.basic.primaryColor,
                  ),
                  const SizedBox(
                    width: kSpacing,
                  ),
                  selectedValue == null
                      ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(hintValue),
                  )
                      : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(getUserTypeSelectedText(selectedValue as UserType)),
                  )
                ],
              ),
            ),
            //   child : TextFormField(
            //     controller: textEditingController,
            //     textAlignVertical: TextAlignVertical.center,
            //     textAlign: TextAlign.start,
            //     decoration: taskPlannerInputDecoration(
            //         prefixIcon: const Icon(Icons.sort),
            //         hintText: "Choose Status"),
            //     readOnly: true,
            //     validator: (String? value) {
            //       if (value == null || value.isEmpty) {
            //         return "Please choose a date.";
            //       } else {
            //         return null;
            //       }
            //     },
            //   )
          ),
          //default and custom button's radius
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownElevation: 2,
          dropdownWidth: 200,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(kBorderRadius),
          //   // color: Colors.redAccent,
          // ),
          offset: const Offset(-15, -5),
          //color of button after option is selected
          focusColor: Colors.grey.withAlpha(50),
          value: selectedValue as UserType,
          items: createDropdownMenuItemForUserType(dropdownList as List<UserType>),
          onChanged: (selectedUserType) {
            onChangeDropdownItem!( selectedUserType as T);
          },
          //use hint with value: null
          // hint: Text(
          //   'Sort by',
          //   style: TextStyle(
          //     color: Theme.of(context).hintColor,
          //   ),
          // ),
          // center default button's items
          // alignment: Alignment.center,
          //default button icon
          // icon: Icon(Icons.sort),
          //default button's icon color
          // iconEnabledColor: AppTheme.basic.primaryColor,
        ),
      ),
    );
  }

  getUserTypeSelectedText(UserType taskStatus) {
    return taskStatus.name.toUpperCase();
  }

  createDropdownMenuItemForUserType(List<UserType> list) {
    return list
        .map((UserType val) {
      return DropdownMenuItem<UserType>(
        value: val,
        child: Text(getUserTypeSelectedText(val)),
      );
    }
    )
        .toList();
  }

  Widget _buildDropdownForBugStatus(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<BugStatus>(
          customButton: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(
                    width: 2,
                    color: AppTheme.basic.primaryColor.withOpacity(0.7))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    color: AppTheme.basic.primaryColor,
                  ),
                  const SizedBox(
                    width: kSpacing,
                  ),
                  selectedValue == null
                      ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(hintValue),
                  )
                      : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(getBugStatusSelectedText(selectedValue as BugStatus)),
                  )
                ],
              ),
            ),
            //   child : TextFormField(
            //     controller: textEditingController,
            //     textAlignVertical: TextAlignVertical.center,
            //     textAlign: TextAlign.start,
            //     decoration: taskPlannerInputDecoration(
            //         prefixIcon: const Icon(Icons.sort),
            //         hintText: "Choose Status"),
            //     readOnly: true,
            //     validator: (String? value) {
            //       if (value == null || value.isEmpty) {
            //         return "Please choose a date.";
            //       } else {
            //         return null;
            //       }
            //     },
            //   )
          ),
          //default and custom button's radius
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownElevation: 2,
          dropdownWidth: 200,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(kBorderRadius),
          //   // color: Colors.redAccent,
          // ),
          offset: const Offset(-15, -5),
          //color of button after option is selected
          focusColor: Colors.grey.withAlpha(50),
          value: selectedValue as BugStatus,
          items: createDropdownMenuItemForBugStatus(dropdownList as List<BugStatus>),
          onChanged: (selectedBugStatus) {
            onChangeDropdownItem!( selectedBugStatus as T);
          },
          //use hint with value: null
          // hint: Text(
          //   'Sort by',
          //   style: TextStyle(
          //     color: Theme.of(context).hintColor,
          //   ),
          // ),
          // center default button's items
          // alignment: Alignment.center,
          //default button icon
          // icon: Icon(Icons.sort),
          //default button's icon color
          // iconEnabledColor: AppTheme.basic.primaryColor,
        ),
      ),
    );
  }

  getBugStatusSelectedText(BugStatus taskStatus) {
    return taskStatus.name.toUpperCase();
  }

  createDropdownMenuItemForBugStatus(List<BugStatus> list) {
    return list
        .map((BugStatus val) {
            return DropdownMenuItem<BugStatus>(
              value: val,
              child: Text(getBugStatusSelectedText(val)),
            );
    }
    )
        .toList();
  }

  Widget _buildDropdownForBugFlag(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<BugFlag>(
          customButton: Container(
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(kBorderRadius),
                border: Border.all(
                    width: 2,
                    color: AppTheme.basic.primaryColor.withOpacity(0.7))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.sort,
                    color: AppTheme.basic.primaryColor,
                  ),
                  const SizedBox(
                    width: kSpacing,
                  ),
                  selectedValue == null
                      ? FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(hintValue),
                  )
                      : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(getBugFlagSelectedText(selectedValue as BugFlag)),
                  )
                ],
              ),
            ),
          ),
          //default and custom button's radius
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          itemPadding: const EdgeInsets.only(left: 16, right: 16),
          dropdownElevation: 2,
          dropdownWidth: 200,
          dropdownPadding: const EdgeInsets.symmetric(vertical: 6),
          // dropdownDecoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(kBorderRadius),
          //   // color: Colors.redAccent,
          // ),
          offset: const Offset(-15, -5),
          //color of button after option is selected
          focusColor: Colors.grey.withAlpha(50),
          value: selectedValue as BugFlag,
          items: createDropdownMenuItemForBugFlag(dropdownList as List<BugFlag>),
          onChanged: (selectedBugFlag) {
            onChangeDropdownItem!(selectedBugFlag as T);
          },

          //use hint with value: null
          // hint: Text(
          //   'Sort by',
          //   style: TextStyle(
          //     color: Theme.of(context).hintColor,
          //   ),
          // ),
          // center default button's items
          // alignment: Alignment.center,
          //default button icon
          // icon: Icon(Icons.sort),
          //default button's icon color
          // iconEnabledColor: AppTheme.basic.primaryColor,
        ),
      ),
    );
  }

  getBugFlagSelectedText(BugFlag taskType) {
    return taskType.name.toUpperCase();
  }

  createDropdownMenuItemForBugFlag(List<BugFlag> list) {
    return list
        .map((BugFlag val) {
        return DropdownMenuItem<BugFlag>(
          value: val,
          child: Text(getBugFlagSelectedText(val)),
        );
    })
        .toList();
  }
}
