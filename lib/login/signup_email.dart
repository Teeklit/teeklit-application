import 'package:flutter/material.dart';
import 'package:teeklit/theme/app_colors.dart';
import 'package:teeklit/theme/app_text.dart';

// 회원가입 2단계 화면
import 'package:teeklit/login/signup_email_verify_screen.dart';

class SignupEmailScreen extends StatelessWidget {
  const SignupEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Image.asset(
            'assets/Images/left_line.png',
            width: 24,
            height: 24,
            color: Colors.white,          // PNG가 회색이면 앱 스타일에 맞게 흰색 오버레이
            colorBlendMode: BlendMode.srcIn,
          ),
        ),
      ),

      /// 🔹 하단 버튼
      bottomNavigationBar: SizedBox(
        height: 80,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SignupVerifyScreen(),
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
          child: Text(
            "다음",
            style: AppText.Button.copyWith(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),

      /// 🔹 본문
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// 🔹 Figma 스타일 제목 (부분 Bold)
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "가입하실 ",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "이메일",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w700, // 🔥 Bold 부분
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "을\n입력해주세요.",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// 🔹 입력창
            TextField(
              decoration: InputDecoration(
                hintText: '이메일 주소 입력',
                hintStyle: TextStyle(
                  fontFamily: 'Paperlogy',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
                filled: true,
                fillColor: const Color(0xFF555555),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              style: const TextStyle(
                fontFamily: 'Paperlogy',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
