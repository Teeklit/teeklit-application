import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String hintText; //placeholder
  final String errorText; //하단 에러 문구 표시
  final bool obscureText; //비밀번호 점으로 표시
  final Widget? suffixIcon; //suffix 아이콘 표시
  //final String? Function(String) validator; //전달받을 입력값 검증 함수

  const CustomInputField({
    super.key,
    required this.hintText,
    required this.errorText,
    //required this.validator,
    this.obscureText = false,
    this.suffixIcon,

  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              //placeholder
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xff8C8C8C)),

            ),
          ),
        )
      ],
    );
  }
}