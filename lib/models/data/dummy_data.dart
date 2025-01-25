import 'package:not_today_client/models/user.dart';
import 'package:not_today_client/models/user_addictions.dart';
import 'package:not_today_client/models/user_milestone.dart';
import 'package:not_today_client/models/diary.dart';
import 'package:not_today_client/models/addictions.dart';

// Dummy User
const users = User(
  id: 'user_001',
  name: 'John Doe',
  pfp:
      'https://imgcdn.stablediffusionweb.com/2024/9/16/86cbcc4a-3430-42ba-af5c-233ccd545b22.jpg',
  email: 'johndoe@example.com',
  emailVerified: true,
  passwordResetCode: null,
  password: 'securepassword123',
);

// Dummy User Addictions
const userAddictions = [
  UserAddictions(
    id: 'addiction_001',
    userId: 'user_001',
    addictionType: 'ALCOHOL',
    severity: 'High',
    reasonAmount: 5,
    motivation: ['Health', 'Family'],
    soberDays: 30,
  ),
  UserAddictions(
    id: 'addiction_002',
    userId: 'user_001',
    addictionType: 'CAFFEINE',
    severity: 'Moderate',
    reasonAmount: 2,
    motivation: ['Better Sleep', 'Focus'],
    soberDays: 10,
  ),
  UserAddictions(
    id: 'addiction_003',
    userId: 'user_001',
    addictionType: 'DRUG',
    severity: 'Low',
    reasonAmount: 3,
    motivation: ['Productivity', 'Mental Health'],
    soberDays: 7,
  ),
];

// Dummy User Milestones
final userMilestones = [
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

// Dummy Diaries
final diaries = [
  Diary(
    id: 'diary_001',
    userId: 'user_001',
    title: 'First Day of Sobriety',
    content: 'Today was tough, but I am determined to change.',
    date: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Diary(
    id: 'diary_002',
    userId: 'user_001',
    title: 'Small Victories',
    content: 'I resisted the urge to drink coffee this morning!',
    date: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Diary(
    id: 'diary_003',
    userId: 'user_001',
    title: 'Social Media Detox',
    content: 'I realized how much time I saved by avoiding social media.',
    date: DateTime.now(),
    createdAt: DateTime.now(),
  ),
];

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
