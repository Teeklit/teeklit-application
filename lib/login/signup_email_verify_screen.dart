import 'dart:async';
import 'package:flutter/material.dart';

// 🔹 인증 확인용 Firebase
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/core/themes/app_text.dart';
import '../ui/core/themes/colors.dart';

class SignupEmailVerifyScreen extends StatefulWidget {
  final String email;

  const SignupEmailVerifyScreen({
    super.key,
    required this.email,
  });

  @override
  State<SignupEmailVerifyScreen> createState() => _SignupEmailVerifyScreenState();
}

class _SignupEmailVerifyScreenState extends State<SignupEmailVerifyScreen> {
  Timer? _timer;

  /// 🔥 5초마다 인증 상태 자동 체크
  void _startAutoCheck() {
    _timer = Timer.periodic(const Duration(seconds: 5), (_) async {
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      await user.reload();
      final refreshedUser = FirebaseAuth.instance.currentUser;

      if (refreshedUser != null && refreshedUser.emailVerified) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("이메일 인증이 완료되었습니다.")),
        );

        _timer?.cancel();

        // 🔥 인증 완료 → 홈페이지 혹은 다음 화면 이동
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // 🔥 자동 감지 시작
    _startAutoCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /// 버튼 누를 때 수동 확인
  Future<void> _checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("로그인 정보가 올바르지 않습니다.")),
      );
      return;
    }

    await user.reload();
    final refreshedUser = FirebaseAuth.instance.currentUser;

    if (refreshedUser != null && refreshedUser.emailVerified) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("이메일 인증이 완료되었습니다.")),
      );

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("아직 인증이 완료되지 않았습니다.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bg,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.chevron_left, color: AppColors.strokeGray, size: 28),
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: _checkEmailVerified,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text(
            "회원가입 완료!",
            style: AppText.Button.copyWith(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            const Text(
              "본인확인을 위해 이메일로",
              style: TextStyle(
                fontFamily: 'Paperlogy',
                fontWeight: FontWeight.w500,
                fontSize: 22,
                height: 1.6,
                color: Colors.white,
              ),
            ),

            Text.rich(
              TextSpan(
                children: [
                  const TextSpan(
                    text: "전송된 링크로 ",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(
                    text: "인증",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                  const TextSpan(
                    text: "을 진행해주세요.",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      height: 1.6,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: size.height * 0.03),

            const Text(
              "발송된 이메일",
              style: TextStyle(
                fontFamily: 'Paperlogy',
                fontWeight: FontWeight.w500,
                fontSize: 16,
                height: 1.5,
                color: AppColors.txtLight,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              widget.email,
              style: const TextStyle(
                fontFamily: 'Paperlogy',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.4,
                color: AppColors.lightGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
