import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/constants.dart';
import 'package:grown/app/modules/bcdi_multi_label/Model/model_bcdi_multilabel.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'package:pdf/widgets.dart' as pw;

class BcdiMultiLabelController extends GetxController {
  Rx<File?> image = Rx<File?>(null);
  CroppedFile? croppedFile;
  TextEditingController? idTextController;
  TextEditingController? titleTextController;
  var classData = [].obs; // Observable list for storing class data
  var imageString = "".obs;
  dynamic cleanConfidence;
  dynamic cleanClassValue;
  var isLoading = false.obs;
  var id = 0.obs; // Observable ID value (not used in the provided code)
  var classStatus = "".obs; // Observable string for storing class status
  Rx<Map<String, dynamic>?> percentageData = Rx<Map<String, dynamic>?>(null);
  Rx<File?> resizedFile = Rx<File?>(null);
  TextEditingController runNo = TextEditingController();
  XFile? pickerImage;
  List<TextEditingController> textControllers = [];
  var indexDt = [];
  var isUpdating = false.obs;
  var updateClass = false.obs;
  var isInDepthBcdi = true.obs;

  @override
  void onInit(){
    var argumentData =  Get.arguments;
    isInDepthBcdi.value = argumentData['isInDepth'];
    super.onInit();
  }

// Function for checking internet connectivity
  Future<void> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!kIsWeb) {
          if (Platform.isIOS || Platform.isAndroid) {
            _cropImage(); // Crop the image if on a web platform
          }
        }
      }
    } on SocketException catch (e) {
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

// Function for cropping the image
  Future<void> _cropImage() async {
    croppedFile = await ImageCropper().cropImage(
      sourcePath: image.value!.path, // Path of the original image
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

    final bytes =
        await croppedFile?.readAsBytes(); // Read the cropped image as bytes
    final resizedImage = img.decodeImage(bytes!); // Decode the image bytes
    final resized = img.copyResize(resizedImage!,
        width: 512, height: 512); // Resize the image
    final tempDir = await getTemporaryDirectory();
    resizedFile.value = File(
        '${tempDir.path}/resized${DateTime.now().microsecondsSinceEpoch}.jpeg')
      ..writeAsBytesSync(img.encodeJpg(resized));

    upload(resizedFile.value!); // Upload the resized image
  }

// Function for uploading the image file
  upload(File imageFile) async {
    try {
      var h = Get.mediaQuery.size.height / 2;
      var w = Get.mediaQuery.size.width;
      textControllers.clear();
      isLoading.value = true; // Set loading state to true
      // classData.value = []; // Clear the class data list

      final bytes = await imageFile.readAsBytes();
      final resizedImage = img.decodeImage(bytes);
      final resized = img.copyResize(resizedImage!,
          width: int.parse(w.ceil().toString()),
          height: int.parse(h.ceil().toString()));
      final tempDir = await getTemporaryDirectory();

      final resizedFile = File('${tempDir.path}/resized.jpeg')
        ..writeAsBytesSync(img.encodeJpg(resized));

      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(resizedFile.openRead()));
      var length = await resizedFile.length();

      var uploadURL =isInDepthBcdi.value == true?
        "https://api.maitriai.com:8003/api/predict":
        "https://api.maitriai.com:8001/api/predict"; // URL for uploading the image
      var uri = Uri.parse(uploadURL);
      var request =
          http.MultipartRequest("POST", uri); // Create a multipart request
      var multipartFile = http.MultipartFile('file', stream, length,
          filename: (imageFile.path)); // Create a multipart file from the image stream
      request.files.add(multipartFile); // Add the multipart file to the request
      var response = await http.Response.fromStream(
          await request.send()); // Send the request and get the response
      if (response.statusCode == 200) {
        try {

          var json = jsonDecode(response.body);
          var data = ModelBcdiMultiLabel.fromJson(json);
          imageString.value = data.data!.image!;
          classData.value = data.data?.indexDt! ?? [];

          percentageData.value = json["data"]["Percentage"];
          percentageData.value?.forEach((key, value) {});

          indexDt = json["data"]["index_dt"];

          var sortedEntries = percentageData.value?.entries.toList()?..sort((a, b) => b.value.compareTo(a.value));
          Map<String, double> sortedData = {};
          sortedEntries?.forEach((entry) {
            sortedData[entry.key] = entry.value;
          });
          percentageData.value = sortedData;
          for (int i = 0; i < classData.length; i++) {
            textControllers
                .add(TextEditingController(text:data.data!.indexDt?[i].indexDtClass.toString()));
          }
          updateClass.value = true;
        } catch (e) {
          log(e.toString());
        }
      } else {
        showToastError(msg: "Unknown Error Occur ${response.statusCode}");
      }
    } finally {
      isLoading.value = false; // Set loading state to false
    }
  }
  // Function for uploading the image file
  updateImage(File imageFile) async {
    try {
      var h = Get.mediaQuery.size.height / 2;
      var w = Get.mediaQuery.size.width;
      textControllers.clear();
      isUpdating.value = true; // Set loading state to true
      final bytes = await imageFile.readAsBytes();
      final resizedImage = img.decodeImage(bytes);
      final resized = img.copyResize(resizedImage!,
          width: int.parse(w.ceil().toString()),
          height: int.parse(h.ceil().toString()));
      final tempDir = await getTemporaryDirectory();

      final resizedFile = File('${tempDir.path}/resized.jpeg')
        ..writeAsBytesSync(img.encodeJpg(resized));

      // ignore: deprecated_member_use
      var stream = http.ByteStream(DelegatingStream.typed(resizedFile.openRead()));
      var length = await resizedFile.length();
      var uploadURL = "https://api.maitriai.com:8003/api/update_class"; // URL for uploading the image
      var uri = Uri.parse(uploadURL);
      var request =
      http.MultipartRequest("POST", uri); // Create a multipart request
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: (imageFile.path)); // Create a multipart file from the image stream
      request.headers['Content-Type'] = 'multipart/form-data';
      request.files.add(multipartFile); // Add the multipart file to the request

      request.fields['index_dt'] =jsonEncode(indexDt);
      var response = await http.Response.fromStream(await request.send()); // Send the request and get the response

      if (response.statusCode == 200) {
        try {
          var json = jsonDecode(response.body);
          var data = ModelBcdiMultiLabel.fromJson(json);
          imageString.value = data.data!.image!;
          classData.value = data.data?.indexDt! ?? [];

          percentageData.value = json["data"]["Percentage"];
          percentageData.value?.forEach((key, value) {});
          indexDt = json["data"]["index_dt"];
          var sortedEntries = percentageData.value?.entries.toList()?..sort((a, b) => b.value.compareTo(a.value));
          Map<String, double> sortedData = {};
          sortedEntries?.forEach((entry) {
            sortedData[entry.key] = entry.value;
          });
          percentageData.value = sortedData;
          for (int i = 0; i < classData.length; i++) {
            textControllers
                .add(TextEditingController(text:data.data!.indexDt?[i].indexDtClass.toString()));
          }
        } catch (e) {
          log(e.toString());
        }
      } else {
        showToastError(msg: "Unknown Error Occur ${response.body}");
      }
    } finally {
      isUpdating.value = false; // Set loading state to false
    }
  }

// Function for saving the data as a PDF
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
      var h =
          MediaQuery.of(context).size.height; // Get the device screen height
      final pdf = pw.Document(); // Create a PDF document
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
                        height: h / 2,
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
                              // pw.Padding(
                              //     padding: const pw.EdgeInsets.all(8.0),
                              //     child: pw.Text(
                              //       "${classStatus.value} = >   ${percentageData[index].toString()} % ",
                              //       style: pw.TextStyle(
                              //           fontSize: 20,
                              //           fontWeight: pw.FontWeight.bold),
                              //     )),
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
      File file = File('${directory!.path}/bcdi_detection${DateTime.now().microsecondsSinceEpoch}.pdf');
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

// Function for picking an image from the gallery
  Future<void> pickImageFromGallery() async {
    if (!kIsWeb) {
      if (Platform.isWindows) {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          resizedFile.value = File(result.files.single.path!);
          upload(resizedFile.value!);
        } else {}
      } else {
        final ImagePicker picker = ImagePicker();
        pickerImage = await picker.pickImage(source: ImageSource.gallery);

        log('image path : ${pickerImage?.path}');
        image.value = File(pickerImage!.path);

        if (!kIsWeb) {
          if (Platform.isAndroid || Platform.isIOS) {
            hasNetwork(); // Check for network connection and crop the image
          }
        }
      }
    }
  }

// Function for picking an image from the camera
  Future<void> pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickerImage =
        await picker.pickImage(source: ImageSource.camera);
    log('image path : ${pickerImage?.path} -- MimeType : ${pickerImage?.mimeType}');
    image.value = File(pickerImage!.path);
    hasNetwork(); // Check for network connection and crop the image
  }
}
