import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global_handler.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../constants.dart';

class AuthServices {
  static Future<void> registerUser(String username, String email,
      String password, String confirmPassword, BuildContext context) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);

    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation RegisterUser(\$username: String!, \$email: String!, \$password: String!, \$confirmPassword: String!) {
          registerUser(username: \$username, email: \$email, password: \$password, confirmPassword: \$confirmPassword) {
            _id
            username
            email
            createdAt
            token
          }
        }
      '''),
      variables: <String, dynamic>{
        'username': username,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      },
    );
    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      if (result.exception!.linkException!.originalException!
          is FormatException) {
        Fluttertoast.showToast(msg: "Enter valid details");
      } else {
        Fluttertoast.showToast(
            msg: result.exception!.linkException!.originalException.toString());
      }
      // Handle exceptions here
    } else {
      // Handle successful registration here
      final data = result.data;

      await GlobalHandler.saveUserData(data!["registerUser"])
          .then((value) => print("Everything saved successfully !"));
      Fluttertoast.showToast(msg: "User registered successfully !");
      NavigationConstants.nextScreenReplacement(context, HomeScreen());
      // Access the necessary data from the 'data' object
    }
  }

  // 2. FUNCTION TO LOGIN A REGISTERED USER
  static Future<void> loginUser(
      String email, String password, BuildContext context) async {
    final HttpLink httpLink = HttpLink(Constants.graphQlAPIURL);
    final GraphQLClient _client =
        GraphQLClient(link: httpLink, cache: GraphQLCache());

    final MutationOptions options = MutationOptions(
      document: gql('''
        mutation LoginUser(\$email: String!, \$password: String!) {
          loginUser(email: \$email, password: \$password) {
            _id
            username
            email
            createdAt
            token
          }
        }
      '''),
      variables: <String, dynamic>{
        'email': email,
        'password': password,
      },
    );

    final QueryResult result = await _client.mutate(options);
    if (result.hasException) {
      print(result.exception!.linkException!.originalException!);
      if (result.exception!.linkException!.originalException!
          is FormatException) {
        Fluttertoast.showToast(msg: "Enter valid Credentials 2");
      } else {
        Fluttertoast.showToast(
            msg: result.exception!.linkException!.originalException.toString());
      }
      // Handle exceptions here
    } else {
      // Handle successful registration here
      final data = result.data;
      print(data!['loginUser']);
      await GlobalHandler.saveUserData(data["loginUser"])
          .then((value) => print("Everything saved successfully !"));
      Fluttertoast.showToast(msg: "User registered successfully !");
      NavigationConstants.nextScreenReplacement(context, HomeScreen());
      // Access the necessary data from the 'data' object
    }
  }
}
