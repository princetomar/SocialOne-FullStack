import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:intl/intl.dart';

String convertToDateTime(String dateString) {
  DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  DateFormat outputFormat = DateFormat.yMMMMd('en_US').add_jm();
  DateTime dateTime = inputFormat.parse(dateString);
  String formattedDateTime = outputFormat.format(dateTime);
  return formattedDateTime;
}

String convertEpochToDateTime(int epochMilliseconds) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(epochMilliseconds);
  var formattedDateTime = DateFormat('MMM d, yyyy hh:mm a').format(dateTime);
  return formattedDateTime;
}

localDateTimeText(int dateTime) {
  String val = convertEpochToDateTime(dateTime);

  return Text(
    val,
    style: const TextStyle(
      color: ColorConstants.greyColor,
      fontSize: 14,
      fontWeight: FontWeight.w700,
    ),
  );
}
