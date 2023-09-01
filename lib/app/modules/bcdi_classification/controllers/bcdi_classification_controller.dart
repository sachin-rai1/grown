import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:pdf/widgets.dart' as pw;
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class BcdiClassificationController extends GetxController {
  File? fileImage;
  TextEditingController? idTextController;
  TextEditingController? titleTextController;
  dynamic data;
  var confidence = ''.obs;
  var classValue = ''.obs;
  var image = ''.obs;
  var isLoading = false.obs;

  var id = 0.obs;
  var statusCode = 0.obs;

  TextEditingController runNo = TextEditingController();
  dynamic croppedFile;
  Rx<File?> resizedFile = Rx<File?>(null);

  Future<void> hasNetwork() async {
    try {
      isLoading.value = true;

      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _cropImage();
      }
    } on SocketException catch (e) {
      log(e.toString());
      data = null;
      Get.showSnackbar(const GetSnackBar(
        backgroundColor: Colors.red,
        message: "Please try after some time",
        title: "No Internet Connection",
        snackPosition: SnackPosition.TOP,
        duration: Duration(milliseconds: 2000),
      ));
    }
    finally{
      isLoading.value = false;
    }
  }

  Future<void> _cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: fileImage!.path,
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



  Future<void> _cropWebImage(BuildContext context) async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: fileImage!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        WebUiSettings(context: context)
      ],
    );
    final bytes = await croppedFile?.readAsBytes();
    final resizedImage = img.decodeImage(bytes!);
    final resized = img.copyResize(resizedImage!, width: 512, height: 512);
    final tempDir = await getTemporaryDirectory();
    resizedFile.value = File('${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpeg')..writeAsBytesSync(img.encodeJpg(resized));

    upload(resizedFile.value!);
  }

  Future<void> uploadImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
        source: ImageSource.camera);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    fileImage = File(image!.path);
    hasNetwork();
  }

  Future<void> uploadImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
    fileImage = File(image!.path);
    hasNetwork();
  }

  // Future<void> uploadFromWebOrWindows(BuildContext context) async {
  //   const XTypeGroup typeGroup = XTypeGroup(
  //
  //     label: 'images',
  //     extensions: <String>['jpg', 'png', 'jpeg'],
  //   );
  //   final XFile? image = await openFile(acceptedTypeGroups: <XTypeGroup>[typeGroup]);
  //   log('image path : ${image?.path} -- MimeType : ${image?.mimeType}');
  //   fileImage = File(image!.path);
  //   upload(fileImage!);
  // }
  Future<void> uploadFromWebOrWindows(BuildContext context) async {

    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      if(kIsWeb) {
        File file = File(result.files.single.bytes.toString());
        log(file.toString());
      }
      else{
        resizedFile.value = File(result.files.single.path!);
        upload(resizedFile.value!);
      }

    } else {
      // User canceled the picker
    }
  }


  upload(File imageFile) async {
    try {
        isLoading.value = true;
        final bytes = await imageFile.readAsBytes();
        final resizedImage = img.decodeImage(bytes);
        final resized = img.copyResize(resizedImage!, width: 512, height: 512);
        final tempDir = await getTemporaryDirectory();
        final resizedFile = File('${tempDir.path}/resized.jpeg')..writeAsBytesSync(img.encodeJpg(resized));
        var uploadURL = "https://api.maitriai.com:8001/classification";
        // ignore: deprecated_member_use
        var stream = http.ByteStream(DelegatingStream.typed(resizedFile.openRead()));
        var length = await resizedFile.length();
        var uri = Uri.parse(uploadURL);
        var request = http.MultipartRequest("POST", uri);
        var multipartFile = http.MultipartFile('file', stream, length, filename: (imageFile.path));
        request.files.add(multipartFile);
        var response = await request.send();

      statusCode.value = response.statusCode;
      log(statusCode.value.toString());
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).transform(json.decoder).listen((value) {
          data = value;

            classValue.value = data["Class"].toString();
            image.value = data["image"];

        });
      } else {
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

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) => pw.Center(
            child: pw.Column(
              children: [
                pw.Text("Run No : ${runNo.text}",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.Image(
                  pw.MemoryImage(resizedFile.value!.readAsBytesSync()),
                  height: h / 1.5,
                ),
                pw.Text(
                  "Class :- ${classValue.value}",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Text(
                  "Confidence :- ${confidence.value}",
                  style: pw.TextStyle(
                      fontSize: 20, fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
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
          '${directory!.path}/bcdi_classification${DateTime.now().microsecondsSinceEpoch}.pdf');

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

}
