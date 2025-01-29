import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:not_today_client/graphql/api_url.dart';
import 'package:not_today_client/utils/secure_storage.dart'; // Add this import for SecureStorage

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(ApiUrl.baseUrl);

  // Adding AuthLink to the HTTP link chain for Authorization header
  static AuthLink authLink = AuthLink(
    getToken: () async {
      // Get token from Secure Storage or your custom token source
      String? token = await SecureStorage
          .retrieveToken(); // Assuming you have a method to retrieve the token
      if (token == null || token.isEmpty) {
        return ""; // If no token is found, return an empty string.
      }
      return "Bearer $token"; // Return the token with "Bearer" prefix.
    },
    headerKey: "Authorization", // Default header key is "Authorization"
  );

  // Combine the AuthLink and HttpLink
  static Link link = authLink.concat(httpLink);

  // Method to create the GraphQLClient
  GraphQLClient clientToQuery() {
    return GraphQLClient(
      link: link, // Use the link with AuthLink
      cache: GraphQLCache(),
    );
  }
}
