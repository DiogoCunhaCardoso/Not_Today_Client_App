import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:not_today_client/graphql/graphql_config.dart';
import 'package:not_today_client/graphql/requests/diary_requests.dart';
import 'package:not_today_client/graphql/requests/user_requests.dart';
import 'package:not_today_client/models/diary_model.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  // Method for user registration
  Future<bool> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Perform the mutation
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(registerUserMutation),
          variables: {
            "input": {
              "name": name,
              "email": email,
              "password": password,
            },
          },
        ),
      );

      // Handle exceptions
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // If the mutation succeeds, return true
      return result.data?['createUser'] != null;
    } catch (e) {
      // If any errors occur, return false
      throw Exception('Error registering user: $e');
    }
  }

  // Method for user login
  Future<Map<String, dynamic>?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // Define the login mutation query
      const String loginMutation = """
        mutation(\$input: LoginInput!) {
          login(input: \$input) {
            token
          }
        }
      """;

      // Perform the mutation
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(loginMutation),
          variables: {
            "input": {
              "email": email,
              "password": password,
            },
          },
        ),
      );

      // Handle exceptions
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      // If the mutation succeeds, return the token
      if (result.data?['login'] != null) {
        return result.data?['login'];
      }

      // If login fails, return null
      return null;
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }

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
