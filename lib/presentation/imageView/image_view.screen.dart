import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import 'controllers/image_view.controller.dart';

class ImageViewScreen extends GetView<ImageViewController> {
  const ImageViewScreen({Key? key, this.imageString, required this.isNetworkImage}) : super(key: key);
  final String? imageString;
  final bool isNetworkImage;
  @override
  Widget build(BuildContext context) {
     return isNetworkImage==true?PhotoView(imageProvider:NetworkImage(imageString!), ):PhotoView(imageProvider:FileImage(File(imageString!)));
  }
}
