import 'package:flutter/material.dart';

class Constants {
  static const String graphQlAPIURL =
      "http://localhost:2000/graphql"; // Use this url to fetch data
  static const String liveServerURL =
      "https://social-server-uguj.onrender.com"; // This is the live url of the server backend
}

class ColorConstants {
  static const blackColor = Color.fromRGBO(10, 10, 10, 1);
  static const yelloColor = Color.fromRGBO(230, 181, 96, 1);
  static const greyColor = Color.fromARGB(255, 86, 84, 84);
  static const lightWhiteColor = Color.fromARGB(255, 213, 206, 206);
}

class NavigationConstants {
  static nextScreen(BuildContext context, nextScreen) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => nextScreen));
  }

  static nextScreenReplacement(BuildContext context, nextScreen) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextScreen));
  }
}
