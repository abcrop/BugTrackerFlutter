import 'package:flutter/material.dart';

import '../utils/helpers/app_helpers.dart';

class TaskPlannerDropdown extends StatelessWidget {
  const TaskPlannerDropdown(
      {Key? key,
      required this.selectedValue,
      required this.items,
      required this.onChangeDropdownItem})
      : super(key: key);

  final String selectedValue;
  final List<String> items;
  final Function(String? value) onChangeDropdownItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      focusColor: Colors.white,
      iconEnabledColor: Colors.grey,
      value: selectedValue,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
          ),
        );
      }).toList(),
      onChanged: onChangeDropdownItem,
      decoration: taskPlannerInputDecoration(hintText: ""),
    );
  }

  //implementation:
  // DropdownButtonFormField(
  // focusColor: Colors.white,
  // iconEnabledColor: Colors.grey,
  // value: controller.assignedTo.value,
  // items: controller.assignsToLists
  //     .map<DropdownMenuItem<String>>((String value) {
  // return DropdownMenuItem<String>(
  // value: value,
  // child: Text(
  // value,
  // ),
  // );
  // }).toList(),
  // onChanged: (String? newValue) {
  // controller.updateAssignedTo(newValue!);
  // },
  // decoration: taskPlannerInputDecoration(hintText: ""),
  // ),
}
