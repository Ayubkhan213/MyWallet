// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/modules/auth/controller/signup_controller.dart';

class SignUpPage extends GetView<SignupController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    //MediaQuery
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      //Appbar
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          children: [
            //SizedBoxed
            SizedBox(
              height: height * 0.05,
            ),
            Column(
              children: [
                //Signup Text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: text(
                      txt: 'Signup',
                      color: const Color(0xFF2980b9),
                      size: 35.0,
                      weight: FontWeight.bold,
                    ),
                  ),
                ),
                //SIzedBoxed
                SizedBox(
                  height: height * 0.08,
                ),

                //========= FORM ============//
                Form(
                  key: controller.key,
                  child: Obx(
                    () => Column(
                      children: [
                        //========= Name Field ==========//
                        inputField(
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
                        //============= END ============//

                        //========= Email ==========//
                        inputField(
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
                        //============= END ============//

                        //=========  Password ==========//
                        inputField(
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
                        //============= END ============//
                        //Padding Row for Already have Account
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
                        //SizedBoxed
                        SizedBox(
                          height: height * 0.02,
                        ),

                        //Signup Button
                        GestureDetector(
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
                                  : text(
                                      txt: 'Signup',
                                      color: Colors.white,
                                      align: TextAlign.center,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.12,
            ),
            Column(
              children: const [
                Text('Or signup with social account'),
                Padding(
                  padding: EdgeInsets.all(10.0),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
