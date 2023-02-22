// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/modules/auth/controller/login_controller.dart';
import 'package:my_wallet/routes/app_pages.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //MediaQuery
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: height / 8,
            ),
            Column(
              children: [
                //Text Login WIth Padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: text(
                      txt: 'Login',
                      weight: FontWeight.bold,
                      size: 30.0,
                      color: const Color(0xFF2980b9),
                    ),
                  ),
                ),
                //SizedBoxed
                SizedBox(
                  height: height * 0.08,
                ),
                //Form

                Form(
                  key: controller.key,
                  child: Obx(
                    () => Column(
                      children: [
                        // ==== Email Field ======//
                        inputField(
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

                        //=======================//

                        //======= Password Field =====//
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

                        //============================//

                        //  == Row For Text of forget Password ==//
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: text(
                                  txt: 'Forgot your password?',
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
                        SizedBox(
                          height: height * 0.04,
                        ),
                        //============ End ========//

                        //========== Container For Log in button=======//
                        GestureDetector(
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
                                  : text(
                                      txt: 'LOGIN',
                                      color: Colors.white,
                                      align: TextAlign.center,
                                      weight: FontWeight.bold,
                                    ),
                            ),
                          ),
                        ),

                        //============= END of Log in Button ==========//
                      ],
                    ),
                  ),
                ),
                //============= END OF FORM ================//

                //Row with text not have account  Signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    text(
                      txt: 'Not have Account',
                      color: Colors.grey.shade800,
                      size: 15.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SIGNUP);
                      },
                      child: text(
                        txt: '  SignUp!',
                        color: const Color(0xFF2980b9),
                        size: 15.0,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //========== SIZE Box ==================//
            SizedBox(
              height: height * 0.2,
            ),
            //============= END ================//

            // ======== Column For Bottom ========//
            Column(
              children: const [
                Text('Or login with social account'),
              ],
            ),
            //============= END OF COLUMN ===========//
          ],
        ),
      ),
    );
  }
}
