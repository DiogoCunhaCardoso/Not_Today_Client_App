import 'package:not_today_client/models/addictions.dart';
import 'package:not_today_client/utils/addiction_helpers.dart';

// Dummy Addictions
const addictions = [
  Addictions(
    id: 'addiction_info_001',
    type: AddictionType.alcohol,
    symptoms: ['Cravings', 'Shaking', 'Mood Swings'],
    treatmentOptions: ['Counseling', 'Support Groups', 'Medication'],
    triggers: ['Stress', 'Social Events'],
    copingMechanisms: ['Exercise', 'Meditation', 'Talking to Friends'],
    reason: AddictionReason.event,
  ),
  Addictions(
    id: 'addiction_info_002',
    type: AddictionType.caffeine,
    symptoms: ['Headaches', 'Fatigue', 'Irritability'],
    treatmentOptions: ['Reducing Intake', 'Herbal Teas'],
    triggers: ['Morning Routine', 'Work Deadlines'],
    copingMechanisms: ['Healthy Breakfast', 'Staying Hydrated'],
    reason: AddictionReason.time,
  ),
  Addictions(
    id: 'addiction_info_003',
    type: AddictionType.drug,
    symptoms: ['Anxiety', 'Low Productivity'],
    treatmentOptions: ['Digital Detox', 'Screen Time Limits'],
    triggers: ['Boredom', 'Notifications'],
    copingMechanisms: ['Outdoor Activities', 'Reading'],
    reason: AddictionReason.money,
  ),
];
