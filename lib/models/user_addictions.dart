import 'package:not_today_client/models/addictions.dart';

class UserAddictions {
  final String id;
  final String userId;
  final String
      addictionType; // This is a string, which needs to map to AddictionType
  final String severity;
  final int reasonAmount;
  final List<String> motivation;
  final int soberDays;

  const UserAddictions({
    required this.id,
    required this.userId,
    required this.addictionType, // e.g., 'ALCOHOL', 'CAFFEINE'
    required this.severity,
    required this.reasonAmount,
    required this.motivation,
    required this.soberDays,
  });

  // Updated method to handle string to AddictionType conversion
  AddictionType get addictionTypeEnum {
    switch (addictionType.toUpperCase()) {
      case 'ALCOHOL':
        return AddictionType.alcohol;
      case 'CAFFEINE':
        return AddictionType.caffeine;
      case 'SOCIAL_MEDIA':
        return AddictionType.socialMedia;
      // Add other cases if needed
      default:
        return AddictionType.alcohol; // Default to 'alcohol' if no match
    }
  }
}
