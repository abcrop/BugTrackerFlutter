import 'package:daily_task/app/features/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constants/app_constants.dart';
import '../utils/helpers/app_helpers.dart';
//
class TextAutoCompleteDropDown<T> extends StatelessWidget {
   TextAutoCompleteDropDown(
      {Key? key,
        this.selectedValue,
      required this.hintText,
      this.showAllItemsAtFirst,
      this.dropdownItems,
      this.onChangeDropdownItem,
      this.onChangeCategorySearchTerm,
      this.onChangeTaskRepeatHour,
      this.isForMultipleDropdown,
        this.isEnabled
      })
      : super(key: key);

  final T? selectedValue;
  final bool? showAllItemsAtFirst;
  final String hintText;
  final List<T>? dropdownItems;
  final Function(T? item)? onChangeDropdownItem;
  final Function(String term)? onChangeCategorySearchTerm;
  final Function(int hours)? onChangeTaskRepeatHour;
  bool? isForMultipleDropdown = false;
  bool? isEnabled = true;

  @override
  Widget build(BuildContext context) {
    return _chooseDropdown(context);
  }

   Widget _chooseDropdown(BuildContext context) {
     if (selectedValue is User) {
       return _dropdownForUser(context);
     }
     return const SizedBox();
   }

  Widget _dropdownForUser(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Autocomplete<User>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          if (!showAllItemsAtFirst!) {
            if (textEditingValue.text == '') {
              return const Iterable<User>.empty();
            }
          }
          return createDropdownMenuItemForUser(
              dropdownItems as List<User>, textEditingValue);
        },
        initialValue: TextEditingValue(
            text: getUserSelectedText(selectedValue as User)),
        displayStringForOption: (User option) => option.fullName!.toUpperCase(),
        onSelected: (User selection) {
          onChangeDropdownItem!(selection as T);
        },
        optionsViewBuilder: (context, Function(User) onSelected, options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              shape: const RoundedRectangleBorder(
                borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(4.0)),
              ),
              child: SizedBox(
                height: 200,
                width: constraints.biggest.width,
                child: ListView.separated(
                  padding: const EdgeInsets.all(2),
                  itemBuilder: (context, index) {
                    final option = options.elementAt(index);
                    final optionName = option.fullName!.toUpperCase();

                    return ListTile(
                      title: Text(optionName),
                      onTap: () => {onSelected(option)},
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: options.length,
                ),
              ),
            ),
          );
        },
        fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
          if(isForMultipleDropdown!)
            controller.text = getUserSelectedText(selectedValue as User);

          return TextFormField(
            controller: controller,
            focusNode: focusNode,
            onEditingComplete: onEditingComplete,
            decoration: taskPlannerInputDecoration(hintText: hintText),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return "Please choose a option.";
              } else {
                return null;
              }
            },
          );
        },
      ),
    );
  }

  getUserSelectedText(User user) {
    return user.fullName!.toUpperCase();
  }

  createDropdownMenuItemForUser(
      List<User> list, TextEditingValue textEditingValue) {
    return list!.where((User option) {
      return option.fullName!
          .trim()
          .toLowerCase()
          .contains(textEditingValue.text.toLowerCase());
    });
  }
}
