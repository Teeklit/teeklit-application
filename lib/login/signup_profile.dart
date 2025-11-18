import 'package:flutter/material.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';
import 'package:teeklit_application/ui/core/themes/app_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),

              // 🔹 로고
              Column(
                children: [
                  Image.asset(
                    'assets/Images/logo.png', // 로고 파일명 (예: teeklit_logo.png)
                    width: size.width * 0.25,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Teeklit",
                    style: AppText.H1.copyWith(color: Colors.white),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.08),

              // 🔹 이메일 입력
              TextField(
                decoration: InputDecoration(
                  hintText: '이메일 주소',
                  hintStyle: AppText.Body2.copyWith(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF555555),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
                style: AppText.Body1.copyWith(color: Colors.white),
              ),

              const SizedBox(height: 16),

              // 🔹 비밀번호 입력
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호',
                  hintStyle: AppText.Body2.copyWith(color: Colors.white54),
                  filled: true,
                  fillColor: const Color(0xFF555555),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                ),
                style: AppText.Body1.copyWith(color: Colors.white),
              ),

              SizedBox(height: size.height * 0.05),

              // 🔹 로그인 버튼
              FractionallySizedBox(
                widthFactor: 1.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFB1C39F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "로그인",
                    style: AppText.Button.copyWith(
                      fontSize: size.width * 0.045,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 하단 텍스트 (회원가입 유도)
              TextButton(
                onPressed: () {
                  debugPrint("회원가입 페이지 이동");
                  // Navigator.push(context,
                  //   MaterialPageRoute(builder: (_) => const SignupTermsScreen()));
                },
                child: Text(
                  "계정이 없으신가요? 회원가입하기",
                  style: AppText.Body2.copyWith(color: Colors.white70),
                ),
              ),

              SizedBox(height: size.height * 0.05),

              // 🔹 소셜 로그인 구분선
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "SNS 계정으로 로그인",
                      style: AppText.Caption.copyWith(color: Colors.white54),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24, thickness: 1)),
                ],
              ),

              const SizedBox(height: 20),

              // 🔹 SNS 아이콘들
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _socialButton('assets/Icons/kakao.png'),
                  const SizedBox(width: 24),
                  _socialButton('assets/Icons/naver.png'),
                  const SizedBox(width: 24),
                  _socialButton('assets/Icons/google.png'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 SNS 버튼 위젯
  Widget _socialButton(String assetPath) {
    return GestureDetector(
      onTap: () => debugPrint("$assetPath 로그인 클릭"),
      child: Image.asset(assetPath, width: 48, height: 48),
    );
  }
}
