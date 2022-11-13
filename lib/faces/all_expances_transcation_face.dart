// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/controller/all_expance_transcation_controller.dart';
import 'package:my_wallet/db/db_helper_home.dart';

class AllExpanceTranscationFace extends StatelessWidget {
  const AllExpanceTranscationFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var controller = Get.find<AllExpanceTranscation>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    controller.showSearchWay.value
                        ? Expanded(
                            child: Container(
                              width: width - 100,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                      vertical: 1.0,
                                    ),
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          controller.expanceData.clear();
                                          controller.categoriesExpance.value =
                                              0;
                                          controller.toggle();
                                          controller.getExpanceData();
                                          controller.record.value =
                                              'All record';
                                        },
                                        child: const Icon(
                                          Icons.arrow_forward,
                                          color: Color(0xFF2980b9),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //Container for showing filter
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      //Select field for check weather it is filter
                                      //by categories name or date
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: DropdownButtonFormField(
                                          hint:
                                              const Text('Select Search Type'),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          items: ['Categories', 'Date']
                                              .map<DropdownMenuItem<String>>(
                                                  (e) =>
                                                      DropdownMenuItem<String>(
                                                          value: e,
                                                          child: Text(e)))
                                              .toList(),
                                          onChanged: (value) {
                                            if (value == 'Categories') {
                                              controller.showCategories.value =
                                                  true;
                                              controller.showCalender.value =
                                                  false;
                                              controller.record.value =
                                                  'Categories';
                                              controller.selectStartDate.value =
                                                  'start Date';
                                              controller.selectLastDate.value =
                                                  'last Date';
                                            }
                                            if (value == 'Date') {
                                              controller.showCalender.value =
                                                  true;
                                              controller.showCategories.value =
                                                  false;
                                              controller.record.value = 'Date';
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller.showCategories.value
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: SizedBox(
                                            height: 80.0,
                                            child: Wrap(
                                              children: [
                                                ...List.generate(
                                                  controller
                                                      .expanceTypeData.length,
                                                  (index) => Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              7.0),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await controller
                                                              .getSelectedCategoriesData(
                                                                  id: index +
                                                                      1);
                                                          controller.record
                                                              .value = controller
                                                                  .expanceTypeData[
                                                              index];
                                                        },
                                                        child: Text(controller
                                                                .expanceTypeData[
                                                            index]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                  controller.showCalender.value
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1980),
                                                            lastDate:
                                                                DateTime(2030))
                                                        .then((value) {
                                                      var date = DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(value!);
                                                      var modifyStartDate = date
                                                              .toString()
                                                              .substring(0, 2) +
                                                          date
                                                              .toString()
                                                              .substring(3, 5) +
                                                          date
                                                              .toString()
                                                              .substring(6);
                                                      controller
                                                          .startDate.value = 0;
                                                      controller
                                                              .startDate.value =
                                                          int.parse(
                                                              modifyStartDate);
                                                      controller.selectStartDate
                                                              .value =
                                                          date.toString();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Obx(
                                                      () => Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Expanded(
                                                            flex: 3,
                                                            child: Text(
                                                              controller
                                                                  .selectStartDate
                                                                  .value,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const Expanded(
                                                            child: Icon(
                                                              Icons
                                                                  .calendar_month_outlined,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    showDatePicker(
                                                            context: context,
                                                            initialDate:
                                                                DateTime.now(),
                                                            firstDate:
                                                                DateTime(1980),
                                                            lastDate:
                                                                DateTime(2030))
                                                        .then((value) {
                                                      var date = DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(value!);
                                                      var modifyLastDate = date
                                                              .toString()
                                                              .substring(0, 2) +
                                                          date
                                                              .toString()
                                                              .substring(3, 5) +
                                                          date
                                                              .toString()
                                                              .substring(6);
                                                      controller
                                                          .lastDate.value = 0;
                                                      controller
                                                              .lastDate.value =
                                                          int.parse(
                                                              modifyLastDate);
                                                      controller.selectLastDate
                                                              .value =
                                                          date.toString();
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Colors.white,
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            controller
                                                                .selectLastDate
                                                                .value,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 12.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                        const Expanded(
                                                          child: Icon(
                                                            Icons
                                                                .calendar_month_outlined,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  var result =
                                                      await HomeDBHelper
                                                          .instance
                                                          .getselectDateDate(
                                                              startDate:
                                                                  controller
                                                                      .startDate
                                                                      .value,
                                                              endDate:
                                                                  controller
                                                                      .lastDate
                                                                      .value);
                                                  controller.expanceData
                                                      .clear();
                                                  controller.categoriesExpance
                                                      .value = 0;
                                                  for (var i = 0;
                                                      i < result.length;
                                                      i++) {
                                                    controller.expanceData
                                                        .add(result[i]);
                                                    controller.categoriesExpance
                                                            .value +=
                                                        result[i]['expance']
                                                            as int;
                                                  }
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    color:
                                                        const Color(0xFF2980b9),
                                                  ),
                                                  child: const Icon(
                                                    Icons.search,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox(),
                    GestureDetector(
                      onTap: () {
                        controller.showSearchWay.value = true;
                      },
                      child: controller.showSearchWay.value
                          ? const SizedBox()
                          : const Icon(
                              Icons.search,
                              size: 20.0,
                              color: Color(0xFF2980b9),
                            ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  0.0,
                  5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Expance Record',
                      style: TextStyle(
                        color: Color(0xFF2980b9),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  25.0,
                  0.0,
                  30.0,
                  0.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.record.value,
                      style: const TextStyle(
                        color: Color(0xFF2980b9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      controller.categoriesExpance.value.toString(),
                      style: const TextStyle(
                        color: Color(0xFF2980b9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                // height: height / 1.8,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.expanceData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/${controller.expanceData[index]['expance_type']}.png')),
                            ),
                            title: Text(controller.expanceTypeData[
                                controller.expanceData[index]['expance_type'] -
                                    1]),
                            subtitle:
                                Text(controller.expanceData[index]['title']),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Rs ${controller.expanceData[index]['expance']}'),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    ' ${controller.expanceData[index]['date']}'),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
