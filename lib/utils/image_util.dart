import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart' hide Response;
import '../models/args/args_images_viewer.dart';
import '../navigation/app_routes.dart';
import 'package:dio/dio.dart' as form;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {

  static Future<List<XFile>?> pickImage({bool isCover = false, int selectionCount = 1}) async {
    final ImagePicker picker = ImagePicker();

    if (selectionCount == 1) {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
      );
      return image != null ? [image] : null;
    } else {
      final List<XFile> images = await picker.pickMultiImage();
      return images;
    }
  }

  static void viewImage(String? imgUrl) {
    if (imgUrl == null) return;
    Get.toNamed(Routes.imageViewer,
        arguments: ArgsImagesViewer(images: [imgUrl]));
  }

  static void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
          content: Text(message,
              style: Get.textTheme.displayLarge
                  ?.copyWith(fontSize: 18, color: Colors.white)),
          backgroundColor: color),
    );
  }

  static Future<form.FormData> convertToMultiPart({required String filePath, required String keyName}) async {
    Map<String, File> image = {keyName: File(filePath)};

    Map<String, form.MultipartFile> fileMap = {};
    for (MapEntry fileEntry in image.entries) {
      File file = fileEntry.value;
      String fileName = basename(file.path);
      // ignore: deprecated_member_use
      fileMap[fileEntry.key] = form.MultipartFile(
        file.openRead(),
        await file.length(),
        filename: fileName,
      );
    }
    Map<String, dynamic> data = fileMap;

    form.FormData formData = form.FormData.fromMap(data);

    return formData;
  }

  static Future<Uint8List> loadImageFromAssets(String path)async{
    final byteData = await rootBundle.load(path);
    return byteData.buffer.asUint8List();
  }
}
