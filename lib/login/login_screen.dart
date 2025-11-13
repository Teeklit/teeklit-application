import 'package:flutter/material.dart';
import 'package:teeklit/login/signup_terms_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // 공통 텍스트 스타일들
  TextStyle get _hintStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 14,
    color: Color(0xFFBBBBBB),
  );

  TextStyle get _captionStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 12,
    color: Colors.white,
  );

  TextStyle get _inputTextStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 14,
    color: Colors.white,
  );

  TextStyle get _buttonTextStyle => const TextStyle(
    fontFamily: 'Paperlogy',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF2C2C2E), // 배경이 문제네

      body: SafeArea(
        child: Stack(
          children: [
            /// 🔹 오른쪽 상단 X 아이콘
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Image.asset(
                  "assets/Images/close.png",
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            /// 🔹 본문
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 132),

                  /// 로고
                  Image.asset(
                    "assets/Images/teeklit_logo.png",
                    width: 112,
                    height: 150.5,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 80),

                  /// 이메일 입력
                  _inputField(
                    hint: "이메일 주소",
                    isPassword: false,
                    hintStyle: _hintStyle,
                    textStyle: _inputTextStyle,
                  ),

                  const SizedBox(height: 12),

                  /// 비밀번호 입력
                  _inputField(
                    hint: "비밀번호",
                    isPassword: true,
                    hintStyle: _hintStyle,
                    textStyle: _inputTextStyle,
                  ),

                  const SizedBox(height: 20),

                  /// 아이디/비번 찾기 + 이메일 가입
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("아이디 / 비밀번호 찾기", style: _captionStyle),
                      const SizedBox(width: 12),
                      Text("|", style: _captionStyle),
                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => SignupTermsScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "이메일 가입하기",
                          style: _captionStyle.copyWith(
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
          ],
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
    required TextStyle hintStyle,
    required TextStyle textStyle,
  }) {
    return TextField(
      obscureText: isPassword,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: hintStyle,
        filled: true,
        fillColor: const Color(0xFF4A4A4A),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        suffixIcon: isPassword
            ? Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Image.asset(
            "assets/Images/Calendar.png",
            width: 24,
            height: 24,
            fit: BoxFit.contain,
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
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(
            "로그인",
            style: _buttonTextStyle,
          ),
        ),
      ),
    );
  }
}
