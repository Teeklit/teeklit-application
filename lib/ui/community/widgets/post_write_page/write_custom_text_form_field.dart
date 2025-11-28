import 'package:flutter/material.dart';
import 'package:teeklit/ui/core/themes/colors.dart';

/// 커스텀 입력 필드를 구분하기 위해 사용
enum InputFieldType { title, content }

class WriteCustomTextFormField extends StatelessWidget {
  final Text hintText;
  final int? maxLines;
  final InputFieldType fieldType;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  /// custom text form field
  /// enum InputFieldType 사용해서 구분
  const WriteCustomTextFormField({
    super.key,
    required this.hintText,
    this.maxLines = 1,
    required this.fieldType,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final bool isTitle = fieldType == InputFieldType.title;

    return TextFormField(
      controller: controller,
      style: TextStyle(color: AppColors.txtLight),
      cursorColor: AppColors.txtLight,
      maxLines: maxLines,
      decoration: InputDecoration(
        hint: hintText,
        enabledBorder: isTitle
            ? UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.strokeGray),
        )
            : InputBorder.none,
        focusedBorder: isTitle
            ? UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.strokeGray),
        )
            : InputBorder.none,
        border: !isTitle ? InputBorder.none : null,
      ),
    );
  }
}