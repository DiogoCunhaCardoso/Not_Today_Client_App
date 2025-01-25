class User {
  final String id;
  final String name;
  final String? pfp;
  final String email;
  final bool emailVerified;
  final String? passwordResetCode;
  final String password;

  const User({
    required this.id,
    required this.name,
    this.pfp,
    required this.email,
    required this.emailVerified,
    this.passwordResetCode,
    required this.password,
  });
}
