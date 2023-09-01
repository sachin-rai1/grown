import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bcdi_detection_controller.dart';

class BcdiDetectionView extends GetView<BcdiDetectionController> {
   BcdiDetectionView({Key? key}) : super(key: key);
  final bcdiDetectionController = Get.put(BcdiDetectionController());
  @override
  Widget build(BuildContext context) {
    // Get the height and width of the screen
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        // Add a leading icon button to navigate back
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.home_rounded, size: 30, color: Colors.black),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("BCDI DETECTION"),
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
                        controller: controller.runNo,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(left: 10),
                          constraints: BoxConstraints(
                            maxWidth: w / 4,
                            maxHeight: 35,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
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
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          controller.runNo.text = "";
                          controller.image.value = null;
                          controller.classData.value = [];
                          controller.percentageData.value = [];
                          controller.imageString.value = "";
                        },
                        child: const Icon(Icons.delete, size: 35),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10,),

              // Show the image after crop
              Obx(() => (
                  controller.resizedFile.value == null
                      ? Container(height: h / 3, width: w, color: Colors.grey.withOpacity(0.1)) :
                  ClipRRect(child: Image.file(controller.resizedFile.value!, width: w, fit: BoxFit.fill))

              )),
              const SizedBox(height: 10,),

              // Display class data if available
              Obx(() => (
                  controller.isLoading.value == false
                      ? (controller.classData.isNotEmpty)
                      ? (controller.classData.isEmpty && controller.percentageData.isEmpty)
                      ? const Text(
                    "As I am an ML model, I can detect only diamond images",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                      : ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.classData.length,
                      itemBuilder: (BuildContext context, index) {
                        switch (controller.classData[index].toString()) {
                          case "15":
                            controller.classStatus.value = "CLEAN";
                            break;
                          case "16":
                            controller.classStatus.value = "DOT ";
                            break;
                          case "17":
                            controller.classStatus.value = "INCLUSION ";
                            break;
                          case "18":
                            controller.classStatus.value = "BREAKAGE";
                            break;
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${controller.classStatus.value} => ${controller.percentageData[index].toString()}%",
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        );
                      }
                  )
                      : Container()
                      : const Center(child: CircularProgressIndicator())
              )),

              const SizedBox(height: 10,),

              // Display the image if available
              Obx(
                    ()=> controller.isLoading.value == true || controller.imageString.value == ''
                    ? Container()
                    : CachedNetworkImage(
                  imageUrl: controller.imageString.value,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      CircularProgressIndicator(value: downloadProgress.progress),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      controller.pickImageFromGallery();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Icon(
                      CupertinoIcons.photo,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.pickImageFromCamera();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                    child: const Icon(
                      CupertinoIcons.camera,
                      size: 80,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }

}
