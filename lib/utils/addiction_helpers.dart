import 'package:flutter/material.dart';

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

String getAddictionLabel(AddictionType addictionType) {
  switch (addictionType) {
    case AddictionType.alcohol:
      return 'Alcohol';
    case AddictionType.attentionSeeking:
      return 'Attention Seeking';
    case AddictionType.badLanguage:
      return 'Bad Language';
    case AddictionType.caffeine:
      return 'Caffeine';
    case AddictionType.dairy:
      return 'Dairy';
    case AddictionType.drug:
      return 'Drugs';
    case AddictionType.fastFood:
      return 'Fast Food';
    case AddictionType.gambling:
      return 'Gambling';
    case AddictionType.nailBiting:
      return 'Nail Biting';
    case AddictionType.porn:
      return 'Porn';
    case AddictionType.procrastination:
      return 'Procrastination';
    case AddictionType.selfHarm:
      return 'Self Harm';
    case AddictionType.smoking:
      return 'Smoking';
    case AddictionType.socialMedia:
      return 'Social Media';
    case AddictionType.softDrinks:
      return 'Soft Drinks';
    case AddictionType.sugar:
      return 'Sugar';
    case AddictionType.vaping:
      return 'Vaping';
  }
}

IconData getAddictionIcon(AddictionType addictionType) {
  switch (addictionType) {
    case AddictionType.alcohol:
      return Icons.local_bar;
    case AddictionType.attentionSeeking:
      return Icons.visibility;
    case AddictionType.badLanguage:
      return Icons.sentiment_dissatisfied;
    case AddictionType.caffeine:
      return Icons.coffee;
    case AddictionType.dairy:
      return Icons.icecream;
    case AddictionType.drug:
      return Icons.medical_services;
    case AddictionType.fastFood:
      return Icons.fastfood;
    case AddictionType.gambling:
      return Icons.casino;
    case AddictionType.nailBiting:
      return Icons.face;
    case AddictionType.porn:
      return Icons.no_adult_content;
    case AddictionType.procrastination:
      return Icons.access_time;
    case AddictionType.selfHarm:
      return Icons.self_improvement;
    case AddictionType.smoking:
      return Icons.smoking_rooms;
    case AddictionType.socialMedia:
      return Icons.phone_android;
    case AddictionType.softDrinks:
      return Icons.local_drink;
    case AddictionType.sugar:
      return Icons.food_bank;
    case AddictionType.vaping:
      return Icons.air;
  }
}
