// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/signup_controller.dart';

class SignUpFace extends StatelessWidget {
  const SignUpFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var controller = Get.find<SignupController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: height / 20,
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Signup',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2980b9),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),

                //========= FORM ============//
                Form(
                  key: controller.key,
                  child: Column(
                    children: [
                      //========= Name Field ==========//
                      Obx(
                        () => inputField(
                          icon: controller.nameComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.nameComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.nameController.text = '';
                                        controller.nameComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Name',
                          controller: controller.nameController,
                          isPassword: false,
                          save: (value) {
                            controller.name = value;
                          },
                          validate: (value) {
                            return controller.nameValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//
                      //========= Email ==========//
                      Obx(
                        () => inputField(
                          icon: controller.emailComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.emailComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.emailController.text = '';
                                        controller.emailComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Email',
                          controller: controller.emailController,
                          isPassword: false,
                          save: (value) {
                            controller.email = value;
                          },
                          validate: (value) {
                            return controller.emailValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//
                      //=========  Password ==========//
                      Obx(
                        () => inputField(
                          icon: controller.passwordComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.passwordComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.passwordController.text = '';
                                        controller.passwordComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Password',
                          controller: controller.passwordController,
                          isPassword: true,
                          save: (value) {
                            controller.password = value;
                          },
                          validate: (value) {
                            return controller.passwordValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: const Text(
                                'Already have an account?',
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xFF2980b9),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () async {
                            controller.checkSignUp();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              padding: const EdgeInsets.all(15.0),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2980b9),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: controller.loading.value
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : const Text(
                                      'Signup',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 10,
            ),
            Column(
              children: const [
                Text('Or signup with social account'),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Container(
                  //         height: 50.0,
                  //         width: 50.0,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(15.0),
                  //         ),
                  //         child: const Padding(
                  //           padding: EdgeInsets.all(8.0),
                  //           child: Image(
                  //             image: AssetImage('assets/images/google.jpg'),
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 10.0,
                  //       ),
                  //       Container(
                  //         height: 50.0,
                  //         width: 50.0,
                  //         decoration: BoxDecoration(
                  //           color: Colors.white,
                  //           borderRadius: BorderRadius.circular(15.0),
                  //         ),
                  //         child: const Padding(
                  //           padding: EdgeInsets.all(10.0),
                  //           child: Image(
                  //             image: AssetImage('assets/images/facebook.jpg'),
                  //             fit: BoxFit.fill,
                  //           ),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
