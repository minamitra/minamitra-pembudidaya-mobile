import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:minamitra_pembudidaya_mobile/core/components/app_text.dart';
import 'package:minamitra_pembudidaya_mobile/core/themes/app_color.dart';
import 'package:flutter/material.dart';

final _buttonStyle = ButtonStyleData(
  height: 50,
  width: 160,
  padding: const EdgeInsets.only(left: 16, right: 16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color: AppColor.white,
  ),
);

final _buttonFormStyle = ButtonStyleData(
  height: 56,
  width: 160,
  padding: const EdgeInsets.only(left: 16, right: 16),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    color: AppColor.white,
    border: Border.all(
      color: AppColor.primary,
      width: 1,
    ),
  ),
);

class AppDropdown extends StatefulWidget {
  final String title;
  final List<DropdownMenuItem<String>> items;
  final String? value;
  final Function(String) onChanged;
  final bool isForm;
  final String? Function(String?)? validator;

  const AppDropdown(
    this.title,
    this.items,
    this.value,
    this.onChanged, {
    this.isForm = false,
    this.validator,
    super.key,
  });

  @override
  State<AppDropdown> createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: AppTextStyle.whiteSmallMediumText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items,
        value: widget.value,
        onChanged: (value) {
          setState(() {
            widget.onChanged(value!);
          });
        },
        buttonStyleData: widget.isForm ? _buttonFormStyle : _buttonStyle,
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.arrow_forward_ios_outlined,
          ),
          iconSize: 14,
          iconEnabledColor: AppColor.white,
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: AppColor.white,
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
        decoration: const InputDecoration.collapsed(hintText: ''),
        validator: widget.validator,
      ),
    );
  }
}
