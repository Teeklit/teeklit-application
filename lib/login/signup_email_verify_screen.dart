import 'package:flutter/material.dart';

// 회원가입3. 비밀번호 입력 파트.
import 'package:teeklit/login/signup_password_screen.dart';


class SignupVerifyScreen extends StatelessWidget {
  const SignupVerifyScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1C), // stroke_gray 근접값

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

      /// 🔹 하단 버튼 (피그마 전체폭, 배경 밝은 회색)
      bottomNavigationBar: SizedBox(
        height: 80,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignupPasswordScreen(),
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

            /// 🔹 상단 제목 (부분 Bold + 줄바꿈)
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "본인확인을 위해 이메일로\n",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "전송된 링크로 ",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "인증",
                    style: TextStyle(
                      fontFamily: 'Paperlogy',
                      fontSize: 22,
                      fontWeight: FontWeight.w700, // 🔥 여기만 Bold
                      height: 1.7,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "을 진행해주세요.",
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

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
