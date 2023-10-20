import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

import '../screens/main_home_Screen.dart';

class FeedServices {
  static const String getFeedPosts = '''
  query Query {
    getPosts {
      _id
      body
      createdAt
      taggedUsers {
        _id
        username
      }
      type
      user {
        username
        _id
        email
      }
    }
  }
''';

  static const String createImagePostMutation = '''
        mutation CreateImagePost(\$input: ImagePostInput!) {
          createImagePost(input: \$input) {
            createdAt
            body
            type
            _id
            username
          }
        }
      ''';

  // ---------------------------------------------
  // QUERY
  // ---------------------------------------------

  // 1. GET ALL POSTS/ FEEDS FROM DB

  static Future<graphql.QueryResult> getPosts() async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );

    final options = graphql.QueryOptions(
      document: graphql.gql(getFeedPosts),
    );

    final graphql.QueryResult result = await client.query(options);
    print(result.data);
    return result;
  }

  // 2. GET SINGLE POST/ FEED FROM DB
  static Future<graphql.QueryResult> getSinglePost(String postId) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );

    final options = graphql.QueryOptions(
      document: graphql.gql(getFeedPosts),
    );

    // final graphql.QueryResult result = await client.query(options);

    // return result;

    try {
      final graphql.QueryResult result = await client.query(options);
      return result;
    } catch (error) {
      return graphql.QueryResult(
        exception: OperationException(
          graphqlErrors: [GraphQLError(message: error.toString())],
        ),
        options: options,
        source: QueryResultSource.loading,
      );
    }
  }

  // ---------------------------------------------
  // MUTATIONS
  // ---------------------------------------------

  // 1. CREATE A TEXT POST MUTATION OPERATION

  static Future<void> createTextPost(String text, String type, String userId,
      String username, BuildContext context) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation CreateTextPost(\$input: TextPostInput!) {
          createTextPost(input: \$input) {
            createdAt
            body
            type
            _id
            username
          }
        }
      '''),
      variables: <String, dynamic>{
        'input': {
          'text': text,
          'type': type,
          'userId': userId,
          'username': username,
        },
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      Fluttertoast.showToast(
          msg: result.exception!.linkException!.originalException.toString());
      // Handle exceptions here
    } else {
      // Handle successful post creation here
      final data = result.data;

      NavigationConstants.nextScreenReplacement(context, MainHomeScreen());
      // Access the necessary data from the 'data' object
    }
  }

  static Future<void> createImagePost(String image, String type, String userId,
      String username, BuildContext context) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql(createImagePostMutation),
      variables: <String, dynamic>{
        'input': {
          'image': image,
          'type': type,
          'userId': userId,
          'username': username,
        },
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print(result.exception);
      Fluttertoast.showToast(
          msg: result.exception!.linkException!.originalException.toString());
      // Handle exceptions here
    } else {
      // Handle successful post creation here
      final data = result.data;
      NavigationConstants.nextScreenReplacement(context, MainHomeScreen());
      // Access the necessary data from the 'data' object
    }
  }

  static Future<void> deletePost(String postId, String userId) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation DeletePost(\$postId: ID!, \$userId: ID!) {
          deletePost(postId: \$postId, userId: \$userId)
        }
      '''),
      variables: <String, dynamic>{
        'postId': postId,
        'userId': userId,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      Fluttertoast.showToast(
          msg: result.exception!.linkException!.originalException.toString());
      // Handle exceptions here
    } else {
      // Handle successful post deletion here
      final data = result.data;
      print(data!['deletePost']);
      // Access the necessary data from the 'data' object
    }
  }
}
