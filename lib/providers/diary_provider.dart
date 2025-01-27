import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_today_client/graphql/graphql_service.dart';
import 'package:not_today_client/models/diary_model.dart';

// DiaryNotifier to manage diaries
class DiaryNotifier extends StateNotifier<List<DiaryModel>> {
  final GraphQLService graphQLService;
  DiaryNotifier(this.graphQLService) : super([]);

  Future<void> fetchDiaries(String userId) async {
    try {
      // Get the diaries from the API
      List<DiaryModel> fetchedDiaries =
          await graphQLService.diaryEntries(userId: userId);

      state = fetchedDiaries;
    } catch (e) {}
  }

  // Method to add a new diary entry
  void addDiary(String userId, String title, String content) {
    final newDiary = DiaryModel(
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
  List<DiaryModel> getLoggedInUserDiaries(String userId) {
    return state.where((diary) => diary.userId == userId).toList();
  }
}

final diaryProvider = StateNotifierProvider<DiaryNotifier, List<DiaryModel>>(
    (ref) => DiaryNotifier(GraphQLService()));
