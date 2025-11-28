import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:go_router/go_router.dart';
import '../login/app_router.dart';
import '../login/signup_info.dart';

import '../ui/core/themes/colors.dart';
import 'login_style.dart';
import '../main.dart';
import 'signup_terms_screen.dart'; // HomePage 가져오기 위해

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

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

              Image.asset(
                "assets/images/teeklit_logo.png",
                width: 112,
                height: 150.5,
              ),

              const SizedBox(height: 80),

              _inputField(
                hint: "이메일 주소",
                isPassword: false,
                controller: _emailController,
              ),

              const SizedBox(height: 12),

              _inputField(
                hint: "비밀번호",
                isPassword: true,
                controller: _pwController,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push('/find-account');  // 비밀번호 찾기
                    },
                    child: Text(
                      "아이디 / 비밀번호 찾기",
                      style: LoginStyle.captionStyle,
                    ),
                  ),

                  const SizedBox(width: 12),
                  Text("|", style: LoginStyle.captionStyle),
                  const SizedBox(width: 12),

                  GestureDetector(
                    onTap: () {
                      context.push('/signup-terms');   // ⬅ 이메일 가입하기 (회원가입 시작)
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

              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required bool isPassword,
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
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
        suffixIcon: isPassword
            ? SizedBox(
          width: 40,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Image.asset(
              _passwordVisible
                  ? "assets/images/eye_off.png"
                  : "assets/images/eye.png",
              width: 20,
              height: 20,
            ),
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

  Widget _loginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _onLoginPressed,
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

  // ============================================
  // 🔥 여기만 수정됨: 이메일 인증 체크 포함 로그인 로직
  // ============================================
  Future<void> _onLoginPressed() async {
    final email = _emailController.text.trim();
    final password = _pwController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("이메일과 비밀번호를 입력하세요")),
      );
      return;
    }

    try {
      // 1) 로그인 요청
      final cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // 2) 상태 갱신
      await cred.user?.reload();
      final user = FirebaseAuth.instance.currentUser;

      // 3) 이메일 인증 여부 확인
      if (user != null && !user.emailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("이메일 인증이 완료되지 않았습니다.")),
        );

        await FirebaseAuth.instance.signOut();
        return;
      }

      // 4) 인증 완료 → 홈 이동
      context.go('/community');
    } on FirebaseAuthException catch (e) {
      String message = "로그인 실패";

      if (e.code == 'user-not-found') message = "존재하지 않는 계정입니다";
      if (e.code == 'wrong-password') message = "비밀번호가 틀렸습니다";
      if (e.code == 'invalid-email') message = "이메일 형식이 잘못되었습니다";
      if (e.code == 'too-many-requests') message = "잠시 후 다시 시도해주세요";

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }
}

