import 'package:daily_task/app/constants/app_constants.dart';
import 'package:daily_task/app/shared_components/responsive_builder.dart';
import 'package:daily_task/app/shared_components/side_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bottom_navbar.dart';

class TaskPlannerScaffold extends StatelessWidget {
  const TaskPlannerScaffold({
    Key? key,
    this.mobileWidget,
    this.tabletWidget,
    this.desktopWidget,
  }) : super(key: key);

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  )? mobileWidget;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  )? tabletWidget;

  final Widget Function(
    BuildContext context,
    BoxConstraints constraints,
  )? desktopWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      drawer: ResponsiveBuilder.isDesktop(context)
          ? null
          : Drawer(
              child: SafeArea(
                child: SingleChildScrollView(child: SideBar()),
              ),
            ),
      bottomNavigationBar: (ResponsiveBuilder.isDesktop(context) || kIsWeb)
          ? null
          : const BottomNavbar(),
      body: SafeArea(
        child: ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return mobileWidget!(context, constraints);
          },
          tabletBuilder: (context, constraints) {
            return tabletWidget!(context, constraints);
          },
          desktopBuilder: (context, constraints) {
            return desktopWidget!(context, constraints);
          },
        ),
      ),
    );
  }
}
