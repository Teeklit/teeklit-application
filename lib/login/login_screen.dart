import 'package:flutter/material.dart';
import 'package:teeklit_application/login/signup_terms_screen.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';
import 'login_style.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false; // 비밀번호 보기 토글 상태

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bg,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 132),

              /// 로고
              Image.asset(
                "assets/images/teeklit_logo.png",
                width: 112,
                height: 150.5,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 80),

              /// 이메일 입력
              _inputField(
                hint: "이메일 주소",
                isPassword: false,
              ),

              const SizedBox(height: 12),

              /// 비밀번호 입력 + 👁️ 아이콘
              _inputField(
                hint: "비밀번호",
                isPassword: true,
              ),

              const SizedBox(height: 20),

              /// 아이디/비번 찾기 + 이메일 가입
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("아이디 / 비밀번호 찾기", style: LoginStyle.captionStyle),

                  const SizedBox(width: 12),
                  Text("|", style: LoginStyle.captionStyle),
                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SignupTermsScreen()),
                      );
                    },
                    child: Text(
                      "이메일 가입하기",
                      style: LoginStyle.captionStyle.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              /// 로그인 버튼
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================
  // 🔹 입력 필드
  // ============================
  Widget _inputField({
    required String hint,
    required bool isPassword,
  }) {
    return TextField(
      obscureText: isPassword && !_passwordVisible,
      style: LoginStyle.inputTextStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: LoginStyle.hintStyle,
        filled: true,
        fillColor: const Color(0xFF4A4A4A),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),

        /// 🔹 비밀번호면 suffixIcon 생성
        suffixIcon: isPassword
            ? SizedBox(
          width: 40, // 👁 아이콘 영역 고정 → 텍스트와 충돌 방지
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              _passwordVisible
                  ? "assets/images/eye_off.png"
                  : "assets/images/eye.png",
              width: 20,
              height: 20,
            ),

            /// 👁 버튼 눌렀을 때 토글
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        )
            : null,
      ),
    );
  }

  // ============================
  // 🔹 로그인 버튼
  // ============================
  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB1C39F),
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text("로그인", style: LoginStyle.buttonTextStyle),
        ),
      ),
    );
  }
}
