import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../utils/helpers/app_helpers.dart';

class TaskPlannerPopup extends StatelessWidget {
  const TaskPlannerPopup({
    Key? key,
    required this.popupTitle,
    this.onClose,
    required this.child,
    this.screenType,
  }) : super(key: key);

  final String popupTitle;
  final Function()? onClose;
  final Widget child;
  // final Function(Widget child)? getWidget;
  final Responsive? screenType;

  @override
  Widget build(BuildContext context) {
    return
     Card(
        shadowColor: iconBlack,
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //top header
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      popupTitle,
                      style: const TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w800),
                    ),
                    InkWell(
                      child: const Icon(Icons.clear),
                      onTap: onClose,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: kSpacing / 2,
              ),

              Expanded(
                  child: SingleChildScrollView(
                    controller: ScrollController(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: child,
                    ),
                  ))
            ],
          ),
        )
      );
  }
}
