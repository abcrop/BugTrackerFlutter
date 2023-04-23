import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({
    this.onPressed,
    Key? key,
    required this.child,
  }) : super(key: key);

  final Function? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: iconBlack,
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 2.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: child,
        ),
      ),
    );
  }
}
