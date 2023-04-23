import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../constants/app_constants.dart';
import '../utils/helpers/app_helpers.dart';

class TaskPlannerDateField extends StatelessWidget {
   TaskPlannerDateField({
    Key? key,
    this.controller,
    this.updateDate,
    this.currentDate,
    this.startDateCompare,
    this.isEnabled, this.firstDateInCalender, this.lastDateInCalender,
  }) : super(key: key);

  final DateTime? currentDate;
  final DateTime? startDateCompare;
  bool? isEnabled = true;
  final TextEditingController? controller;
  final Function(DateTime selectedDate)? updateDate;
  final DateTime? firstDateInCalender;
  final DateTime? lastDateInCalender;

  @override
  Widget build(BuildContext context) {
    String dateOnlyPattern = r'\d{4}-\d{2}-\d{2}';

    return SizedBox(
      width: 200,
      child: (TextFormField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.datetime,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(dateOnlyPattern))
        ],
        decoration: taskPlannerInputDecoration(
            prefixIcon: const Icon(Icons.date_range_outlined),
            hintText: "Choose Date"),
        readOnly: true,
        onTap: () async {
          logger.d("print isEnabled $isEnabled firstdatecalender $firstDateInCalender currentdate $currentDate");

          if(isEnabled!) {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: currentDate!,
                firstDate: firstDateInCalender == null ? DateTime.now().subtract(const Duration(days: firstOrlastDateOfCalender)) : firstDateInCalender!,
                lastDate:  lastDateInCalender == null ? DateTime.now().add(const Duration(days: firstOrlastDateOfCalender)) : lastDateInCalender! ) ;
            if (pickedDate != null) {
              updateDate!(pickedDate);
              print(pickedDate);
              String formattedDate = DateFormat('yyyy/MM/dd').format(pickedDate);
              print(formattedDate);
            }
          }
        },
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Please choose a date.";
          }
        },
      )
      ),
    );
  }
}
