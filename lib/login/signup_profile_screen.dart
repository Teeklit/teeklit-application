import 'package:flutter/material.dart';
import 'package:teeklit_application/ui/core/themes/app_text.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';

class SignupProfileScreen extends StatelessWidget {
  const SignupProfileScreen({super.key});

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

            /// 상단 텍스트
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "반가워요, 새싹랩님!\n",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: "마지막으로 ",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: "프로필 사진",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,   // 볼드 ONLY 여기
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                  TextSpan(
                    text: "을 올려볼까요?",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            /// 프로필 + 연필 아이콘
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  /// 프로필 원형 (로고 이미지만)
                  Container(
                    width: 110,
                    height: 110,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF4A4A4A),
                    ),
                    child: ClipOval(
                      child: FractionallySizedBox(
                        widthFactor: 0.6,   // ← 여기 숫자만 바꾸면 비율 조절됨 (0.0 ~ 1.0)
                        heightFactor: 0.6,  // ← 0.6 = 60% 크기(
                        child: Image.asset(
                          "assets/Images/grey_check.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  /// 연필 아이콘 버튼
                  Positioned(
                    bottom: -2,
                    right: -2,
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFF7F5E6),
                      ),
                      child: Center(
                        child: Image.asset(
                          "assets/Images/pencil.png", // 👈 연필 아이콘
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// 닉네임 표시
            Center(
              child: Text(
                "새싹랩",
                style: AppText.Body1.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w700, // 볼드 요청사항
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB1C39F),
            foregroundColor: Colors.black,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          child: Text(
            "가입완료하기",
            style: AppText.Button.copyWith(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
