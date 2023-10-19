import 'package:flutter/material.dart';
import 'package:frontend/api/profile_services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/global_handler.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;

import '../widgets/user_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String username = "";
  String email = "";

  late Future<Map<String, dynamic>> user;

  @override
  void initState() {
    // TODO: implement initState
    user = GlobalHandler.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.07, horizontal: size.width * 0.08),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Social App",
                style: TextStyle(
                  color: ColorConstants.lightWhiteColor,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              const CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                ),
              ),
              Container(
                height: size.height * 0.7,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: size.height * 0.02,
                    bottom: size.height * 0.02,
                    left: size.width * 0.02,
                    right: size.width * 0.02),
                child: FutureBuilder<Map<String, dynamic>>(
                  future: user,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userData = snapshot.data;
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Username :',
                                  style: TextStyle(
                                    color: ColorConstants.greyColor,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  ' ${userData!['username']}',
                                  style: TextStyle(
                                    color: ColorConstants.yelloColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Email :',
                                  style: TextStyle(
                                    color: ColorConstants.greyColor,
                                    fontSize: 22,
                                  ),
                                ),
                                Text(
                                  ' ${userData['email']}',
                                  style: const TextStyle(
                                    color: ColorConstants.yelloColor,
                                    fontSize: 22,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Container(
                              height: size.height * 0.6,
                              width: size.width,
                              alignment: Alignment.center,
                              color: ColorConstants.blackColor,
                              child: graphql.Query(
                                options: graphql.QueryOptions(
                                  document: graphql.gql(
                                      ProfileServices.getUserProfileMutation),
                                  variables: <String, dynamic>{
                                    'username': userData[
                                        'username'], // Replace 'username' with the actual value
                                  },
                                ),
                                builder: (graphql.QueryResult result,
                                    {VoidCallback? refetch,
                                    graphql.FetchMore? fetchMore}) {
                                  if (result.hasException) {
                                    return const Text(
                                      'Error loading Profile.',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    );
                                  }

                                  if (result.isLoading) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }

                                  final Map<String, dynamic> currentUser =
                                      (result.data?['getUser']);

                                  return UserProfileWidget(
                                    userData: currentUser,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
