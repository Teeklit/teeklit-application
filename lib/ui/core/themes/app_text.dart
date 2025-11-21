import 'package:flutter/material.dart';

class AppText {
  static const String fontFamily = 'Paperlogy';

  static const TextStyle H1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 28,
    height: 1.3,
    color: Colors.white,
  );

  static const TextStyle H2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.3,
    color: Colors.white,
  );

  static const TextStyle Body1 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.45,
    color: Colors.white70,
  );

  static const TextStyle Body2 = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
    fontSize: 14,
    height: 1.5,
    color: Colors.white60,
  );

  static const TextStyle Caption = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.4,
    color: Colors.white54,
  );

  static const TextStyle Button = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.black,
  );
}
