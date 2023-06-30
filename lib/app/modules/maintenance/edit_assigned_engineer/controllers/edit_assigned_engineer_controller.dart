import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/constants.dart';
import 'package:http/http.dart' as http;

import '../../assign_engineer/Model/model_engineers.dart';
import '../../engineer/model_engineer_problem.dart';

class EditAssignedEngineerController extends GetxController {
  var isLoading = false.obs;
  var engineerProblemDataList = <EngineersProblem>[].obs;
  List<String> engineers = [];
  var isCheckedList = [].obs;
  var status = 0.obs;
  List<String> newList = [];
  var engineerDataList = <Engineers>[].obs;
  List<int> engineerIdList = [];
  List<String> engineerMails = [];


  var sendMail = MailSending();

  Future<void> sendEmail({required String msg}) async {

    var prefs = await SharedPreferences.getInstance();
    var receiverEmail = prefs.getString('receiver_email');
    log(engineerMails.join(","));
    log(receiverEmail.toString());
    var senderEmail = prefs.getString("sender_email");
    log(msg);

    if(senderEmail != null) {
      sendMail.sendEmail(
        email:senderEmail,
        password: prefs.getString("email_pass")!,
        server: prefs.getString("server")!,
        port: prefs.getString("port")!,
        msg: msg,
        receipents: [receiverEmail.toString(), engineerMails.join(",")],
      );
    }
  }


  @override
  void onInit() {
    super.onInit();
    getData();

  }

  Future<void> getData() async {
    await getEngineers();
    if (privilage.value == "Maintenance Engineer") {
      await getEngineerComplainsByEngineer();
    } else {
      await getEngineerComplains();
    }
  }

 Future<void> getEngineerComplains() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      var response =
      await http.get(Uri.parse("$apiUrl/engineer_read/$branchId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineersProblems.fromJson(json);
        engineerProblemDataList.value = data.data ?? [];
      }
      else if(response.statusCode == 404) {
        engineerProblemDataList.value =  [];
      }
      else {
        log('failed ${response.body}');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEngineerComplainsByEngineer() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var userId = prefs.getInt("user_id");
      var response = await http.get(
          Uri.parse("$apiUrl/engineer_read?engineer_id=$userId"),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineersProblems.fromJson(json);
        engineerProblemDataList.value = data.data ?? [];
      } else if(response.statusCode == 404) {
        engineerProblemDataList.value =  [];
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getEngineers() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var branchId = prefs.getInt('user_branch_id');
      var response =
      await http.get(Uri.parse("$apiUrl/get_user_engineer/$branchId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineers.fromJson(json);
        engineerDataList.value = data.data ?? [];
        isCheckedList.addAll(List<bool>.generate(engineerDataList.length, (index) => false));
      }
      else if(response.statusCode == 404) {
        engineerProblemDataList.value =  [];
      }
      else {
        log('failed ${response.body}');
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void assignEngineer({required int complainId , required String ticketNo , required String machineNo , required String machineName}) async {
    if (engineers.join(",") == "") {
      showToastError(msg: "Please select an Engineer");

    } else {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      String url = "$apiUrl/assign_engineer/$complainId";

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['engineer_name'] = engineers.join(",");

      try {
        var response = await http.Response.fromStream(await request.send());
        if (response.statusCode == 200) {
          log('Engineer assigned successfully');
          for(int i=0; i<engineerIdList.length;i++){
            await engineerInsert(complainId: complainId, engineerId: engineerIdList[i]);
          }

          await sendEmail(msg: ""
              "New Complain Assigned \n"
              "Ticket No    : $ticketNo \n"
              "Machine No   : $machineNo \n"
              "Machine Name : $machineName",
          );
          Get.back();
          privilage.value == "Maintenance Engineer" ? getEngineerComplainsByEngineer() : getEngineerComplains();


        } else {
          log(response.body.toString());
          log('Error: ${response.statusCode}');
        }
      } catch (e) {
        log('Error: $e');
      }
    }
  }

  Future<void> engineerInsert({required int complainId,  required int engineerId}) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getInt('user_id');

    try
    {
      String url = "$apiUrl/engineer_insert";
      var response = await http.post(
          Uri.parse(url),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-type': 'application/json',
          },
          body: jsonEncode(<String,dynamic>{
            "user_id_fk":userId.toString(),
            "complain_id_fk":complainId.toString(),
            "engineer_id":engineerId.toString()
          })
      );

      if (response.statusCode == 200) {
        log('Engineer assigned successfully');
        log(response.statusCode.toString());
      } else {
        log(response.body.toString());
        log('Error: ${response.statusCode}');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> deleteEngineerComplain({required int uniqueId , required int complainId}) async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response = await http
          .delete(Uri.parse("$apiUrl/engineer_delete/$uniqueId/$complainId"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        showToast(msg: "Complain deleted Successfully");
        Get.back();
        privilage.value == "Maintenance Engineer" ? getEngineerComplainsByEngineer() : getEngineerComplains();
      } else {
        showToastError(msg: response.body);
        log(response.body.toString());
      }
    } catch (e) {
      log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
