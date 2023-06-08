import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';

import '../controllers/email_config_controller.dart';

class EmailConfigView extends GetView<EmailConfigController> {
  EmailConfigView({Key? key}) : super(key: key);

  final emailConfigController = Get.put(EmailConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Email Configuration'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormWidget(
                  dropDown: false,
                  titleText: "E-mail",
                  textController: controller.emailController,
                ),
                TextFormWidget(
                  dropDown: false,
                  titleText: "Password",
                  textController: controller.passwordController,
                  obscureText: true,
                  maxLines: 1,
                ),
                TextFormWidget(
                  dropDown: false,
                  titleText: "Server",
                  textController: controller.serverController,
                ),
                TextFormWidget(
                  dropDown: false,
                  titleText: "Port",
                  textController: controller.portController,
                ),
                TextFormWidget(
                  dropDown: false,
                  titleText: "Receiving Email",
                  textController: controller.receiverMailController,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await controller.saveEmailDetails();
                    await controller.loginController.getEmailConfig();
                    await controller.getEmailDetails();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 2, 10),
                      backgroundColor: Colors.orange),
                  child: const Text("Save Setting"),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.sendTestMail();
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize:
                          Size(MediaQuery.of(context).size.width / 2, 10),
                      backgroundColor: Colors.orange),
                  child: const Text("Test Email"),
                )
              ],
            ),
          ),
        ));
  }
}
