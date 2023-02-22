// ignore_for_file: unused_local_variable, avoid_print, invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/modules/add%20expance/controller/add_expance_controller.dart';

class AddExpancePage extends GetView<AddExpanceController> {
  const AddExpancePage({super.key});

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
              height: height * 0.04,
            ),
            Column(
              children: [
                //Expance Text with Padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: text(
                      txt: 'Expances',
                      color: const Color(0xFF2980b9),
                      weight: FontWeight.bold,
                      size: 35.0,
                    ),
                  ),
                ),

                //SizedBoxed
                SizedBox(
                  height: height * 0.06,
                ),

                //========= FORM ============//
                Form(
                  key: controller.key,
                  child: Obx(
                    () => Column(
                      children: [
                        //========= Title Field ==========//
                        inputField(
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
                        //============= END ============//

                        //========= ExpanceType Field ==========//
                        Padding(
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
                                  ...List.generate(expanceTypeData.length,
                                      (index) => expanceTypeData[index])
                                ].map<DropdownMenuItem<dynamic>>((value) {
                                  return DropdownMenuItem<dynamic>(
                                    value: value.id,
                                    child: text(
                                      txt: value.expance_type,
                                      color: Colors.grey.shade600,
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
                        //============= END ============//

                        //========= Expance Field ==========//
                        inputField(
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
                            var data = int.parse(value);
                            controller.expance = data;
                          },
                          validate: (value) {
                            return controller.expanceValidation(value);
                          },
                          isPassword: false,
                        ),
                        //============= END ============//

                        //========= Date Field ==========//
                        inputField(
                          tab: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2030))
                                .then((value) {
                              var date =
                                  DateFormat('dd-MM-yyyy').format(value!);
                              controller.dateController.text = date;
                              var modifyDateString =
                                  DateFormat('dd-MM-yyyy').parse(date);
                              var modifyDate = DateFormat('ddMMyyyy')
                                  .format(modifyDateString);
                              var integerDate = int.parse(modifyDate);
                              controller.filterDate.value = integerDate;
                            }).catchError(
                                    (e) => print('Error in date picker:$e'));
                          },
                          isPassword: false,
                          icon: Icon(
                            Icons.calendar_month,
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
                        //============= END ============//

                        //========= Source Field ==========//
                        inputField(
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
                        //============= END ============//

                        //SizedBoxed
                        SizedBox(
                          height: height * 0.02,
                        ),

                        //Add Expance Button
                        GestureDetector(
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
                                  : text(
                                      txt: 'Add Expances',
                                      color: Colors.white,
                                      align: TextAlign.center,
                                      weight: FontWeight.bold,
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
            //Sizedboxed
            SizedBox(
              height: height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
