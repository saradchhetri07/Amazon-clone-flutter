import 'dart:convert';

import 'package:amazon_clone/constant/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {int? index,
    required http.Response response,
    required BuildContext context,
    required VoidCallback onSucess}) {
  switch (response.statusCode) {
    case 200:
      onSucess();
      break;
    case 400:
      showsnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showsnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showsnackBar(context, jsonDecode(response.body));
  }
}
