import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/bcdi_classification_controller.dart';

class BcdiClassificationView extends GetView<BcdiClassificationController> {
   BcdiClassificationView({Key? key}) : super(key: key);
  final bcdiClassificationController = Get.put(BcdiClassificationController());
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("BCDI CLASSIFICATION"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Run No :- ",
                        style: TextStyle(fontSize: 25),
                      ),
                      TextFormField(
                        controller:controller.runNo,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 10),
                            constraints: BoxConstraints(
                              maxWidth: w / 4,
                              maxHeight: 30,
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            controller.savePdf(context);
                          },
                          child: const Icon(
                            Icons.download_sharp,
                            size: 35,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            controller.runNo.text = "";
                            controller.fileImage = null;
                            controller.classValue = "";
                            controller.confidence = "";
                            controller.statusCode.value = 0;
                          },
                          child: const Icon(Icons.delete, size: 35)),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(()=>
                 (controller.resizedFile.value == null)
                    ? Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  height: h / 3,
                  width: w,
                )
                    : ClipRRect(
                    child: Image.file(
                      controller.resizedFile.value!,
                      width: w,
                      fit: BoxFit.fill,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(
                    () => (controller.isLoading.value == true)
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            "Class :- ${controller.classValue ?? ""}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                          "Confidence :- ${controller.confidence ?? ""}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Obx(()=>
                           (controller.statusCode.value  == 200)
                              ? Container()
                              : Text(
                            "Status Code:- ${controller.statusCode.value}",
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ))
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Icon(
                        CupertinoIcons.photo,
                        size: 80,
                        color: Colors.black,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        controller.uploadImageFromCamera();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                      child: const Icon(
                        CupertinoIcons.camera,
                        size: 80,
                        color: Colors.black,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
