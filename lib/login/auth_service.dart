import 'package:firebase_auth/firebase_auth.dart';

/// Firebase Auth 관련 로직을 한 곳에 모아 두는 서비스 클래스.
/// - 회원가입 (이메일/비밀번호)
/// - 로그인
/// - 로그아웃
/// 등 Auth 관련 공통 로직을 여기서 관리한다.
class AuthService {
  AuthService._internal();

  /// 싱글톤 인스턴스
  static final AuthService instance = AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// 1) 이메일/비밀번호로 Firebase 계정 생성
  ///
  /// 사용 예:
  /// await AuthService.instance.signUpWithEmail(
  ///   email: 'test@test.com',
  ///   password: 'password123',
  /// );
  Future<UserCredential> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 필요하면 여기서 바로 인증 메일을 보낼 수도 있음
      // await credential.user?.sendEmailVerification();

      return credential;
    } on FirebaseAuthException catch (e) {
      // UI에서 코드별로 처리할 수 있도록 그대로 던진다.
      // 예: email-already-in-use, weak-password 등
      rethrow;
    } catch (e) {
      // 예상치 못한 에러도 UI에서 잡을 수 있도록 다시 던짐
      rethrow;
    }
  }

  /// 2) 이메일/비밀번호 로그인
  ///
  /// 사용 예:
  /// await AuthService.instance.signInWithEmail(
  ///   email: 'test@test.com',
  ///   password: 'password123',
  /// );
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  /// 3) 로그아웃
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// 4) FirebaseAuthException → 사용자용 에러 메시지 변환 헬퍼
  ///
  /// UI에서 스낵바/다이얼로그 메시지용으로 사용 가능.
  String getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return '이미 사용 중인 이메일입니다.';
      case 'invalid-email':
        return '이메일 형식이 올바르지 않습니다.';
      case 'weak-password':
        return '비밀번호가 너무 약합니다. 6자 이상으로 설정해주세요.';
      case 'user-not-found':
      case 'wrong-password':
        return '이메일 또는 비밀번호가 올바르지 않습니다.';
      default:
        return '인증 중 알 수 없는 오류가 발생했습니다. (${e.code})';
    }
  }
}
