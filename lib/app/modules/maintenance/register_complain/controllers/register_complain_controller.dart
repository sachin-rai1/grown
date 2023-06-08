import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/constants.dart';
import '../Model/ModelProblems.dart';

class RegisterComplainController extends GetxController {

  final ticketNoController = TextEditingController();
  final machineNameController = TextEditingController();
  final machineNoController = TextEditingController();
  final descriptionController = TextEditingController();
  var isCheckedList = [].obs;
  final problemsDataList = <ProblemsData>[].obs;
  var isLoading = false.obs;
  List<String> problem = [];
  List<File> images = [];
  var digits = "".obs;
  var currentNumber = 0.obs;
  var ticketNo = "".obs;
  var sendMail = MailSending();

  Future<void> sendEmail({required String msg}) async {
    var prefs = await SharedPreferences.getInstance();
    var receiverEmail = prefs.getString('receiver_email');
    var userEmail = prefs.getString("user_email");

    log(userEmail.toString());
    log(receiverEmail.toString());
    log(msg);

    sendMail.sendEmail(
        email: prefs.getString("sender_email")!,
        password: prefs.getString("email_pass")!,
        server: prefs.getString("server")!,
        port: prefs.getString("port")!,
        receipents: [receiverEmail.toString(), userEmail.toString()],
        msg: msg);
  }

  @override
  void onInit() {
    super.onInit();
    getProblems();
    getComplainNo().whenComplete(() => ticketNo.value =
        "${branchName.value}-${digits.value}${currentNumber.value}");
  }

  getImages() {
    images = [];
    for (int i = 0; i < selectedImages.length; i++) {
      images.add(File(selectedImages[i].path));
    }
  }

  List<XFile> selectedImages = <XFile>[].obs;
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromCamera() async {
    if (selectedImages.length >= 5) {
      showToastError(msg: "Only 5 images are allowed");
    } else {
      XFile? image =
          await _picker.pickImage(source: ImageSource.camera, imageQuality: 60);
      if (image != null) {
        selectedImages.add(image);
      }
    }
  }

  Future<void> pickMyMultiImage() async {
    List<XFile> image = await _picker.pickMultiImage(imageQuality: 60);
    selectedImages.addAll(image);

    if (selectedImages.length > 5) {
      showToastError(msg: "Only 5 images are allowed");
      selectedImages.removeLast();
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void showImageDialog(BuildContext context) {
    for (int i = 0; i < selectedImages.length; i++) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Image.file(File(selectedImages[i].path)),
          );
        },
      );
    }
  }

  Future<void> getComplainNo() async {
    var number = 0.obs;
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response =
          await http.get(Uri.parse("$apiUrl/last_complain_id_read"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        number.value = json['data'][0]['Last_complain_id'];
      } else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
    var myNum = number + 1;
    currentNumber.value = myNum.value;
    if (currentNumber.value.toString().length == 1) {
      digits.value = "000000";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    } else if (currentNumber.value.toString().length == 2) {
      digits.value = "00000";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    } else if (currentNumber.value.toString().length == 3) {
      digits.value = "0000";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    } else if (currentNumber.value.toString().length == 4) {
      digits.value = "000";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    } else if (currentNumber.value.toString().length == 5) {
      digits.value = "00";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    } else if (currentNumber.value.toString().length == 6) {
      digits.value = "0";
      ticketNo.value =
          "${branchName.value}-${digits.value}${currentNumber.value}";
    }
  }



  Future<void> insertData() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt('user_id');
      var complainNo = "${branchName.value}-${digits.value}${currentNumber.value}";

      String url = "$apiUrl/complain_tb_insert";

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Set form fields
      request.fields['complainer_id_fk'] = userId.toString();
      request.fields['branch_id'] = branchId.value.toString();
      request.fields['Machine_no'] = machineNoController.text;
      request.fields['Machine_name'] = machineNameController.text;
      request.fields['problems'] = problem.join(",");
      request.fields['problem_description'] = descriptionController.text;
      request.fields['Ticket_no'] = ticketNo.value;

      await getImages();

      if (images.isEmpty) {
        log("No Images Found");
      } else {
        for (var image in images) {
          var compressedImage = await compressImage(image);
          var stream = http.ByteStream(compressedImage.openRead());
          var length = await compressedImage.length();
          var multipartFile = http.MultipartFile(
            'images',
            stream,
            length,
            filename: compressedImage.path,
          );
          request.files.add(multipartFile);
        }

        try {
          var response = await http.Response.fromStream(await request.send());
          if (response.statusCode == 200) {
            log('Data inserted successfully');
            showToast(msg: "Complain Register Successfully");

            await sendEmail(
              msg: ""
                  "New Ticket has been Generated \n"
                  "Ticket No : $complainNo \n"
                  "Machine No : ${machineNoController.text} \n"
                  "Machine Name : ${machineNameController.text} \n"
                  "Problems : ${problem.join(",")} \n"
                  "Problem Description : ${descriptionController.text}",
            );

            await clearData();
          } else {
            showToastError(msg: response.body);
          }
        } catch (e) {
          log('Error: $e');
          showToastError(msg: e.toString());
        }
      }
    } catch (e) {
      log(e.toString());
      showToastError(msg: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<File> compressImage(File image) async {
    final dir = await getTemporaryDirectory();
    final targetPath = "${dir.absolute.path}/${DateTime.now().millisecondsSinceEpoch}.jpg";
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      image.path,
      targetPath,
      quality: 50,
      minWidth: 500,
      minHeight: 500,
    );
    return File(compressedImage!.path) ?? File(image.path);
  }

  void getProblems() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http
          .get(Uri.parse("$apiUrl/pre_defined_problem_read"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);

        var data = ModelProblems.fromJson(json);
        problemsDataList.value = data.data ?? [];
        isCheckedList.addAll(List<bool>.generate(problemsDataList.length, (index) => false));
      } else {
        log('failed');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }



  Future<void> clearData() async {
    await getComplainNo();
    ticketNoController.clear();
    machineNameController.clear();
    machineNoController.clear();
    descriptionController.clear();
    selectedImages.clear();
  }
}
