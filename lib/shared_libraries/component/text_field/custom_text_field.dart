import 'package:chat_app/shared_libraries/component/text_field/bloc/custom_text_field_cubit.dart';
import 'package:chat_app/shared_libraries/component/text_field/bloc/custom_text_field_state.dart';
import 'package:chat_app/shared_libraries/utils/resources/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String? errorText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final bool required;
  final bool obscureText;
  final bool enable;
  final int? maxLines;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const CustomTextField({
    Key? key,
    this.labelText = "",
    this.hintText = "",
    this.textInputType,
    this.textInputAction,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.controller,
    this.onChanged,
    this.required = true,
    this.maxLines = 1,
    this.enable = true,
    this.validator,
    this.errorText,
    this.suffixIcon,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CustomTextFieldCubit(),
      child: BlocBuilder<CustomTextFieldCubit, CustomTextFieldState>(
          builder: (context, state) {
        final bool isSecure = state.customTextFieldState.data ?? obscureText;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            labelText != ''
                ? Row(
                    children: [
                      Text(
                        labelText,
                        style: TextStyle(
                          color: ColorName.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      if (required == true)
                        Text(
                          ' *',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(
              height: labelText != '' ? 8.h : 0,
            ),
            TextFormField(
              enabled: enable,
              controller: controller,
              maxLines: maxLines,
              textInputAction: textInputAction,
              onFieldSubmitted: onFieldSubmitted,
              keyboardType: textInputType,
              obscureText: obscureText ? isSecure : obscureText,
              onChanged: onChanged,
              style: TextStyle(
                fontSize: 14.sp,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 13.0,
                  vertical: 10.0,
                ),
                suffixIcon: (obscureText)
                    ? IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () =>
                            context.read<CustomTextFieldCubit>().isSecureText(
                                  isSecured: isSecure,
                                ),
                        icon: Icon(
                          isSecure ? Icons.visibility_off : Icons.visibility,
                          size: 24,
                        ),
                      )
                    : suffixIcon,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: ColorName.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              validator: validator,
            ),
          ],
        );
      }),
    );
  }
}
