import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/expances_type_controller.dart';

class ExpancesTypeFace extends StatelessWidget {
  const ExpancesTypeFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;

    var controller = Get.find<ExpancesTypeController>();
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
                        'Expances Type',
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
                      //========= expanceType Field ==========//
                      Obx(
                        () => inputField(
                          icon: controller.expanceTypeComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.expanceTypeComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.expanceTypeComplete.value =
                                            '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Expanses type',
                          controller: controller.expanceTypeController,
                          isPassword: false,
                          save: (value) {
                            controller.expanceType = value;
                          },
                          validate: (value) {
                            return controller.expancesTypeValidation(value);
                          },
                        ),
                      ),

                      Obx(
                        () => GestureDetector(
                          onTap: () {
                            controller.checkValidation();
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
                                      'Add Expances Type',
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
          ],
        ),
      ),
    );
  }
}
