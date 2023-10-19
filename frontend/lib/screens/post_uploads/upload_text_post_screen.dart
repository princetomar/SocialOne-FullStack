import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api/feed_services.dart';
import 'package:frontend/constants.dart';

import '../../global_handler.dart';

class UploadTextPostScreen extends StatefulWidget {
  const UploadTextPostScreen({super.key});

  @override
  State<UploadTextPostScreen> createState() => _UploadTextPostScreenState();
}

class _UploadTextPostScreenState extends State<UploadTextPostScreen> {
  TextEditingController postTextController = TextEditingController();

  late Future<Map<String, dynamic>> user;

  @override
  void initState() {
    // TODO: implement initState
    user = GlobalHandler.getUserData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    postTextController.dispose();
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
              height: size.height * 0.04,
            ),
            Container(
              height: size.height * 0.7,
              child: FutureBuilder<Map<String, dynamic>>(
                future: user,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final userData = snapshot.data;
                    print(userData);
                    return SingleChildScrollView(
                      child: Column(children: [
                        TextField(
                          controller: postTextController,
                          style: const TextStyle(
                            color: ColorConstants.lightWhiteColor,
                          ),
                          decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(29, 29, 29, 1),
                            filled: false,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorConstants.lightWhiteColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "What is happening?!",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: ColorConstants.greyColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (postTextController.text.isNotEmpty) {
                              FeedServices.createTextPost(
                                  postTextController.text,
                                  "text",
                                  userData!['_id'],
                                  userData['username'],
                                  context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Enter something first");
                            }
                          },
                          child: Text(
                            "Post",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ColorConstants.yelloColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ]),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
