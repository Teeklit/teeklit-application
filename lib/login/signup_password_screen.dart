import 'package:flutter/material.dart';
import 'package:teeklit_application/login/signup_nickname.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';

class SignupPasswordScreen extends StatelessWidget {
  const SignupPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 28,
            color: AppColors.strokeGray, // 앱 컬러
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 80,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignupNicknameScreen(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8C8C8C),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: const Text(
            "다음",
            style: TextStyle(
              fontFamily: 'Paperlogy',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 상단 안내문
            const Text(
              "이메일 인증을 완료했어요.\n사용하실 비밀번호를 입력해주세요.",
              style: TextStyle(
                fontFamily: 'Paperlogy',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 28),

            // 1) 비밀번호 입력
            _passwordField("비밀번호를 입력해주세요."),

            const SizedBox(height: 8),

            // 안내 문구
            const Text(
              "비밀번호 재입력.",
              style: TextStyle(
                fontFamily: 'Paperlogy',
                fontSize: 14,
                color: Colors.white54,
                height: 1.4,
              ),
            ),

            const SizedBox(height: 14),

            // 2) 비밀번호 재입력
            _passwordField("비밀번호를 다시 한번 입력해주세요."),
          ],
        ),
      ),
    );
  }

  /// =============================
  /// 공통 비밀번호 입력 박스 위젯
  /// =============================
  Widget _passwordField(String hint) {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Paperlogy',
          color: Colors.white54,
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: const Color(0xFF555555),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
      style: const TextStyle(
        fontFamily: 'Paperlogy',
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
