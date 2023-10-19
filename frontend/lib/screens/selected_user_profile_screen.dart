import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api/profile_services.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/provider/following_data_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:provider/provider.dart';
import '../global_handler.dart';
import '../widgets/dateTime_text.dart';

class SelectedUserProfileScreen extends StatefulWidget {
  final String username;

  const SelectedUserProfileScreen({Key? key, required this.username})
      : super(key: key);

  @override
  State<SelectedUserProfileScreen> createState() =>
      _SelectedUserProfileScreenState();
}

class _SelectedUserProfileScreenState extends State<SelectedUserProfileScreen> {
  String? uName;
  String? uId;
  late bool isFollowing = false;

  @override
  void initState() {
    super.initState();
    fetchUsername();
  }

  Future<void> fetchUsername() async {
    final userData = await GlobalHandler.getUserData();
    setState(() {
      uName = userData['username'];
      uId = userData['_id'];
      // isFollowing = isFollowingUser(userData);
    });
  }

  bool checkIfFollowing(Map<String, dynamic> currentUser) {
    final List<dynamic> followers = currentUser['followers'];
    for (var follower in followers) {
      if (follower['username'] == uName) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.07,
          horizontal: size.width * 0.08,
        ),
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
              radius: 35,
              backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Username : ',
                        style: TextStyle(
                          color: ColorConstants.greyColor,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        '@${widget.username}',
                        style: const TextStyle(
                          color: ColorConstants.yelloColor,
                          fontSize: 22,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.0,
                  ),
                  Container(
                    height: size.height * 0.6,
                    width: size.width,
                    alignment: Alignment.center,
                    color: ColorConstants.blackColor,
                    child: ChangeNotifierProvider<FollowingDataProvider>(
                      create: (context) => FollowingDataProvider(),
                      child: Consumer<FollowingDataProvider>(
                          builder: (context, followingState, child) {
                        final isFollowing = followingState.isFollowing;

                        return graphql.Query(
                          options: graphql.QueryOptions(
                            document: graphql
                                .gql(ProfileServices.getUserProfileMutation),
                            variables: <String, dynamic>{
                              'username': widget.username,
                            },
                          ),
                          builder: (result, {refetch, fetchMore}) {
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
                            } else {
                              final Map<String, dynamic>? currentUser = result
                                  .data?['getUser'] as Map<String, dynamic>?;

                              if (currentUser == null) {
                                return const Text(
                                  'User data not found.',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              } else {
                                followingState.isFollowing =
                                    checkIfFollowing(currentUser);

                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      uName == currentUser['username']
                                          ? Container(
                                              height: 0,
                                            )
                                          : isFollowing
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    print("Wior");
                                                    ProfileServices.followUser(
                                                            selectedUserId:
                                                                currentUser[
                                                                    '_id'],
                                                            loggedInUserId:
                                                                uId!)
                                                        .then((value) {
                                                      followingState
                                                          .unfollowUser();
                                                    });
                                                  },
                                                  child: Text("Following"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    backgroundColor:
                                                        ColorConstants
                                                            .yelloColor,
                                                  ),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    ProfileServices.followUser(
                                                            selectedUserId:
                                                                currentUser[
                                                                    '_id'],
                                                            loggedInUserId:
                                                                uId!)
                                                        .then((value) {
                                                      followingState
                                                          .followUser();
                                                    }).onError((error,
                                                            stackTrace) {
                                                      Fluttertoast.showToast(
                                                          msg: "$error");
                                                    });
                                                  },
                                                  child: Text("Follow"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                    backgroundColor:
                                                        ColorConstants
                                                            .yelloColor,
                                                  ),
                                                ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              const Text(
                                                'Posts',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstants.greyColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                currentUser['posts']
                                                    .length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color:
                                                      ColorConstants.yelloColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'Followers',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstants.greyColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                isFollowing
                                                    ? (currentUser['followers']
                                                                .length +
                                                            1)
                                                        .toString()
                                                    : currentUser['followers']
                                                        .length
                                                        .toString(),
                                                style: const TextStyle(
                                                  color:
                                                      ColorConstants.yelloColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              const Text(
                                                'Following',
                                                style: TextStyle(
                                                  color:
                                                      ColorConstants.greyColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                currentUser['following']
                                                    .length
                                                    .toString(),
                                                style: const TextStyle(
                                                  color:
                                                      ColorConstants.yelloColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 6,
                                      ),
                                      MediaQuery.removePadding(
                                        context: context,
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              currentUser['posts'].length,
                                          itemBuilder: (context, index) {
                                            final cPost =
                                                currentUser['posts'][index];
                                            return Card(
                                              color: ColorConstants.blackColor,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16,
                                                      vertical: 2),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  cPost['type'] == "text"
                                                      ? Container(
                                                          width:
                                                              size.width * 0.9,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      12),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorConstants
                                                                    .greyColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: ColorConstants
                                                                .lightWhiteColor,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const CircleAvatar(
                                                                        radius:
                                                                            25,
                                                                        backgroundImage:
                                                                            NetworkImage(
                                                                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "@" +
                                                                                cPost['username'],
                                                                            style:
                                                                                const TextStyle(
                                                                              color: ColorConstants.blackColor,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                          localDateTimeText(
                                                                              int.parse(cPost['createdAt'])),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .more_vert_outlined,
                                                                    size: 25,
                                                                    color: ColorConstants
                                                                        .blackColor,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Text(
                                                                cPost['body'],
                                                                style:
                                                                    const TextStyle(
                                                                  color: ColorConstants
                                                                      .blackColor,
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 300,
                                                          width: size.width,
                                                          margin:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10),
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      12),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: ColorConstants
                                                                    .greyColor),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color: ColorConstants
                                                                .lightWhiteColor,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      const CircleAvatar(
                                                                        radius:
                                                                            25,
                                                                        backgroundImage:
                                                                            NetworkImage(
                                                                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            "@" +
                                                                                cPost['username'],
                                                                            style:
                                                                                const TextStyle(
                                                                              color: ColorConstants.blackColor,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w700,
                                                                            ),
                                                                          ),
                                                                          localDateTimeText(
                                                                              int.parse(cPost['createdAt'])),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .more_vert_outlined,
                                                                    size: 25,
                                                                    color: ColorConstants
                                                                        .blackColor,
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                height: 200,
                                                                width:
                                                                    size.width,
                                                                child: Image
                                                                    .network(
                                                                  cPost['body'],
                                                                  fit: BoxFit
                                                                      .fitHeight,
                                                                  errorBuilder: (BuildContext
                                                                          context,
                                                                      Object
                                                                          exception,
                                                                      StackTrace?
                                                                          stackTrace) {
                                                                    return Icon(
                                                                        Icons
                                                                            .error);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                  Text(
                                                      'Created At: ${DateTime.fromMillisecondsSinceEpoch(int.parse(currentUser['posts'][index]['createdAt'])).toLocal()}'),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                            // SelectedUserProfileWidget(
                            //   userData: currentUser,
                            //   username: uName ?? '',
                            //   userId: uId ?? '',
                            // );
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
