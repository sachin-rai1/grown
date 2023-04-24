import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:async/async.dart';
import 'package:pdf/widgets.dart' as pw;

import '../model_bcdi_detection.dart';

class BcdiDetectionController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  CroppedFile? croppedFile;
  TextEditingController? idTextController;
  TextEditingController? titleTextController;

  var classData = [].obs;
  var percentageData = [].obs;
  var imageString = "".obs;
  dynamic cleanConfidence;
  dynamic cleanClassValue;
  var isLoading = false.obs;
  var id = 0.obs;
  var classStatus = "".obs;

  Rx<File?> resizedFile = Rx<File?>(null);
  TextEditingController runNo = TextEditingController();

  Future<void> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _cropImage();
      }
    } on SocketException catch (e) {
      log(e.toString());
      classData.value = [];

      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "Please try after some time",
        title: "No Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 2000),
      ));
    }
  }

  Future<void> _cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.value!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    final bytes = await croppedFile?.readAsBytes();
    final resizedImage = img.decodeImage(bytes!);
    final resized = img.copyResize(resizedImage!, width: 512, height: 512);
    final tempDir = await getTemporaryDirectory();
    resizedFile.value = File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpeg')..writeAsBytesSync(img.encodeJpg(resized));

    upload(resizedFile.value!);

  }

  upload(File imageFile) async {
    try {
        isLoading.value = true;
        classData.value = [];
      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(resizedFile.value!.openRead()));
      var length = await resizedFile.value?.length();
      var uploadURL = "http://ec2-54-227-80-131.compute-1.amazonaws.com/predict";
      var uri = Uri.parse(uploadURL);
      var request = http.MultipartRequest("POST", uri);
      var multipartFile = http.MultipartFile('file', stream, length!,
          filename: (imageFile.path));
      request.files.add(multipartFile);
        var response = await http.Response.fromStream(await request.send());


      if (response.statusCode == 200) {
          var json = jsonDecode(response.body);

          var xyz = ModelBcdiDetection.fromJson(json);
          imageString.value = xyz.image!;
          classData.value = xyz.modelBcdiDetectionClass!;
          percentageData.value = xyz.percentage!;
        // });
      } else if (response.statusCode == 502) {
        Get.showSnackbar(const GetSnackBar(
          backgroundColor: Colors.red,
          message: "Please try after some time",
          title: "No Internet Connection",
          snackPosition: SnackPosition.TOP,
          duration: Duration(milliseconds: 2000),
        ));
      } else {
        Get.showSnackbar(
            GetSnackBar(
          backgroundColor: Colors.red,
          message: "Some Error occur",
          title: response.statusCode.toString(),
          snackPosition: SnackPosition.TOP,
          duration: const Duration(milliseconds: 2000),
        ));
          isLoading.value = false;
      }
    } finally {
        isLoading.value = false;
    }
  }

  savePdf(BuildContext context) async {
    if (resizedFile.value == null) {
      Get.showSnackbar(const GetSnackBar(
        message: "No Image Selected",
        title: "Select Image",
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1500),
      ));
    } else if (runNo.text == "") {
      Get.showSnackbar(const GetSnackBar(
        message: "Run Number Empty",
        title: "Enter Run No.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      var h = MediaQuery.of(context).size.height;
      final pdf = pw.Document();
      (classData == [])
          ? Get.showSnackbar(const GetSnackBar(
        message: "Please try again",
        title: "No data Found.",
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 1500),
      ))
          : pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              children: [
                pw.Text("Run No : ${runNo.text}",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.Image(
                  pw.MemoryImage(resizedFile.value!.readAsBytesSync()),
                  height: h /2,
                ),
                pw.ListView.builder(
                  itemCount: classData.length,
                  itemBuilder: (context, index) {
                    switch (classData[index].toString()) {
                      case "15":
                        classStatus.value = "CLEAN";
                        break;
                      case "16":
                        classStatus.value = "DOT ";
                        break;
                      case "17":
                        classStatus.value = "INCLUSION ";
                        break;
                      case "18":
                        classStatus.value = "BREAKAGE";
                        break;
                    }
                    return pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(8.0),
                            child: pw.Text(
                              "${classStatus.value} = >   ${percentageData[index].toString()} % ",
                              style: pw.TextStyle(
                                  fontSize: 20,
                                  fontWeight: pw.FontWeight.bold),
                            )),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      );

      pdf.addPage(pw.Page(
          build: (pw.Context context) => pw.Center(
              child: pw.Column(children: [
                pw.Image(
                  pw.MemoryImage(base64Decode(imageString.value)),
                  height: h / 1.5,
                ),
              ]))));
      Directory? directory;
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
      }
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
      final bytes = await pdf.save();
      File file = File(
          '${directory!.path}/bcdi_detection${DateTime.now().microsecondsSinceEpoch}.pdf');
      await file.writeAsBytes(bytes);

      Get.showSnackbar(const GetSnackBar(
        message: "File Save Successfully on Downloads Folder",
        title: "Saved",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 1500),
      ));
    }
  }

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickerImage = await picker.pickImage(source: ImageSource.gallery);

    log('image path : ${pickerImage?.path} -- MimeType : ${pickerImage?.mimeType}');

    image.value = File(pickerImage!.path);
    hasNetwork();
    Get.back();
  }

  Future<void> pickImageFromCamera() async {

    final ImagePicker picker = ImagePicker();
    final XFile? pickerImage = await picker.pickImage(source: ImageSource.camera);
    log('image path : ${pickerImage?.path} -- MimeType : ${pickerImage?.mimeType}');
      image.value = File(pickerImage!.path);
    hasNetwork();
  }
}
