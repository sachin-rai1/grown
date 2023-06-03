import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../controllers/feedback_controller.dart';

class FeedbackView extends GetView<FeedbackController> {
   FeedbackView({Key? key}) : super(key: key);
  final feedbackController = Get.put(FeedbackController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormWidget(
                textController: controller.subjectController,
                dropDown: false,
                titleText: 'Subject',
                ),
               TextFormWidget(
                textController: controller.feedbackController,
                dropDown: false,
                titleText: 'Feed Back',
                maxLines: 20,
                keyboardType: TextInputType.multiline,
                minLines: 5,),
              ElevatedButton.icon(onPressed: () async {
                final Email email = Email(
                  body: controller.feedbackController.text,
                  subject: controller.subjectController.text,
                  recipients: ["sachin.rai@trushnaexim.com" , "manthanshirudkar@trushnaexim.com"],
                  // cc: ['pradeep@maitri.nyc'],
                  // attachmentPaths: ['/path/to/attachment.zip'],
                  isHTML: false,
                );
                await FlutterEmailSender.send(email);
              },
                icon: const Icon(Icons.done_outlined),
                label: const Text("Submit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: Size(MediaQuery.of(context).size.width , 20)
                ),)

            ],
          ),
        ),
      ),
    );
  }
}
