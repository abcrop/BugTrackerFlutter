import 'package:flutter/material.dart';

import '../utils/helpers/app_helpers.dart';

class TaskPlannerTimeField extends StatelessWidget {
   TaskPlannerTimeField({
    Key? key,
    this.controller,
    this.onChangeTime,
    this.currentTime,
    this.isEnabled,
  }) : super(key: key);

  final TimeOfDay? currentTime;
  final TextEditingController? controller;
  final Function(TimeOfDay selectedTime)? onChangeTime;
  bool? isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: (TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        decoration: taskPlannerInputDecoration(
            prefixIcon: const Icon(Icons.timer_sharp), hintText: "Choose Time"),
        readOnly: true,
        enabled: isEnabled,
        onTap: () async {
          final TimeOfDay? timeOfDay = await showTimePicker(
            context: context,
            initialTime: currentTime!,
            initialEntryMode: TimePickerEntryMode.dial,
          );

          if (timeOfDay != null) {
            onChangeTime!(timeOfDay);
            print(timeOfDay);
          }
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Please choose a time.";
          } else {
            return null;
          }
        },
      )),
    );
  }
}
