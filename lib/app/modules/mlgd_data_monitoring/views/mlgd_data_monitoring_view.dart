import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../controllers/mlgd_data_monitoring_controller.dart';

class MlgdDataMonitoringView extends GetView<MlgdDataMonitoringController> {
  MlgdDataMonitoringView({Key? key}) : super(key: key);
  final mlgdDataMonitoringController = Get.put(MlgdDataMonitoringController());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue.withOpacity(0.5),
        title: const Text(
          "MLGD Data Monitoring Form",
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Obx(
            () => (controller.loading.value == true)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: controller.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MlgdTextFormWidget(
                              maxWidth: width / 1.8,
                              controller: controller.runNoController,
                              title: "Run No.",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter run No';
                                }
                                return null;
                              },
                            ),
                            MaterialButton(
                              onPressed: () {},
                              color: Colors.white,
                              shape: const CircleBorder(
                                eccentricity: 0.1,
                              ),
                              child: const Icon(
                                Icons.search,
                                color: Colors.green,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        MlgdTextFormWidget(
                          controller: controller.runningHoursController,
                          title: "Running Hour",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Running Hour';
                            }
                            return null;
                          },
                        ),
                        const Text("Holder Size"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "F :  ",
                              style: TextStyle(fontSize: 16),
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '3"',
                              value: '3"F',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '3.5"',
                              value: '3.5"F',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '4.25"',
                              value: '4.25"F',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "D : ",
                              style: TextStyle(fontSize: 16),
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '3"',
                              value: '3"D',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '3.5"',
                              value: '3.5"D',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                            MyRadioList(
                              width: width / 4,
                              title: '4.25" ',
                              value: '4.25"D',
                              groupValue: controller.size.value,
                              onChanged: (value) {
                                controller.size.value = value.toString();
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MlgdTextFormWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Total Pcs No';
                            }
                            return null;
                          },
                          controller: controller.totalPcsNoController,
                          title: "Total Pcs No.",
                        ),
                        MlgdTextFormWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Total Pcs Area (in Sq. mm)';
                              }
                              return null;
                            },
                            controller: controller.totalPcsAreaController,
                            title: "Total Pcs Area (in Sq. mm)"),
                        MlgdTextFormWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Big Pcs No.';
                              }
                              return null;
                            },
                            controller: controller.bigPcsNoController,
                            title: "Big Pcs No."),
                        MlgdTextFormWidget(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Regular Pcs Number';
                              }
                              return null;
                            },
                            controller: controller.regularPcsNumberController,
                            title: "Regular Pcs Number"),
                        MlgdTextFormWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Clean Pcs';
                            }
                            return null;
                          },
                          controller: controller.cleanPcsController,
                          title: "Clean Pcs",
                        ),
                        MlgdTextFormWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Breakage Pcs';
                            }
                            return null;
                          },
                          controller: controller.breakagePcsController,
                          title: "Breakage Pcs",
                        ),
                        MlgdTextFormWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Dot Pcs';
                            }
                            return null;
                          },
                          controller: controller.dotPcsController,
                          title: "Dot Pcs",
                        ),
                        MlgdTextFormWidget(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Inclusion Pcs';
                            }
                            return null;
                          },
                          controller: controller.inclusionPcsController,
                          title: "Inclusion Pcs",
                          // onChanged: (xyz) {
                          //   checkSum();
                          // },
                        ),
                        MlgdTextFormWidget(
                          controller: controller.xController,
                          title: "X",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter X';
                            }
                            return null;
                          },
                        ),
                        MlgdTextFormWidget(
                          controller: controller.yController,
                          title: "Y",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Y';
                            }
                            return null;
                          },
                        ),
                        MlgdTextFormWidget(
                          controller: controller.zController,
                          title: "Z",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Z';
                            }
                            return null;
                          },
                        ),
                        MlgdTextFormWidget(
                          controller: controller.tController,
                          title: "T",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter T';
                            }
                            return null;
                          },
                        ),
                        MlgdTextFormWidget(
                          keyboardType: TextInputType.text,
                          controller: controller.operatorNameController,
                          title: "Operator Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Operator Name';
                            }
                            return null;
                          },
                        ),
                        const Text("Front View Photo",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.black45,
                                      )),
                                  backgroundColor: Colors.white,
                                ),
                                label: const Text(
                                  "Add File \nFrom Camera",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  controller.uploadFrontPhotoFromCamera();
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.blue,
                                )),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.black45,
                                      )),
                                  backgroundColor: Colors.white,
                                ),
                                label: const Text(
                                  "Add File \nFrom Gallery",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  controller.uploadFrontPhotoFromGallery();
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                        Obx(
                          () => (controller.resizedFrontImageFile.value == null)
                              ? Container()
                              : Center(
                                  child: Image.file(
                                    File(controller
                                        .resizedFrontImageFile.value!.path),
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Top View Photo",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.black45,
                                      )),
                                  backgroundColor: Colors.white,
                                ),
                                label: const Text(
                                  "Add File \nFrom Camera",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  controller.uploadTopPhotoFromCamera();
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.blue,
                                )),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        color: Colors.black45,
                                      )),
                                  backgroundColor: Colors.white,
                                ),
                                label: const Text(
                                  "Add File \nFrom Gallery",
                                  style: TextStyle(color: Colors.blue),
                                ),
                                onPressed: () {
                                  controller.uploadTopPhotoFromGallery();
                                },
                                icon: const Icon(
                                  Icons.cloud_upload_outlined,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                        Obx(
                          () => (controller.resizedTopImageFile.value == null)
                              ? Container()
                              : Center(
                                  child: Image.file(
                                    File(controller
                                        .resizedTopImageFile.value!.path),
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  controller.checkSum();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade600,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("Submit"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                getPass(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple.shade600,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text("View data"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  void getPass(BuildContext context) {
    bool isObscure = true;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.all(10),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: controller.passController,
            obscureText: isObscure,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                suffixIcon: InkWell(
                    onTap: () {
                      isObscure = !isObscure;
                    },
                    child: (isObscure == false)
                        ? const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          )
                        : const Icon(
                            CupertinoIcons.eye_slash,
                            color: Colors.black,
                          )),
                constraints: const BoxConstraints(maxHeight: 40),
                contentPadding: const EdgeInsets.only(left: 10),
                hintText: "Enter Password",
                hintStyle: const TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.black)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(15))),
            onPressed: () {
              login();
            },
            label: const Text("login"),
            icon: const Icon(Icons.login),
          ),
        ],
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void login() {
    if (controller.passController.text == "M@!Tr!") {
      Get.to(() => const MyTabBar());
      controller.passController.clear();
    } else if (controller.passController.text == "") {
      Get.showSnackbar(const GetSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Enter password",
        message: "password should not empty",
        duration: Duration(milliseconds: 1500),
      ));
    } else {
      Get.showSnackbar(const GetSnackBar(
        snackPosition: SnackPosition.TOP,
        title: "Invalid Credential",
        message: "Incorrect Password",
        duration: Duration(milliseconds: 1500),
      ));
    }
  }
}
