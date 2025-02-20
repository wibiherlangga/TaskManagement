import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_management/config/colors/app_colors.dart';
import 'package:task_management/config/theme/app_theme_text_style.dart';

class AppTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final BuildContext context;
  final String title;

  final bool readOnly;
  final String hint;
  final bool require;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool obscureText;
  final Color? iconColor;
  final String validationTxt;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? suffixIconTapped;
  final Function()? prefixIconTapped;
  final TextInputType? keyboardType;
  final bool isEnable;
  final bool isAterisk;
  final bool isCustomSuffix;
  final bool isCustomPrefix;
  final Widget? suffixCustom;
  final Widget? prefixCustom;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextfield({
    super.key,
    this.controller,
    required this.context,
    required this.title,
    this.readOnly = false,
    this.hint = '',
    this.require = false,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.iconColor,
    this.validationTxt = 'Cannot be blank',
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onTap,
    this.suffixIconTapped,
    this.prefixIconTapped,
    this.keyboardType = TextInputType.text,
    this.isEnable = true,
    this.isAterisk = false,
    this.isCustomSuffix = false,
    this.isCustomPrefix = false,
    this.suffixCustom,
    this.prefixCustom,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _setTitle(isAterisk: isAterisk, title: title, isEnable: isEnable),
          TextFormField(
            enabled: isEnable,
            controller: controller,
            cursorColor: AppColors.primary,
            obscureText: obscureText,
            autocorrect: true,
            readOnly: readOnly,
            validator: validator,
            onChanged: onChanged,
            onTap: onTap,
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFE8E8E8)),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.primary,
                ),
              ),
              fillColor: Colors.white,
              prefixIcon: _setPrefixIcon(
                isCustomPrefix: isCustomPrefix,
                prefixIcon: prefixIcon,
                iconColor: iconColor ?? AppColors.primary,
                prefixIconTapped: prefixIconTapped,
                prefixCustom: prefixCustom,
              ),
              suffixIcon: _setSuffixIcon(
                isCustomSuffix: isCustomSuffix,
                suffixIcon: suffixIcon,
                iconColor: iconColor ?? AppColors.primary,
                suffixIconTapped: suffixIconTapped,
                suffixCustom: suffixCustom,
              ),
              hintText: hint,
              hintStyle: const TextStyle(
                color: Color(0xFFE8E8E8),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              errorStyle: const TextStyle(
                color: AppColors.danger,
                fontSize: 10,
                height: 1,
              ),
              contentPadding: const EdgeInsets.only(bottom: 0.0, top: 10.0),
            ),
            keyboardType: keyboardType,
            maxLines: 1,
            style: TextStyle(
              fontSize: 16,
              color: isEnable ? AppColors.darkBackground : AppColors.grayLabel,
            ),
            textInputAction: TextInputAction.next,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }

  Widget _setTitle({
    required bool isAterisk,
    required String title,
    required bool isEnable,
  }) {
    if (isAterisk) {
      return RichText(
        text: TextSpan(
          text: title,
          style: AppThemeTextStyle.museoSans300.copyWith(
            color: isEnable ? AppColors.primary : AppColors.grayLabel,
          ),
          children: const [
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: AppColors.danger,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        title,
        style: AppThemeTextStyle.museoSans300.copyWith(
          color: isEnable ? AppColors.primary : AppColors.grayLabel,
        ),
      );
    }
  }

  Widget? _setSuffixIcon({
    required bool isCustomSuffix,
    IconData? suffixIcon,
    required Color iconColor,
    required Function()? suffixIconTapped,
    required Widget? suffixCustom,
  }) {
    if (isCustomSuffix) {
      return Container(
        margin: const EdgeInsets.only(
          left: 8.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: suffixCustom,
      );
    }

    if (suffixIcon != null) {
      return GestureDetector(
        onTap: suffixIconTapped,
        child: Container(
          margin: const EdgeInsets.only(
            left: 8.0,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Icon(
            suffixIcon,
            size: 24,
          ),
        ),
      );
    }

    return null;
  }

  Widget? _setPrefixIcon({
    required bool isCustomPrefix,
    IconData? prefixIcon,
    required Color iconColor,
    required Function()? prefixIconTapped,
    required Widget? prefixCustom,
  }) {
    if (isCustomPrefix) {
      return Container(
        margin: const EdgeInsets.only(
          right: 8.0,
          top: 10.0,
          bottom: 10.0,
        ),
        child: prefixCustom,
      );
    }

    if (prefixIcon != null) {
      return GestureDetector(
        onTap: prefixIconTapped,
        child: Container(
          margin: const EdgeInsets.only(
            right: 8.0,
            top: 10.0,
            bottom: 10.0,
          ),
          child: Icon(
            prefixIcon,
            size: 24,
          ),
        ),
      );
    }

    return null;
  }
}
