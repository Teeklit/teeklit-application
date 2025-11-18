import 'package:flutter/material.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';
import 'package:teeklit_application/ui/core/themes/app_text.dart';
import 'signup_profile_screen.dart';

class SignupNicknameScreen extends StatelessWidget {
  const SignupNicknameScreen({super.key});

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

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            /// 제목
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "가입을 축하합니다! 👏🏻\n",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: "어떻게 불러드리면 될까요?",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 36),

            /// 닉네임 라벨
            Text(
              "닉네임",
              style: AppText.Body1.copyWith(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 12),

            /// 닉네임 입력창
            TextField(
              style: AppText.Body1.copyWith(color: Colors.white),
              decoration: InputDecoration(
                hintText: '닉네임을 입력해주세요.',
                hintStyle: AppText.Body2.copyWith(color: Colors.white54),
                filled: true,
                fillColor: const Color(0xFF4A4A4A),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),

      /// 🔥 하단 버튼 ======================
      bottomNavigationBar: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const SignupProfileScreen(),
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
    );
  }
}
