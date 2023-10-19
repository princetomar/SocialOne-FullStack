import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/api/feed_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../constants.dart';
import '../../global_handler.dart';

class UploadImagePostScreen extends StatefulWidget {
  const UploadImagePostScreen({Key? key}) : super(key: key);

  @override
  State<UploadImagePostScreen> createState() => _UploadImagePostScreenState();
}

class _UploadImagePostScreenState extends State<UploadImagePostScreen> {
  File? _imageFile;
  final picker = ImagePicker();
  bool _isUploading = false;
  String? _uploadedImageUrl;

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
                height: size.height * 0.04,
              ),
              const Text(
                "Share moments with your friends!",
                style: TextStyle(
                  color: ColorConstants.lightWhiteColor,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
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
                          _isUploading
                              ? CircularProgressIndicator()
                              : (_imageFile != null
                                  ? Image.file(_imageFile!)
                                  : InkWell(
                                      onTap: () {
                                        _getImage();
                                      },
                                      child: Container(
                                        height: size.height * 0.3,
                                        width: size.height * 0.3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: ColorConstants.greyColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              CupertinoIcons.photo_camera,
                                              color: ColorConstants.yelloColor,
                                            ),
                                            Text(
                                              "UPLOAD",
                                              style: TextStyle(
                                                color:
                                                    ColorConstants.yelloColor,
                                                fontSize: 22,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_imageFile != null) {
                                  setState(() {
                                    _isUploading = true;
                                  });
                                  await _uploadImageToFirebase();
                                  setState(() {
                                    _isUploading = false;
                                  });
                                }
                              },
                              child: Text(
                                "Get Link",
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
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          SizedBox(
                            width: size.width * 0.4,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_uploadedImageUrl!.isNotEmpty) {
                                  FeedServices.createImagePost(
                                      _uploadedImageUrl!,
                                      "image",
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
                                ),
                              ),
                            ),
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
      ),
    );
  }

  Future<void> _uploadImageToFirebase() async {
    if (_imageFile == null) return;

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref =
        storage.ref().child("images/").child(DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_imageFile!);

    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();

    // Use the url variable to show the image in the app or perform any other operations.
    setState(() {
      _uploadedImageUrl = url;
    });
    print('Download URL: $url');
  }

  Future<void> _getImage() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } else {
      print('Permission denied');
    }
  }
}
