import 'dart:math';
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
          return const Center(
            child: Text(
              'Error loading data.',
              style: TextStyle(
                color: ColorConstants.lightWhiteColor,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        } else {
          final List<Post> posts =
              (snapshot.data?.data?['getPosts'] as List<dynamic>)
                  .map((post) => Post.fromJson(post as Map<String, dynamic>))
                  .toList();

          // Build your UI using the 'post' data
          return MediaQuery.removePadding(
            context: context,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                // print(posts);

                final Post post = posts[index];
                print(post.taggedUsers);

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
                                                username:
                                                    post.user!.username!));
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
                                                    username:
                                                        post.user!.username!));
                                          },
                                          child: Text(
                                            "@" + post.user!.username!,
                                            style: const TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        localDateTimeText(
                                            int.parse(post.createdAt!)),
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
                              post.body!,
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
                                                username:
                                                    post.user!.username!));
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
                                                    username:
                                                        post.user!.username!));
                                          },
                                          child: Text(
                                            "@" + post.user!.username!,
                                            style: const TextStyle(
                                              color: ColorConstants.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        localDateTimeText(
                                            int.parse(post.createdAt!)),
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

                            InstagramPostWidget(
                              username: post.user!.username!,
                              postImageUrl: post.body!,
                              taggedUsernames: post.taggedUsers ?? [],
                            ),
                            // Stack(
                            //   children: [
                            //     Container(
                            //       height: 200,
                            //       width: size.width,
                            //       child: Image.network(
                            //         post.body!,
                            //         fit: BoxFit.contain,
                            //         errorBuilder: (BuildContext context,
                            //             Object exception,
                            //             StackTrace? stackTrace) {
                            //           return const Icon(Icons.error);
                            //         },
                            //       ),
                            //     ),
                            //     if (post.taggedUsers != null &&
                            //         post.taggedUsers!.isNotEmpty)
                            //       ..._buildTaggedUsernamesWidgets(
                            //           post.taggedUsers!),
                            //   ],
                            // ),
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

class InstagramPostWidget extends StatefulWidget {
  final String username;
  final String postImageUrl;
  final List<User>? taggedUsernames;

  InstagramPostWidget({
    required this.username,
    required this.postImageUrl,
    this.taggedUsernames,
  });

  @override
  _InstagramPostWidgetState createState() => _InstagramPostWidgetState();
}

class _InstagramPostWidgetState extends State<InstagramPostWidget> {
  bool showTaggedUser = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              showTaggedUser = !showTaggedUser;
            });
          },
          child: Image.network(
            widget.postImageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200, // Adjust the height as needed
          ),
        ),
        if (showTaggedUser &&
            widget.taggedUsernames != null &&
            widget.taggedUsernames!.isNotEmpty)
          ..._buildTaggedUsernamesWidgets(widget.taggedUsernames!),
      ],
    );
  }

  List<Widget> _buildTaggedUsernamesWidgets(List<User> users) {
    final List<Widget> widgets = [];
    final random = Random();

    for (var user in users) {
      final position = Offset(
        random.nextDouble() * 100, // Adjust the position range as needed
        random.nextDouble() * 150, // Adjust the position range as needed
      );

      final taggedUsernameWidget = Positioned(
        left: position.dx,
        top: position.dy,
        child: InkWell(
          onTap: () {
            print("Tapped on username: ${user.username}");
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              user.username ?? 'No Username',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      widgets.add(taggedUsernameWidget);
    }
    return widgets;
  }
}


// class InstagramPostWidget extends StatelessWidget {
//   final String username;
//   final String postImageUrl;
//   final List<User>? taggedUsernames;

//   InstagramPostWidget({
//     required this.username,
//     required this.postImageUrl,
//     this.taggedUsernames,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool showTaggedUser = false;
//     return Stack(
//       children: [
//         InkWell(
//           onTap: () {
//             if (taggedUsernames != null && taggedUsernames!.isNotEmpty) {
//               _showTaggedUsernames(taggedUsernames!);
//             } else {
//               print("No tagged usernames found");
//             }
//           },
//           child: Image.network(
//             postImageUrl,
//             fit: BoxFit.cover,
//             width: double.infinity,
//             height: 200, // Adjust the height as needed
//           ),
//         ),
//         if (taggedUsernames != null && taggedUsernames!.isNotEmpty)
//           ..._buildTaggedUsernamesWidgets(taggedUsernames!),
//       ],
//     );
//   }

//   void _showTaggedUsernames(List<User> usernames) {
//     for (var user in usernames) {
//       print(user.username);
//     }
//   }

//   List<Widget> _buildTaggedUsernamesWidgets(List<User> users) {
//     final List<Widget> widgets = [];
//     final random = Random();

//     for (var user in users) {
//       final position = Offset(
//         random.nextDouble() * 200, // Adjust the position range as needed
//         random.nextDouble() * 250, // Adjust the position range as needed
//       );

//       final taggedUsernameWidget = Positioned(
//         left: position.dx,
//         top: position.dy,
//         child: InkWell(
//           onTap: () {
//             print("Tapped on username: ${user.username}");
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               user.username ?? 'No Username',
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       );
//       widgets.add(taggedUsernameWidget);
//     }
//     return widgets;
//   }
// }
