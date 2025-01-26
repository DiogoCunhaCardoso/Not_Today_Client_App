import 'package:flutter_riverpod/flutter_riverpod.dart';

// User Class
class User {
  final String id;
  final String name;
  final String? pfp; // Profile Picture URL
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

// Example Initial Users
const List<User> users = [
  User(
    id: 'user_001',
    name: 'John Doe',
    pfp: null,
    email: 'user1@example.com',
    emailVerified: true,
    passwordResetCode: null,
    password: 'user12345',
  ),
  User(
    id: 'user_002',
    name: 'Jane Smith',
    pfp: null,
    email: 'user2@example.com',
    emailVerified: true,
    passwordResetCode: null,
    password: 'user67890',
  ),
];

// UserNotifier to handle user state
class UserNotifier extends StateNotifier<User?> {
  UserNotifier() : super(null);

  // Login Method - Modified to check for multiple users
  bool login(String email, String password) {
    try {
      final user = users.firstWhere(
        (user) => user.email == email && user.password == password,
      );
      state = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Register Method
  void register(String name, String email, String password) {
    final newUser = User(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      password: password,
      emailVerified: false,
      passwordResetCode: null,
    );
    users.add(newUser);
  }

  // Logout Method
  void logout() {
    state = null;
  }
}

// User Provider
final userProvider = StateNotifierProvider<UserNotifier, User?>(
  (ref) => UserNotifier(),
);
