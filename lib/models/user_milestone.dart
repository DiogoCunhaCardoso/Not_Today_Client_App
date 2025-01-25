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
