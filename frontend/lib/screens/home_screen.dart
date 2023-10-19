import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:frontend/models/user_story_model.dart';
import 'package:frontend/screens/post_uploads/upload_image_post_screen.dart';
import 'package:frontend/screens/post_uploads/upload_text_post_screen.dart';

import '../widgets/posts_feed_widget_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<UserStoryModel>> loadUsersData() async {
    var usersData = await rootBundle.loadString('assets/users.json');
    var users = List<UserStoryModel>.from(
        json.decode(usersData).map((x) => UserStoryModel.fromJson(x)));
    return users;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // FUNCTION TO SHOW A DIALOG TO UPLOAD A POST
    void openPostUploadDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: ColorConstants.blackColor,
            title: Text(
              'Select Post Type'.toUpperCase(),
              style: const TextStyle(
                color: ColorConstants.greyColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      NavigationConstants.nextScreen(
                          context, UploadTextPostScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.yelloColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.text_quote,
                            color: ColorConstants.yelloColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Text Post',
                            style: TextStyle(
                              color: ColorConstants.yelloColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      NavigationConstants.nextScreen(
                          context, UploadImagePostScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorConstants.yelloColor,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.photo,
                            color: ColorConstants.yelloColor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Image Post',
                            style: TextStyle(
                              color: ColorConstants.yelloColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      floatingActionButton: FloatingActionButton(
        onPressed: openPostUploadDialog,
        child: Icon(
          CupertinoIcons.add,
        ),
        backgroundColor: ColorConstants.yelloColor,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.07, horizontal: size.width * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              height: size.height * 0.15,
              width: size.width * 0.8,
              child: FutureBuilder(
                future: loadUsersData(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<UserStoryModel>> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 100.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var user = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Column(
                              children: [
                                CircleAvatar(
                                  radius: size.height * 0.035,
                                  backgroundColor: user.storyuploaded == true
                                      ? (user.storyviewed == false
                                          ? Colors.purple
                                          : ColorConstants.greyColor)
                                      : Colors.transparent,
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(user.profilepic!),
                                    radius: size.height * 0.033,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Container(
                                  width: size.width * 0.15,
                                  child: Text(
                                    user.name!,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: ColorConstants.lightWhiteColor,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(
              height: 1,
              child: Drawer(
                backgroundColor: ColorConstants.greyColor,
                width: size.width * 0.8,
              ),
            ),
            Container(
              height: size.height * 0.58,
              width: size.width * 0.8,
              child: FeedWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
