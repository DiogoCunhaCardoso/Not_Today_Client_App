enum AddictionType {
  alcohol,
  attentionSeeking,
  badLanguage,
  caffeine,
  dairy,
  drug,
  fastFood,
  gambling,
  nailBiting,
  porn,
  procrastination,
  selfHarm,
  smoking,
  socialMedia,
  softDrinks,
  sugar,
  vaping,
}

enum AddictionReason {
  money,
  time,
  event,
}

class Addictions {
  final String id;
  final AddictionType type;
  final List<String> symptoms;
  final List<String> treatmentOptions;
  final List<String> triggers;
  final List<String> copingMechanisms;
  final AddictionReason reason;

  const Addictions({
    required this.id,
    required this.type,
    required this.symptoms,
    required this.treatmentOptions,
    required this.triggers,
    required this.copingMechanisms,
    required this.reason,
  });
}
