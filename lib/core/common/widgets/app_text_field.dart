import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.suffixIcon,
    this.keyBoardType,
    this.borderColor,
    this.obscureText = false,
    this.minLines = 1,
    this.labelTextStyle,
    this.focusNode,
    this.prefixIcon,
    this.onFieldSubmitted,
    this.readOnly,
    this.onTap,
    this.fillColor,
    this.scrollController,
    this.hintText,
    this.hintTextStyle,
  });

  final TextEditingController? controller;
  final ScrollController? scrollController;
  final bool obscureText;
  final Function(String latestString)? onChanged;
  final String? labelText;
  final String? errorText;
  final String? hintText;
  final Widget? suffixIcon;
  final TextInputType? keyBoardType;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final Color? borderColor;
  final int minLines;
  final FocusNode? focusNode;
  final Function(dynamic value)? onFieldSubmitted;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    final maxLines = minLines;
    return TextFormField(
      scrollController: scrollController,
      onTap: onTap,
      controller: controller,
      keyboardType: keyBoardType,
      obscureText: obscureText,
      onChanged: onChanged,
      readOnly: readOnly ?? false,
      // style: context.labelLarge,
      minLines: minLines,
      maxLines: maxLines,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintTextStyle,
        fillColor: fillColor,
        alignLabelWithHint: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide.none,
        ),
        labelText: labelText,
        labelStyle: labelTextStyle ??
            TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins',
              color: Colors.black,
            ),
        errorText: errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: borderColor ?? Colors.blue,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: borderColor ?? Colors.white,
            width: 0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        // errorStyle: context.labelMedium!.copyWith(
        //   color: context.error,
        //   letterSpacing: 0.1,
        // ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
      ),
    );
  }
}