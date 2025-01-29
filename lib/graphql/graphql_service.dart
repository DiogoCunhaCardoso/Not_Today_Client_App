import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:not_today_client/graphql/graphql_config.dart';
import 'package:not_today_client/graphql/requests/diary_requests.dart';
import 'package:not_today_client/graphql/requests/user_requests.dart';
import 'package:not_today_client/utils/secure_storage.dart';

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
      // Perform the mutation
      QueryResult result = await client.mutate(
        MutationOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(loginUserMutation),
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
      if (result.data?['login'] != null &&
          result.data?['login']['token'] != null) {
        final String token = result.data?['login']['token'];
        print('Token: $token');

        // Store the token securely using SecureStorage
        await SecureStorage.storeToken(token);

        // Return the result data with the token
        return result.data?['login'];
      }

      // If login fails, return null
      return null;
    } catch (e) {
      throw Exception('Error logging in user: $e');
    }
  }

  // Fetch User Profile
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    try {
      final result = await client.query(
        QueryOptions(
          document: gql(meQuery),
        ),
      );

      if (result.hasException) {
        print("Error fetching user profile: ${result.exception.toString()}");
        return null;
      }

      return result.data?['me'];
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // Logout: Delete Token
  static Future<void> deleteToken() async {
    await SecureStorage.deleteToken();
  }

  // Get Diaries
  Future<List<Map<String, dynamic>>> getDiaries() async {
    try {
      // Fetch diaries from GraphQL
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql(fetchDiariesQuery),
          variables: const {},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      List<Map<String, dynamic>> diaries = [];

      if (result.data?['diaryEntries'] != null) {
        for (var diary in result.data?['diaryEntries']) {
          if (diary['date'] != null) {
            try {
              // Try to parse the date if it's in ISODate format (e.g., "2025-01-29T12:34:56.000Z")
              diary['date'] = DateTime.parse(diary['date']);
            } catch (e) {
              // If DateTime.parse() fails, check if it's a timestamp in milliseconds
              if (diary['date'] is String &&
                  int.tryParse(diary['date']) != null) {
                // Convert the string timestamp to DateTime
                final timestamp = int.parse(diary['date']);
                diary['date'] = DateTime.fromMillisecondsSinceEpoch(timestamp);
              } else {
                // Set default or fallback DateTime if neither parsing method works
                diary['date'] = DateTime(1970, 1, 1);
              }
            }
          }

          // Add the diary entry with the parsed date
          diaries.add(diary);
        }
      }

      return diaries;
    } catch (e) {
      throw Exception('Error fetching diaries: $e');
    }
  }

  // Function to create a diary entry
  Future<bool> createDiary({
    required String title,
    required String content,
  }) async {
    try {
      // Retrieve the token from SecureStorage
      String? token = await SecureStorage.retrieveToken();
      if (token == null || token.isEmpty) {
        print("No token found, user is not authenticated.");
        return false;
      }

      // Prepare the variables for the mutation
      final variables = {
        'input': {
          'title': title,
          'content': content,
        },
      };

      // Execute the mutation
      final result = await client.mutate(
        MutationOptions(
          document: gql(createDiaryMutation),
          variables: variables,
        ),
      );

      if (result.hasException) {
        print("Error creating diary: ${result.exception.toString()}");

        // Check if there are GraphQL errors and handle them
        if (result.exception?.graphqlErrors != null) {
          for (var error in result.exception!.graphqlErrors) {
            print("GraphQL Error: ${error.message}");

            if (error.message
                .contains("You have already created a diary entry today.")) {
              // Throw a specific exception when the error is related to already creating a diary
              throw Exception(error.message);
            }
          }
        }

        return false;
      }

      // Successfully created the diary entry
      return true;
    } catch (e) {
      print("Error: $e");
      rethrow; // Propagate the exception to be handled in the UI
    }
  }

  // Function to delete a diary entry
  Future<bool> deleteDiary(String id) async {
    try {
      String? token = await SecureStorage.retrieveToken();
      if (token == null || token.isEmpty) {
        print("No token found, user is not authenticated.");
        return false;
      }

      final variables = {
        'deleteDiaryId': id,
      };

      final result = await client.mutate(
        MutationOptions(
          document: gql(deleteDiaryMutation),
          variables: variables,
        ),
      );

      if (result.hasException) {
        print("Error deleting diary: ${result.exception.toString()}");
        return false;
      }

      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
