import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/widgets.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return
       Responsive(
         mediumScreen: Scaffold(
           backgroundColor: Colors.white,
           body: Obx(
                 () => (controller.isLoading.value == true)
                 ? const Center(child: CircularProgressIndicator())
                 : Padding(
               padding: EdgeInsets.symmetric(horizontal: w* 0.20 , vertical:h * 0.05),
               child: Card(
                 elevation: 2,
                 color: Colors.indigo,
                 child: Padding(
                   padding: const EdgeInsets.all(20),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Image(
                           image: const AssetImage("assets/images/grown.png"),
                           height: w / 5),
                       const SizedBox(
                         height: 50,
                       ),
                       Column(
                         children: [
                           TextFormField(
                             controller: controller.userName,
                             style: const TextStyle(color: Colors.white),
                             decoration: InputDecoration(
                                 hintText: "User Name",
                                 hintStyle: const TextStyle(color: Colors.white),
                                 enabledBorder: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(15),
                                     borderSide:
                                     const BorderSide(color: Colors.white)),
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(10),
                                 )),
                           ),
                           const SizedBox(
                             height: 30,
                           ),
                           Obx(
                                 () => TextFormField(
                               controller: controller.password,
                               style: const TextStyle(color: Colors.white),
                               obscureText: controller.isObscure.value,
                               decoration: InputDecoration(
                                   hintText: "Password",
                                   suffixIcon: InkWell(
                                       onTap: () {
                                         controller.isObscure.value =
                                         !controller.isObscure.value;
                                       },
                                       child: (controller.isObscure.value == false)
                                           ? const Icon(
                                         Icons.remove_red_eye,
                                         color: Colors.white,
                                       )
                                           : const Icon(
                                         CupertinoIcons.eye_slash,
                                         color: Colors.white,
                                       )),
                                   hintStyle: const TextStyle(color: Colors.white),
                                   enabledBorder: OutlineInputBorder(
                                       borderRadius: BorderRadius.circular(15),
                                       borderSide:
                                       const BorderSide(color: Colors.white)),
                                   border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(10),
                                   )),
                             ),
                           ),
                           const SizedBox(
                             height: 20,
                           ),
                           SizedBox(
                               width: w / 2,
                               child: ElevatedButton(
                                 onPressed: () {
                                   controller.login();
                                 },
                                 style: ElevatedButton.styleFrom(
                                     backgroundColor: Colors.transparent,
                                     fixedSize: Size(w, 45),
                                     shape: RoundedRectangleBorder(
                                         side: const BorderSide(color: Colors.white),
                                         borderRadius: BorderRadius.circular(15))),
                                 child: const Text("Login" , style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w800),),
                               )),
                         ],
                       ),
                     ],
                   ),
                 ),
               ),
             ),
           ),
         ),
         bigScreen: Scaffold(
          backgroundColor: Colors.white,
          body: Obx(
                () => (controller.isLoading.value == true)
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                  padding: EdgeInsets.symmetric(horizontal: w* 0.35 , vertical:h * 0.05),
                  child: Card(
                    elevation: 2,
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image: const AssetImage("assets/images/grown.png"),
                              height: w / 5),
                          const SizedBox(
                            height: 50,
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: controller.userName,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(

                                      hintText: "User Name",
                                      hintStyle: const TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(15),
                                          borderSide:
                                          const BorderSide(color: Colors.white)),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Obx(
                                      () => TextFormField(
                                    controller: controller.password,
                                    style: const TextStyle(color: Colors.white),
                                    obscureText: controller.isObscure.value,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        suffixIcon: InkWell(
                                            onTap: () {
                                              controller.isObscure.value =
                                              !controller.isObscure.value;
                                            },
                                            child: (controller.isObscure.value == false)
                                                ? const Icon(
                                              Icons.remove_red_eye,
                                              color: Colors.white,
                                            )
                                                : const Icon(
                                              CupertinoIcons.eye_slash,
                                              color: Colors.white,
                                            )),
                                        hintStyle: const TextStyle(color: Colors.white),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            borderSide:
                                            const BorderSide(color: Colors.white)),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                    width: w / 2,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          fixedSize: Size(w, 45),
                                          shape: RoundedRectangleBorder(
                                              side: const BorderSide(color: Colors.white),
                                              borderRadius: BorderRadius.circular(15))),
                                      child: const Text("Login"),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          ),
        ),
         smallScreen: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(
            () => (controller.isLoading.value == true)
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: const AssetImage("assets/images/grown.png"),
                            height: w / 5),
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          controller: controller.userName,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "User Name",
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: controller.password,
                            style: const TextStyle(color: Colors.white),
                            obscureText: controller.isObscure.value,
                            decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: InkWell(
                                    onTap: () {
                                      controller.isObscure.value =
                                          !controller.isObscure.value;
                                    },
                                    child: (controller.isObscure.value == false)
                                        ? const Icon(
                                            Icons.remove_red_eye,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            CupertinoIcons.eye_slash,
                                            color: Colors.white,
                                          )),
                                hintStyle: const TextStyle(color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        const BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                            width: w / 2,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.login();
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(15))),
                              child: const Text("Login"),
                            )),
                      ],
                    ),
                  ),
          ),
        ),
    );
  }
}



