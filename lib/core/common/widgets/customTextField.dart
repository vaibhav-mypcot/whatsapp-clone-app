import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whatsapp_clone_app/core/theme/app_colors.dart';

class CustomTextfieldWidget extends StatelessWidget {
  const CustomTextfieldWidget({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.onSaved,
    this.labelText,
    this.hintText,
    this.style,
    this.labelStyle,
    this.hintStyle,
    this.errorStyle,
    this.errorMaxLines,
    this.isPassword = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.textInputType = TextInputType.text,
    this.prefixIconConstraints,
    this.contentPadding,
    this.radius = 12.0,
    this.maxLines,
    this.initialValue,
    this.textAlignVertical,
    this.inputFormatters,
    this.enabled,
    this.shouldChangeColor,
  });

  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final String? labelText;
  final String? hintText;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? errorStyle;
  final int? errorMaxLines;
  final bool isPassword;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final BoxConstraints? prefixIconConstraints;
  final EdgeInsets? contentPadding;
  final double radius;
  final int? maxLines;
  final String? initialValue;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool? shouldChangeColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 42.h,
      child: TextFormField(
        cursorColor: kColorPrimary,
        inputFormatters: inputFormatters,
        enabled: enabled,
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        onEditingComplete: onEditingComplete,
        validator: validator,
        onFieldSubmitted: onFieldSubmitted,
        style: style,
        obscureText: isPassword,
        cursorWidth: 1.6.w,
        scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 1000),
        // expands: true,
        keyboardType: textInputType,
        maxLines: maxLines,
        textAlignVertical: textAlignVertical,
        autocorrect: false,
        enableSuggestions: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: labelStyle,
          isDense: true,
          errorStyle: errorStyle,
          errorMaxLines: errorMaxLines,
          hintText: hintText,
          prefixIconConstraints: prefixIconConstraints,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          // suffixIconConstraints:
          //     BoxConstraints(maxHeight: 20.w, maxWidth: 30.w),
          contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 4.h),
          hintStyle: hintStyle,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kColorPrimary, width: 0.7),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kColorPrimary, width: 1.4),
          ),
          // border: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(radius.r)),
          //     borderSide: const BorderSide(color: kColorPrimary, width: 1.0))7

          // disabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(radius.r)),
          //     borderSide: const BorderSide(color: kColorPrimary, width: 1.0)),
          // focusedBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(radius.r)),
          //   borderSide: const BorderSide(color: kColorPrimary, width: 1.0),
          // ),
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(radius.r)),
          //   borderSide: const BorderSide(color: kColorPrimary, width: 1.0),
          // ),
          // focusedErrorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(radius)),
          //   borderSide: const BorderSide(color: kColorPrimary, width: 1.0),
          // ),
        ),
      ),
    );
  }
}
