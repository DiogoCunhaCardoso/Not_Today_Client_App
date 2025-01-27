import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:not_today_client/graphql/graphql_config.dart';
import 'package:not_today_client/graphql/requests/diary_requests.dart';
import 'package:not_today_client/models/diary_model.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  // Fetch diary entries from the API
  Future<List<DiaryModel>> diaryEntries({required String userId}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(fetchDiariesQuery),
          variables: {"userId": userId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      List? res = result.data?['diaryEntries'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<DiaryModel> diaries =
          res.map((diary) => DiaryModel.fromMap(map: diary)).toList();

      return diaries;
    } catch (e) {
      throw Exception('Error fetching diaries: $e');
    }
  }

  Future<bool> deleteDiary({required String diaryId}) async {
    try {
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(deleteDiaryMutation),
          variables: {"diaryId": diaryId},
        ),
      );

      if (result.hasException) {
        throw Exception(result.hasException);
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> createDiary({
    required String userId,
    required String title,
    required String content,
  }) async {
    try {
      // Perform the mutation
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(createDiaryMutation),
          variables: {
            "userId": userId,
            "input": {
              "title": title,
              "content": content,
            },
          },
        ),
      );

      if (result.hasException) {
        return false;
      }

      // Success
      return true;
    } catch (e) {
      return false;
    }
  }

  // Add other methods (update, etc.) as needed
}
