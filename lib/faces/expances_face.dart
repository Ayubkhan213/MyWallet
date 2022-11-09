// ignore_for_file: unused_local_variable, avoid_print, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/expances_controller.dart';

class ExpancesFace extends StatelessWidget {
  const ExpancesFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var controller = Get.find<ExpancesController>();
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
                        'Expances',
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
                      //========= Title Field ==========//
                      Obx(
                        () => inputField(
                          isPassword: false,
                          icon: controller.titleComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.titleComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.titleController.text = '';
                                        controller.titleComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Title',
                          controller: controller.titleController,
                          keybordType: TextInputType.text,
                          save: (value) {
                            controller.title = value;
                          },
                          validate: (value) {
                            return controller.titleValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//
                      //========= ExpanceType Field ==========//
                      Obx(
                        () => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15.0,
                              ),
                              child: DropdownButtonFormField(
                                decoration: InputDecoration(
                                  hintText: 'Expances Type',
                                  border: InputBorder.none,
                                  suffix: controller
                                              .expanceTypeComplete.value ==
                                          'true'
                                      ? Icon(Icons.check,
                                          color: Colors.green.shade800)
                                      : controller.expanceTypeComplete.value ==
                                              'false'
                                          ? IconButton(
                                              onPressed: () {
                                                controller.expanceTypeController
                                                    .text = '';
                                                controller.expanceTypeComplete
                                                    .value = '';
                                              },
                                              icon: Icon(
                                                Icons.close,
                                                color: Colors.red.shade800,
                                              ))
                                          : const Icon(null),
                                ),
                                onSaved: (value) {
                                  controller.expanceType = value;
                                },
                                validator: (value) {
                                  return controller
                                      .expanceTypeValidation(value.toString());
                                },
                                items: <dynamic>[
                                  ...List.generate(
                                      controller.expanceTypeData.length,
                                      (index) =>
                                          controller.expanceTypeData[index])
                                ].map<DropdownMenuItem<dynamic>>((value) {
                                  return DropdownMenuItem<dynamic>(
                                    value: value['id'],
                                    child: Text(
                                      value['expance_type'],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  controller.expanceType = value;
                                },
                              ),
                            ),
                          ),
                        ),
                      ),

                      //============= END ============//
                      //========= Expance Field ==========//
                      Obx(
                        () => inputField(
                          icon: controller.expanceComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.expanceComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.expanceController.text = '';
                                        controller.expanceComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Expance',
                          controller: controller.expanceController,
                          keybordType: TextInputType.number,
                          save: (value) {
                            controller.expance = value;
                          },
                          validate: (value) {
                            return controller.expanceValidation(value);
                          },
                          isPassword: false,
                        ),
                      ),

                      //============= END ============//
                      //========= Date Field ==========//
                      Obx(
                        () => inputField(
                          isPassword: false,
                          icon: controller.dateComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.dateComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.dateController.text = '';
                                        controller.dateComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1980),
                                                lastDate: DateTime(2030))
                                            .then((value) {
                                          var date = DateFormat('dd-MM-yyyy')
                                              .format(value!);
                                          controller.dateController.text = date;
                                          var modifyDate = date
                                                  .toString()
                                                  .substring(0, 2) +
                                              date.toString().substring(3, 5) +
                                              date.toString().substring(6);
                                          var integerDate =
                                              int.parse(modifyDate);
                                          controller.filterDate.value =
                                              integerDate;
                                        }).catchError((e) => print(
                                                'Error in date picker:$e'));
                                      },
                                      icon: const Icon(Icons.calendar_month),
                                      color: Colors.grey.shade600,
                                    ),
                          label: 'Date',
                          controller: controller.dateController,
                          keybordType: TextInputType.text,
                          save: (value) {
                            controller.date = value;
                          },
                          validate: (value) {
                            return controller.dateValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//
                      //========= Source Field ==========//
                      Obx(
                        () => inputField(
                          isPassword: false,
                          icon: controller.sourceComplete.value == 'true'
                              ? Icon(Icons.check, color: Colors.green.shade800)
                              : controller.sourceComplete.value == 'false'
                                  ? IconButton(
                                      onPressed: () {
                                        controller.sourceController.text = '';
                                        controller.sourceComplete.value = '';
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.red.shade800,
                                      ))
                                  : const Icon(null),
                          label: 'Source',
                          controller: controller.sourceController,
                          keybordType: TextInputType.text,
                          save: (value) {
                            controller.source = value;
                          },
                          validate: (value) {
                            return controller.sourceValidation(value);
                          },
                        ),
                      ),

                      //============= END ============//

                      const SizedBox(
                        height: 20.0,
                      ),
                      Obx(
                        () => GestureDetector(
                          onTap: () async {
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
                                      'Add Expances',
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
