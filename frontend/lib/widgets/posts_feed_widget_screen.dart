import 'package:flutter/material.dart';
import 'package:frontend/api/feed_services.dart';
import 'package:frontend/screens/selected_user_profile_screen.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import '../constants.dart';
import '../models/posts_model.dart';
import 'dateTime_text.dart';

class FeedWidget extends StatelessWidget {
  const FeedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder<graphql.QueryResult>(
      future: FeedServices.getPosts(),
      builder:
          (BuildContext context, AsyncSnapshot<graphql.QueryResult> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text('Error loading data.');
        } else {
          final List<Post> posts = snapshot.data?.data?['getPosts'] == null
              ? [
                  Post(
                      id: "_123456",
                      type: "text",
                      body: "Establish Server Connection",
                      user: User(id: "120120"),
                      username: "SOCIAL",
                      createdAt: "1697604273712")
                ]
              : List<Post>.from(
                  (snapshot.data?.data?['getPosts'] as List<dynamic>).map(
                      (post) => Post.fromJson(post as Map<String, dynamic>)),
                );

          // Build your UI using the 'post' data
          return MediaQuery.removePadding(
            context: context,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final Post post = posts[index];

                return post.type == "text"
                    ? Container(
                        width: size.width * 0.8,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.greyColor),
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstants.lightWhiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        NavigationConstants.nextScreen(
                                            context,
                                            SelectedUserProfileScreen(
                                                username: post.username));
                                      },
                                      child: const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            NavigationConstants.nextScreen(
                                                context,
                                                SelectedUserProfileScreen(
                                                    username: post.username));
                                          },
                                          child: Text(
                                            "@" + post.username,
                                            style: const TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        localDateTimeText(
                                            int.parse(post.createdAt)),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.more_vert_outlined,
                                  size: 25,
                                  color: ColorConstants.blackColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              post.body,
                              style: const TextStyle(
                                color: ColorConstants.blackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(
                        height: 300,
                        width: size.width * 0.8,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.greyColor),
                          borderRadius: BorderRadius.circular(12),
                          color: ColorConstants.lightWhiteColor,
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        NavigationConstants.nextScreen(
                                            context,
                                            SelectedUserProfileScreen(
                                                username: post.username));
                                      },
                                      child: const CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            NavigationConstants.nextScreen(
                                                context,
                                                SelectedUserProfileScreen(
                                                    username: post.username));
                                          },
                                          child: Text(
                                            "@" + post.username,
                                            style: const TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        localDateTimeText(
                                            int.parse(post.createdAt)),
                                      ],
                                    ),
                                  ],
                                ),
                                const Icon(
                                  Icons.more_vert_outlined,
                                  size: 25,
                                  color: ColorConstants.blackColor,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 200,
                              width: size.width,
                              child: Image.network(
                                post.body,
                                fit: BoxFit.contain,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
              },
            ),
          );
        }
      },
    );
  }
}
