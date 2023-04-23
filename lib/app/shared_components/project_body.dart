import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ProjectBody extends StatelessWidget {
  const ProjectBody({
    this.onPressed,
    Key? key,
    required this.child,
  }) : super(key: key);

  final Function? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      child: Card(
          shadowColor: iconBlack,
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: child,
          )),
    );
  }
}
