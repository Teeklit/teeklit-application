import 'package:flutter/material.dart';
import 'package:teeklit_application/ui/core/themes/colors.dart';
import 'package:teeklit_application/ui/core/themes/app_text.dart';

// 다음 페이지: 이메일 입력
import 'package:teeklit_application/login/signup_email.dart';

class SignupTermsScreen extends StatefulWidget {
  SignupTermsScreen({super.key});

  @override
  State<SignupTermsScreen> createState() => _SignupTermsScreenState();
}

class _SignupTermsScreenState extends State<SignupTermsScreen> {
  // 체크 상태 저장
  bool agreeAll = false;
  bool agree1 = false;
  bool agree2 = false;
  bool agree3 = false;

  /// 공통 체크박스 UI
  Widget _checkItem(String text, bool checked, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Image.asset(
            checked
                ? 'assets/images/green_check.png'
                : 'assets/images/grey_check.png',
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: AppText.Body1.copyWith(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      // ----------------------
      // 상단 AppBar
      // ----------------------
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(//todo: leading icon은 flutter default를 사용하기. 삭제.
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: 28,
            color: AppColors.strokeGray, // 앱 컬러
          ),
        ),
      ),

      // ----------------------
      // 하단 버튼
      // ----------------------
      bottomNavigationBar: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SignupEmailScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF8C8C8C),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            elevation: 0,
          ),
          child: Text(
            "다음",
            style: AppText.Button.copyWith(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),

      // ----------------------
      // 본문 UI
      // ----------------------
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // 제목
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "서비스 이용을 위한\n",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  TextSpan(
                    text: "약관동의",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.w700, // 볼드
                    ),
                  ),
                  TextSpan(
                    text: "의 안내예요.",
                    style: AppText.H1.copyWith(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ----------------------
            // 체크박스들
            // ----------------------

            // 모두 동의
            _checkItem(
              "모두 동의하기",
              agreeAll,
                  () {//todo: 함수 따로 뽑기
                setState(() {
                  agreeAll = !agreeAll;
                  agree1 = agreeAll;
                  agree2 = agreeAll;
                  agree3 = agreeAll;
                });
              },
            ),

            const SizedBox(height: 16),

            // 약관1
            _checkItem(
              "약관 1 (필수)",
              agree1,
                  () {
                setState(() => agree1 = !agree1);
              },
            ),

            const SizedBox(height: 12),

            // 약관2
            _checkItem(
              "약관 2 (선택)",
              agree2,
                  () {
                setState(() => agree2 = !agree2);
              },
            ),

            const SizedBox(height: 12),

            // 약관3
            _checkItem(
              "약관 3 (선택)",
              agree3,
                  () {
                setState(() => agree3 = !agree3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
