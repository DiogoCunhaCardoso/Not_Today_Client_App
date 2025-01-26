import 'package:flutter_riverpod/flutter_riverpod.dart';

// Diary model
class Diary {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime date;
  final DateTime createdAt;

  const Diary({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.date,
    required this.createdAt,
  });
}

// Initial dummy diary data
final _initialDiaries = [
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

// DiaryNotifier to manage diaries
class DiaryNotifier extends StateNotifier<List<Diary>> {
  DiaryNotifier() : super(_initialDiaries);

  // Method to add a new diary entry
  void addDiary(String userId, String title, String content) {
    final newDiary = Diary(
      id: DateTime.now().toString(),
      userId: userId,
      title: title,
      content: content,
      date: DateTime.now(),
      createdAt: DateTime.now(),
    );
    state = [...state, newDiary];
  }

  // Method to remove a diary entry
  void removeDiary(String id) {
    state = state.where((diary) => diary.id != id).toList();
  }

  // Method to get diaries of the logged-in user
  List<Diary> getLoggedInUserDiaries(String userId) {
    return state.where((diary) => diary.userId == userId).toList();
  }
}

final diaryProvider =
    StateNotifierProvider<DiaryNotifier, List<Diary>>((ref) => DiaryNotifier());
