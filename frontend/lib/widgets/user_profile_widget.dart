import 'package:flutter/material.dart';

import '../constants.dart';
import 'dateTime_text.dart';

class UserProfileWidget extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserProfileWidget({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      'Posts',
                      style: TextStyle(
                        color: ColorConstants.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      userData['posts'].length.toString(),
                      style: const TextStyle(
                        color: ColorConstants.yelloColor,
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
                        color: ColorConstants.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      userData['followers'].length.toString(),
                      style: const TextStyle(
                        color: ColorConstants.yelloColor,
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
                        color: ColorConstants.greyColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      userData['following'].length.toString(),
                      style: const TextStyle(
                        color: ColorConstants.yelloColor,
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
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userData['posts'].length,
                itemBuilder: (context, index) {
                  final cPost = userData['posts'][index];
                  return Card(
                    color: ColorConstants.blackColor,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        cPost['type'] == "text"
                            ? Container(
                                width: size.width * 0.9,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstants.greyColor),
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorConstants.lightWhiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "@" + cPost['username'],
                                                  style: const TextStyle(
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                localDateTimeText(int.parse(
                                                    cPost['createdAt'])),
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
                                      cPost['body'],
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
                                width: size.width,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorConstants.greyColor),
                                  borderRadius: BorderRadius.circular(12),
                                  color: ColorConstants.lightWhiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 25,
                                              backgroundImage: NetworkImage(
                                                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60",
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "@" + cPost['username'],
                                                  style: const TextStyle(
                                                    color: ColorConstants
                                                        .blackColor,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                localDateTimeText(int.parse(
                                                    cPost['createdAt'])),
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
                                        cPost['body'],
                                        fit: BoxFit.fitHeight,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Icon(Icons.error);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        Text(
                            'Created At: ${DateTime.fromMillisecondsSinceEpoch(int.parse(userData['posts'][index]['createdAt'])).toLocal()}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
