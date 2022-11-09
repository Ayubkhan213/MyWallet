// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/auth/signup_face.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/login_controller.dart';

class LoginFace extends StatelessWidget {
  const LoginFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var controller = Get.find<LoginController>();
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: height / 8,
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color(0xFF2980b9),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: controller.key,
                  child: Column(
                    children: [
                      // ==== Email Field ======//
                      Obx(
                        () => inputField(
                            label: 'Email',
                            icon: controller.emailComplete.value == 'true'
                                ? Icon(Icons.check,
                                    color: Colors.green.shade800)
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
                            controller: controller.emailController,
                            isPassword: false,
                            save: (value) {
                              controller.email = value;
                            },
                            validate: (value) {
                              return controller.emailValidation(value);
                            }),
                      ),

                      //=======================//

                      //======= Password Field =====//
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

                      //============================//

                      //  == Row For Text of forget Password ==//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // Get.to(
                                //   const ForgotFace(),
                                // );
                              },
                              child: const Text(
                                'Forgot your password?',
                              ),
                            ),
                            const Icon(
                              Icons.arrow_right_alt,
                              color: Color(0xFF2980b9),
                            ),
                          ],
                        ),
                      ),
                      //  ============== END OF ROW   ===============//

                      //  ===== SIZE box  ======//
                      const SizedBox(
                        height: 20.0,
                      ),
                      //============ End ========//

                      //========== Container For Log in button   =======//
                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.checkLogin();
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
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text(
                                      'LOGIN',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                            ),
                          ),
                        ),
                      ),

                      //============= END of Log in Button ==========//
                    ],
                  ),
                ),
                //============= END OF FORM ================//
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not have Account',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 15.0,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          const SignUpFace(),
                        );
                      },
                      child: const Text(
                        '  SignUp!',
                        style: TextStyle(
                          color: Color(0xFF2980b9),
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //========== SIZE Box ==================//
            SizedBox(
              height: height / 7,
            ),
            //============= END ================//

            // ======== Column For Bottom ========//
            Column(
              children: const [
                Text('Or login with social account'),
                //   Padding(
                //     padding: const EdgeInsets.all(10.0),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Container(
                //           height: 50.0,
                //           width: 50.0,
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(15.0),
                //           ),
                //           child: const Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Image(
                //               image: AssetImage('assets/images/google.jpg'),
                //               fit: BoxFit.fill,
                //             ),
                //           ),
                //         ),
                //         const SizedBox(
                //           width: 10.0,
                //         ),
                //         //   Container(
                //         //     height: 50.0,
                //         //     width: 50.0,
                //         //     decoration: BoxDecoration(
                //         //       color: Colors.white,
                //         //       borderRadius: BorderRadius.circular(15.0),
                //         //     ),
                //         //     child: const Padding(
                //         //       padding: EdgeInsets.all(10.0),
                //         //       child: Image(
                //         //         image: AssetImage('assets/images/facebook.jpg'),
                //         //         fit: BoxFit.fill,
                //         //       ),
                //         //     ),
                //         //   ),
                //       ],
                //     ),
                //   )
              ],
            ),
            //============= END OF COLUMN ===========//
          ],
        ),
      ),
    );
  }
}
