import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';

void showsnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

Future<List<File>> pickImages() async {
  List<File> files = [];
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      files = result.paths.map((path) => File(path!)).toList();
    }
  } catch (error) {
    debugPrint(error.toString());
  }
  return files;
}

Widget getspinkit() {
  return SpinKitRotatingCircle(
    color: Colors.white,
    size: 50.0,
  );
}
