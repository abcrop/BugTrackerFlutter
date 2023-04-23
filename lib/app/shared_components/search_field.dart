import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../utils/helpers/app_helpers.dart';

class TaskPlannerSearchField extends StatelessWidget {
  const TaskPlannerSearchField({
    this.onSearch,
    this.hintText,
    Key? key, this.controller,
    this.showSearchSuffixIcon
  }) : super(key: key);

  final TextEditingController? controller;
  final Function()? onSearch;
  final String? hintText;
  final RxBool? showSearchSuffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        keyboardType: TextInputType.multiline,
        maxLines: 1,
        minLines: 1,
        onChanged: (term) {
          if(term.isNotEmpty) {
            onSearch!();
          } else {
            onSearch!();
          }
        },
        textAlign: TextAlign.start,
        decoration: taskPlannerInputDecoration(
            hintText: "Search",
            prefixIcon: const Icon(Icons.search),
            suffixIcon: const Icon(Icons.forward),
            showSuffixIcon: false,
            onSearch: onSearch),
           onEditingComplete: () {
          FocusScope.of(context).unfocus();
          if (onSearch != null) onSearch!();
        },
        textInputAction: TextInputAction.search,
        style: TextStyle(color: kFontColorPallets[1]),

      );
  }
}
