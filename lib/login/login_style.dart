import 'dart:ui';

import 'package:flutter/material.dart';

class LoginStyle{
  // 공통 텍스트 스타일들
  static TextStyle get hintStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 14,
    color: Color(0xFFBBBBBB),
  );

  static TextStyle get captionStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 12,
    color: Colors.white,
  );

  static TextStyle get inputTextStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 14,
    color: Colors.white,
  );

  static TextStyle get buttonTextStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

}