class SignupInfo {
  final String email;
  final String? password;
  final String? nickname;
  final String? profileImagePath; // 로컬 파일 경로 (선택)

  const SignupInfo({
    required this.email,
    this.password,
    this.nickname,
    this.profileImagePath,
  });

  SignupInfo copyWith({
    String? email,
    String? password,
    String? nickname,
    String? profileImagePath,
  }) {
    return SignupInfo(
      email: email ?? this.email,
      password: password ?? this.password,
      nickname: nickname ?? this.nickname,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
