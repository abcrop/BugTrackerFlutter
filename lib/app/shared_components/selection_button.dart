import 'package:daily_task/app/config/themes/app_theme.dart';
import 'package:daily_task/app/config/themes/app_theme.dart';
import 'package:daily_task/app/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/helpers/app_helpers.dart';
import '../utils/helpers/side_bar_navigation.dart';

class SelectionButtonData {
  final IconData activeIcon;
  final IconData icon;
  final String label;
  final int? totalNotif;

  SelectionButtonData({
    required this.activeIcon,
    required this.icon,
    required this.label,
    this.totalNotif,
  });
}

class SelectionButton extends StatelessWidget {
  SelectionButton({
    this.initialSelected = 0,
    required this.data,
    // required this.onSelected,
    this.selectedButtonIndex,
    Key? key,
  }) : super(key: key);

  final _getxPref = GetStorage(GetxStorageConstants.getXPref);
  final int initialSelected;
  final List<SelectionButtonData> data;
  // final Function(int index, SelectionButtonData value) onSelected;
  late int? selectedButtonIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.asMap().entries.map((e) {
        final index = e.key;
        final data = e.value;

        logger.d("print index ${index} value $data");

        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _Button(
              selected: selectedButtonIndex == null ? index == 0 ? true : false :  selectedButtonIndex == index,
              onPressed: () {
                selectiveScreenNavigation(index);
                _getxPref.write(GetxStorageConstants.selectedScreenIndex, index);
              },
              data: data,
            )
        );
      }).toList(),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.selected,
    required this.data,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final bool selected;
  final SelectionButtonData data;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (!selected) ? null : AppTheme.basic.primaryColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(kBorderRadius),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildIcon(),
              const SizedBox(width: kSpacing / 2),
              Expanded(child: _buildLabel()),
              if (data.totalNotif != null)
                Padding(
                  padding: const EdgeInsets.only(left: kSpacing / 2),
                  child: _buildNotif(),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageTitle() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(),
          const SizedBox(width: kSpacing / 2),
          _buildLabel(),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return Icon(
      (!selected) ? data.icon : data.activeIcon,
      size: 20,
      color: (!selected)
          ? kFontColorPallets[1]
          : AppTheme.basic.primaryColor.withOpacity(0.7),
    );
  }

  Widget _buildLabel() {
    return Text(
      data.label,
      style: TextStyle(
        color: (!selected)
            ? kFontColorPallets[1]
            : AppTheme.basic.primaryColor.withOpacity(0.7),
        fontWeight: FontWeight.bold,
        letterSpacing: .8,
        fontSize: 14,
      ),
    );
  }

  Widget _buildNotif() {
    return (data.totalNotif == null || data.totalNotif! <= 0)
        ? Container()
        : Container(
      width: 30,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        (data.totalNotif! >= 100) ? "99+" : "${data.totalNotif}",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
