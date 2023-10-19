import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/constants.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ProfileServices {
  static const String getUserProfileMutation = '''
    query GetUser(\$username: String!) {
      getUser(username: \$username) {
        _id
        createdAt
        username
        email
        followers {
          _id
          email
          username
        }
        following {
          _id
          email
          username
        }
        posts {
          body
          type
          createdAt
          username
          _id
        }
      }
    }
  ''';

  static const String followUserMutation = r'''
      mutation FollowUser($selectedUserId: ID!, $loggedInUserId: ID!) {
        followUser(selectedUserId: $selectedUserId, loggedInUserId: $loggedInUserId) {
          email
          createdAt
          _id
          followers {
            username
          }
          following {
            username
          }
          username
        }
      }
    ''';

  static const String unfollowUserMutation = r'''
      mutation UnfollowUser($selectedUserId: ID!, $loggedInUserId: ID!) {
        unfollowUser(selectedUserId: $selectedUserId, loggedInUserId: $loggedInUserId) {
          email
          createdAt
          _id
          followers {
            username
          }
          following {
            username
          }
          username
        }
      }
    ''';

  static const getPostsFeedQuery = '''
        query GetPosts {
          getPosts {
            _id
            type
            body
            user
            createdAt
          }
        }
      ''';

  static Future<void> followUser(
      {required String selectedUserId, required String loggedInUserId}) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql(followUserMutation),
      variables: <String, dynamic>{
        'selectedUserId': selectedUserId,
        'loggedInUserId': loggedInUserId,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isNotEmpty) {
        final errors = result.exception!.graphqlErrors;
        for (var error in errors) {
          print("GraphQL Error: ${error.message}");
          Fluttertoast.showToast(msg: error.message);
        }
      }
      if (result.exception!.linkException != null) {
        print(result.exception!.linkException!.originalException.toString());
        Fluttertoast.showToast(
            msg: result.exception!.linkException!.originalException.toString());
      }
      // Handle exceptions here
    } else {
      // Handle successful post creation here
      final data = result.data;
    }
  }

  static Future<void> unFollowUser(
      {required String selectedUserId, required String loggedInUserId}) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql(unfollowUserMutation),
      variables: <String, dynamic>{
        'selectedUserId': selectedUserId,
        'loggedInUserId': loggedInUserId,
      },
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isNotEmpty) {
        final errors = result.exception!.graphqlErrors;
        for (var error in errors) {
          print("GraphQL Error: ${error.message}");
          Fluttertoast.showToast(msg: error.message);
        }
      }
      if (result.exception!.linkException != null) {
        print(result.exception!.linkException!.originalException.toString());
        Fluttertoast.showToast(
            msg: result.exception!.linkException!.originalException.toString());
      }
      // Handle exceptions here
    } else {
      // Handle successful post creation here
      final data = result.data;
    }
  }

  // ---------------------------------------------
  // QUERY
  // ---------------------------------------------

  // 1. GET ALL POSTS/ FEEDS FROM DB

  static Future<QueryResult> getPosts() async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final QueryOptions options = QueryOptions(
      document: gql(getPostsFeedQuery),
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      // Handle exceptions here
      print("Exception : ");
      print(result.exception.toString());
      print("Real");
      print(result.exception!.linkException!.originalException);
    } else {
      // Handle successful post retrieval here
      final data = result.data;
      print("POSTS: ");
      print(data!['getPosts']);
    }
    return result;
  }

  // 2. GET SINGLE POST/ FEED FROM DB
  static Future<QueryResult> getSinglePost(String postId) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final QueryOptions options = QueryOptions(
      document: gql('''
        query GetSinglePost(\$postId: ID!) {
          getSinglePost(postId: \$postId) {
            _id
            type
            body
            user
            createdAt
          }
        }
      '''),
      variables: <String, dynamic>{
        'postId': postId,
      },
    );

    final QueryResult result = await _client.query(options);

    if (result.hasException) {
      // Handle exceptions here
      print("Exception : ");
      print(result.exception.toString());
    } else {
      // Handle successful retrieval of a single post here
      final data = result.data;
      print("SINGLE POST: ");
      print(data!['getSinglePost']);
    }

    return result;
  }
}
