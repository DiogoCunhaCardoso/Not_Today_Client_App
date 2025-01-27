import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:not_today_client/graphql/api_url.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(ApiUrl.baseUrl);

  GraphQLClient clientToQuery() => GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      );
}
