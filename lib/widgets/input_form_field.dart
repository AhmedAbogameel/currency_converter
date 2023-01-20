import 'package:flutter/material.dart';

import '../colors.dart';

class InputFormField extends StatefulWidget {
  const InputFormField({
    Key? key,
    this.onChanged,
    this.hint,
    this.readOnly = false,
    this.textInputType,
    this.controller,
  }) : super(key: key);

  final Function(String)? onChanged;
  final String? hint;
  final bool readOnly;
  final TextInputType? textInputType;
  final TextEditingController? controller;

  @override
  State<InputFormField> createState() => _InputFormFieldState();
}

class _InputFormFieldState extends State<InputFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      readOnly: widget.readOnly,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hint,
        contentPadding: EdgeInsets.only(left: 16, right: 8),
        border: OutlineInputBorder(borderRadius: borderRadius),
        enabledBorder: getBorder(kGreyColor),
        focusedBorder: getBorder(widget.readOnly ? kGreyColor : kPrimaryColor),
        errorBorder: getBorder(Colors.red),
        focusedErrorBorder: getBorder(kPrimaryColor),
        disabledBorder: getBorder(Colors.transparent),
      ),
    );
  }

  final BorderRadius borderRadius = BorderRadius.circular(8);

  InputBorder getBorder(Color color) => OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: color),
      );
}
