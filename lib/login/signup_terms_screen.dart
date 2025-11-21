import 'package:flutter/material.dart';
import 'package:teeklit/login/signup_email.dart';

import '../ui/core/themes/app_text.dart';
import '../ui/core/themes/colors.dart';

// 다음 페이지: 이메일 입력

class SignupTermsScreen extends StatefulWidget {
  SignupTermsScreen({super.key});

  @override
  State<SignupTermsScreen> createState() => _SignupTermsScreenState();
}

class _SignupTermsScreenState extends State<SignupTermsScreen> {
  // 체크 상태 저장
  bool agreeAll = false;
  bool agree1 = false; // 필수
  bool agree2 = false; // 선택
  bool agree3 = false; // 선택

  bool get isButtonEnabled => agree1 && agree2;

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

  /// ===========================================
  /// 🔹 "다음" 버튼 로직 (필수 약관 검사 후 이동)
  /// ===========================================
  void _onNextPressed() {
    if (!agree1||!agree2) {
      // 필수 약관 미체크 → 경고만 출력
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("필수 약관에 동의해야 회원가입을 진행할 수 있습니다."),
        ),
      );
      return;
    }

    // 필수 체크된 경우 → 다음 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignupEmailScreen()),
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
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: 28,
            color: AppColors.strokeGray,
          ),
        ),
      ),

      // ----------------------
      // 하단 버튼
      // ----------------------
      bottomNavigationBar: SizedBox(
        height: 80,
        child: ElevatedButton(
          onPressed: _onNextPressed,  // ← 함수 호출만 남김
          style: ElevatedButton.styleFrom(
            backgroundColor: isButtonEnabled
                ? AppColors.green
                : AppColors.txtGray,
              elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
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
                      fontWeight: FontWeight.w700,
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
                  () {
                setState(() {
                  agreeAll = !agreeAll;
                  agree1 = agreeAll;
                  agree2 = agreeAll;
                  agree3 = agreeAll;
                });
              },
            ),

            const SizedBox(height: 16),

            // 약관1 (필수)
            _checkItem(
              "서비스 이용 약관 (필수)",
              agree1,
                  () {
                setState(() {
                  agree1 = !agree1;

                  // 개별 해제 → 전체동의 false
                  if (!agree1) agreeAll = false;
                });
              },
            ),

            const SizedBox(height: 12),

            // 약관2 (선택)
            _checkItem(
              "제3자 개인정보 처리 동의 (필수)",
              agree2,
                  () {
                setState(() {
                  agree2 = !agree2;
                  if (!agree2) agreeAll = false;
                });
              },
            ),

            const SizedBox(height: 12),

            // 약관3 (선택)
            _checkItem(
              "마케팅 정보 수신 동의 (선택)",
              agree3,
                  () {
                setState(() {
                  agree3 = !agree3;
                  if (!agree3) agreeAll = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
