import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grown/app/data/widgets.dart';
import 'package:grown/presentation/screens.dart';
import '../controllers/bcdi_multi_label_controller.dart';

class BcdiMultiLabelView extends GetView<BcdiMultiLabelController> {
  BcdiMultiLabelView({Key? key}) : super(key: key);
  final bcdiMultiLabelController = Get.put(BcdiMultiLabelController());


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
        title: Obx(()=> controller.isInDepthBcdi.value == true ?const Text("BCDI IN DEPTH"):const Text("BCDI DETECTION")),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(()=>
           (controller.isUpdating.value == true)?const Center(child: CircularProgressIndicator()): SingleChildScrollView(
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
                                borderRadius: BorderRadius.circular(10)),
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

                            controller.imageString.value = "";
                          },
                          child: const Icon(Icons.delete, size: 35),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                // Show the image after crop
                Obx(() => (controller.resizedFile.value == null
                    ? Container(
                        height: h / 3,
                        width: w,
                        color: Colors.grey.withOpacity(0.1))
                    : GestureDetector(
                        onTap: () {
                          Get.to(() => ImageViewScreen(
                              isNetworkImage: false,
                              imageString: controller.pickerImage?.path));
                        },
                        child: ClipRRect(
                            child: Image.file(controller.resizedFile.value!,
                                width: w, fit: BoxFit.fill))))),
                const SizedBox(
                  height: 10,
                ),

                // Display class data if available
                // Obx(() => (controller.isLoading.value == false
                //     ? (controller.classData.isNotEmpty)
                //         ? (controller.classData.isEmpty &&
                //                 controller.percentageData.isEmpty)
                //             ? const Text(
                //                 "As I am an ML model, I can detect only diamond images",
                //                 style: TextStyle(
                //                     fontSize: 20, fontWeight: FontWeight.bold),
                //               )
                //             : ListView.builder(
                //                 physics: const NeverScrollableScrollPhysics(),
                //                 shrinkWrap: true,
                //                 itemCount: controller.percentageData.length,
                //                 itemBuilder: (BuildContext context, index) {
                //                   for (List<DataList> dataList
                //                       in controller.dataLists) {
                //                     // Iterate through each DataList object in the inner list
                //                     for (DataList dataListItem in dataList) {
                //                       print(
                //                           "DataList Class: ${dataListItem.dataListClass}");
                //                       print("xamx: ${dataListItem.xmax}");
                //                       print("xmain: ${dataListItem.xmin}");
                //                       print("ymax: ${dataListItem.ymax}");
                //                       print("ymin: ${dataListItem.ymin}");
                //                       print("-----");
                //                     }
                //                   }
                //                   // switch (controller.classData[index].toString()) {
                //                   //   case "15":
                //                   //     controller.classStatus.value = "CLEAN";
                //                   //     break;
                //                   //   case "16":
                //                   //     controller.classStatus.value = "DOT ";
                //                   //     break;
                //                   //   case "17":
                //                   //     controller.classStatus.value = "INCLUSION ";
                //                   //     break;
                //                   //   case "18":
                //                   //     controller.classStatus.value = "BREAKAGE";
                //                   //     break;
                //                   // }
                //                   return controller.percentageData.isEmpty
                //                       ? Container()
                //                       : Column(
                //                           crossAxisAlignment:
                //                               CrossAxisAlignment.start,
                //                           children: [
                //                             Padding(
                //                               padding: const EdgeInsets.all(8.0),
                //                               child: Text(
                //                                 "${controller.classData[index]} => ${controller.percentageData[index].toString()}%",
                //                                 style: const TextStyle(
                //                                     fontSize: 20,
                //                                     fontWeight: FontWeight.bold),
                //                               ),
                //                             ),
                //                           ],
                //                         );
                //                 })
                //         : Container()
                //     : const Center(child: CircularProgressIndicator()))),

                const SizedBox(
                  height: 10,
                ),
                // Display the image if available
                Obx(
                  () => controller.isLoading.value == true ||
                          controller.imageString.value == ''
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            Get.to(() => ImageViewScreen(
                                isNetworkImage: true,
                                imageString: controller.imageString.value));
                          },
                          child: CachedNetworkImage(
                            imageUrl: controller.imageString.value,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                        value: downloadProgress.progress)),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                ),

                Obx(
                  () => (controller.classData.isEmpty)
                      ? Container()
                      : SizedBox(
                          height: h / 3,
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemCount: controller.classData.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${(index+1).toString()} : ",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          color: Colors.deepPurple,
                                          fontSize: 16),
                                    ),
                                    TextFormField(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800),
                                      controller: controller.textControllers[index],
                                      onChanged: (val){
                                        controller.indexDt[index]["class"] = controller.textControllers[index].text;
                                      },
                                      textAlign: TextAlign.center,
                                      // initialValue: controller.classData[index],
                                      decoration: InputDecoration(
                                        constraints:
                                            BoxConstraints(maxWidth: w * 0.15),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),

                Obx(() {
                  final percentageData = controller.percentageData.value;
                  if (percentageData == null) {
                    return  Container();
                  } else {
                    return Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Impurities", style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600)),
                            Text("Percentages ", style: TextStyle(fontSize: 18 , fontWeight: FontWeight.w600)),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: percentageData.length,
                          itemBuilder: (context, index) {
                            final key = percentageData.keys.elementAt(index);
                            final value = percentageData[key];
                            return MyTextWidget(title: key.toString(), body: "${value.toString()} %",);
                          },
                        ),
                      ],
                    );
                  }
                }),
                Obx(()=>
                   (controller.updateClass.value == false)?Container(): Center(
                    child: ElevatedButton(onPressed: (){
                      controller.updateImage(controller.resizedFile.value!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ), child: const Text("Update Class", style: TextStyle(color: Colors.white),),
                    ),
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
                const SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
