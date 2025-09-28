import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final Color? textColor;
  final String hintText;
  final Color? hintTextColor;
  final double hintTextSize;
  final bool isPassword;
  final bool autoFocus;
  final TextInputType inputType;
  final Color cursorColor;
  final double borderRadius;
  final double borderWidth;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color focusedErrorBorderColor;
  final Color errorBorderColor;
  final double errorTextSize;
  final Color errorTextColor;
  final double focusedBorderWidth;
  final Icon icon;
  final Color? iconColor;
  final FormFieldValidator<String>? validate;
  final FormFieldValidator<String>? savedValue;
  final FormFieldValidator<String>? changedValue;
  final bool? isFieldEnabled;
  final Widget? trailingWidget;

  const CustomFormTextField({
    super.key,
    required this.hintText,
    this.textEditingController,
    this.textColor,
    this.hintTextColor = Colors.grey,
    this.hintTextSize = 20,
    this.inputType = TextInputType.number,
    this.isPassword = false,
    this.autoFocus = false,
    this.cursorColor = Colors.white,
    this.borderRadius = 10,
    this.borderWidth = 1,
    this.enabledBorderColor = Colors.grey,
    this.focusedBorderColor = Colors.green,
    this.focusedErrorBorderColor = Colors.redAccent,
    this.errorBorderColor = Colors.redAccent,
    this.errorTextSize = 15,
    this.errorTextColor = Colors.redAccent,
    this.focusedBorderWidth = 2,
    required this.icon,
    this.iconColor,
    this.validate,
    this.savedValue,
    this.changedValue,
    this.isFieldEnabled,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      enabled: isFieldEnabled,
      obscureText: isPassword,
      onChanged: changedValue,
      autofocus: autoFocus,
      validator: validate,
      onSaved: savedValue,
      style: TextStyle(color: textColor),
      keyboardType: inputType,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        suffixIcon: trailingWidget,
        prefixIcon: icon,
        prefixIconColor: iconColor,
        labelText: hintText,
        labelStyle: TextStyle(color: hintTextColor, fontSize: hintTextSize),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: focusedBorderWidth,
            color: focusedBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: borderWidth, color: enabledBorderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: borderWidth, color: errorBorderColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: focusedBorderWidth,
            color: focusedErrorBorderColor,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        errorStyle: TextStyle(fontSize: errorTextSize, color: errorTextColor),
      ),
    );
  }
}
