import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define MilestoneName Enum
enum MilestoneName {
  awakening,
  determination,
  diaries,
  resilience,
  balance,
  mastery,
  freedom,
  enlightenment,
}

// Define UserMilestone Class
class UserMilestone {
  final String id;
  final String userId;
  final MilestoneName name;
  final int level; // Range from 1 to 7
  final DateTime achievedDate;

  const UserMilestone({
    required this.id,
    required this.userId,
    required this.name,
    required this.level,
    required this.achievedDate,
  });
}

// Dummy initial milestones
final List<UserMilestone> initialMilestones = [
  UserMilestone(
    id: 'milestone_001',
    userId: 'user_001',
    name: MilestoneName.awakening,
    level: 1,
    achievedDate: DateTime.now(),
  ),
  UserMilestone(
    id: 'milestone_002',
    userId: 'user_001',
    name: MilestoneName.determination,
    level: 2,
    achievedDate: DateTime.now(),
  ),
  UserMilestone(
    id: 'milestone_003',
    userId: 'user_001',
    name: MilestoneName.resilience,
    level: 3,
    achievedDate: DateTime.now(),
  ),
];

// StateNotifier to manage milestones
class UserMilestoneNotifier extends StateNotifier<List<UserMilestone>> {
  UserMilestoneNotifier() : super(initialMilestones);

  // Method to get milestones of the logged-in user
  List<UserMilestone> getLoggedInUserMilestones(String userId) {
    return state.where((milestone) => milestone.userId == userId).toList();
  }
}

// Provider for the milestones
final userMilestoneProvider =
    StateNotifierProvider<UserMilestoneNotifier, List<UserMilestone>>(
  (ref) => UserMilestoneNotifier(),
);
