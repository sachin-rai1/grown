import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:grown/app/modules/maintenance/assign_engineer/Model/ModelEngineers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../view_complain/Model/ModelComplainsView.dart';
import 'package:http/http.dart' as http;

class AssignEngineerController extends GetxController {
  var isLoading = false.obs;
  var complainsDataList = <Complain>[].obs;
  var engineerDataList = <Engineers>[].obs;
  var isCheckedList = [].obs;
  List<String> engineers = [];
  List<int> engineerIdList = [];
  List<String> engineerMails = [];

  var sendMail = MailSending();

  Future<void> sendEmail({required String msg}) async {

    var prefs = await SharedPreferences.getInstance();
    var receiverEmail = prefs.getString('receiver_email');
    var userEmail = prefs.getString("user_email");
    log(engineerMails.join(","));
    log(receiverEmail.toString());
    log(msg);

    sendMail.sendEmail(
        email: prefs.getString("sender_email")!,
        password: prefs.getString("email_pass")!,
        server: prefs.getString("server")!,
        port: prefs.getString("port")!,
        msg: msg,
        receipents: [receiverEmail.toString() , engineerMails.join(",")],

    );
  }


  @override
  void onInit() {
    super.onInit();
    getComplains().whenComplete(() => getEngineers());
  }

  Future<void> getComplains() async {
    try {
      isLoading.value = true;
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      var response =
          await http.get(Uri.parse("$apiUrl/unassigned_complain"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelViewComplain.fromJson(json);
        complainsDataList.value = data.complain ?? [];
      } else {
        log('failed');
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
      var response =
          await http.get(Uri.parse("$apiUrl/get_user_engineer"), headers: {
        'Authorization': 'Bearer $token',
        'Content-type': 'application/json',
      });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var data = ModelEngineers.fromJson(json);
        engineerDataList.value = data.data ?? [];
        isCheckedList.addAll(
            List<bool>.generate(engineerDataList.length, (index) => false));
      } else {
        log('failed');
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
          var ticket = ticketNo;
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
          await getComplains();

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

}
