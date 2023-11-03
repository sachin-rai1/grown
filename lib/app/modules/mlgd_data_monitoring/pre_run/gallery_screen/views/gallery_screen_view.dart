import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gallery_screen_controller.dart';


class GalleryScreenView extends GetView<GalleryScreenController> {
  const GalleryScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GalleryScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GalleryScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
