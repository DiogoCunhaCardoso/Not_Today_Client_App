import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAddiction {
  final String id;
  final String userId;
  final String addictionType;
  final String severity;
  final int reasonAmount;
  final List<String> motivation;
  final int soberDays;

  UserAddiction({
    required this.id,
    required this.userId,
    required this.addictionType,
    required this.severity,
    required this.reasonAmount,
    required this.motivation,
    required this.soberDays,
  });
}

final _initialUserAddictions = [
  UserAddiction(
    id: 'addiction_001',
    userId: 'user_001',
    addictionType: 'ALCOHOL',
    severity: 'High',
    reasonAmount: 5,
    motivation: ['Health', 'Family'],
    soberDays: 30,
  ),
  UserAddiction(
    id: 'addiction_002',
    userId: 'user_001',
    addictionType: 'CAFFEINE',
    severity: 'Moderate',
    reasonAmount: 2,
    motivation: ['Better Sleep', 'Focus'],
    soberDays: 10,
  ),
  UserAddiction(
    id: 'addiction_003',
    userId: 'user_001',
    addictionType: 'DRUG',
    severity: 'Low',
    reasonAmount: 3,
    motivation: ['Productivity', 'Mental Health'],
    soberDays: 7,
  ),
];

class UserAddictionNotifier extends StateNotifier<List<UserAddiction>> {
  UserAddictionNotifier() : super(_initialUserAddictions);

  // Method to add a new addiction
  void addAddiction(UserAddiction addiction) {
    state = [...state, addiction];
  }

  // Method to remove an addiction
  void removeAddiction(String id) {
    state = state.where((addiction) => addiction.id != id).toList();
  }

  // Method to get addictions of the logged-in user
  List<UserAddiction> getLoggedInUserAddictions(String userId) {
    return state.where((addiction) => addiction.userId == userId).toList();
  }
}

final userAddictionProvider =
    StateNotifierProvider<UserAddictionNotifier, List<UserAddiction>>(
  (ref) => UserAddictionNotifier(),
);
