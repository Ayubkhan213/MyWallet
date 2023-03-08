// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/modules/all%20expances/controller/all_expances_controller.dart';

class AllExpancesPage extends GetView<AllExpancesController> {
  const AllExpancesPage({super.key});

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
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    /* By clicking search Icon 
                    this will open*/
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

                                      /* By clicking this icon it will toggle 
                                      back to search Icon*/
                                      child: GestureDetector(
                                        onTap: () async {
                                          totalExpancesData.clear();
                                          controller.categoriesExpance.value =
                                              0;
                                          controller.toggle();
                                          await controller
                                              .getTotalExpanceValue();

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
                                          hint: text(txt: 'Select Search Type'),
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          items: ['Categories', 'Date']
                                              .map<DropdownMenuItem<String>>(
                                                  (e) =>
                                                      DropdownMenuItem<String>(
                                                          value: e,
                                                          child: text(txt: e)))
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
                                  /* By clicking categories these 
                                  Categories will Show */
                                  controller.showCategories.value
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: SizedBox(
                                            height: 80.0,
                                            child: Wrap(
                                              children: [
                                                ...List.generate(
                                                  expanceTypeName.length,
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
                                                      /* Here by clicking any Categories
                                                      the result of that will be shown here */
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await controller
                                                              .getSelectedCategoriesTotalExpance(
                                                                  id: index +
                                                                      1);
                                                          controller.record
                                                                  .value =
                                                              expanceTypeName[
                                                                  index];
                                                        },
                                                        child: text(
                                                            txt:
                                                                expanceTypeName[
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
                                  /*On Cicking on Date it will 
                                      show these two button  */
                                  controller.showCalender.value
                                      ? Row(
                                          children: [
                                            selectDateButton(
                                              context: context,
                                              value: (value) {
                                                var date =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(value!);
                                                var modified =
                                                    DateFormat('ddMMyyyy')
                                                        .format(value);
                                                controller.startDate.value = 0;
                                                controller.startDate.value =
                                                    int.parse(modified);
                                                controller.selectStartDate
                                                    .value = date.toString();
                                              },
                                              selectDateType: controller
                                                  .selectStartDate.value,
                                            ),
                                            selectDateButton(
                                              context: context,
                                              value: (value) {
                                                var date =
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(value!);
                                                var modifyLastDate =
                                                    DateFormat('ddMMyyyy')
                                                        .format(value);

                                                controller.lastDate.value = 0;
                                                controller.lastDate.value =
                                                    int.parse(modifyLastDate);
                                                controller.selectLastDate
                                                    .value = date.toString();
                                              },
                                              selectDateType: controller
                                                  .selectLastDate.value
                                                  .toString(),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () async {
                                                  totalExpancesData.clear();
                                                  await DBHelper.instance
                                                      .getselectDateDate(
                                                          startDate: controller
                                                              .startDate.value,
                                                          endDate: controller
                                                              .lastDate.value);

                                                  controller.categoriesExpance
                                                      .value = 0;

                                                  for (var i = 0;
                                                      i <
                                                          totalExpancesData
                                                              .length;
                                                      i++) {
                                                    controller.categoriesExpance
                                                            .value +=
                                                        totalExpancesData[i]
                                                            .expance!;
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

                    /*IconButton which we click then
                       showSearchWay become true */
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
              /* Row with Padding For 
              showing text Expance Recort */
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  20.0,
                  20.0,
                  0.0,
                  5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(
                      txt: 'Expance Record',
                      color: const Color(0xFF2980b9),
                      size: 28.0,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              /* Row with Padding For showing Record Name
              And the Total Value Of that Record */
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
                    text(
                      txt: controller.record.value,
                      color: const Color(0xFF2980b9),
                      weight: FontWeight.bold,
                    ),
                    text(
                      txt: controller.categoriesExpance.value.toString(),
                      color: const Color(0xFF2980b9),
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: totalExpancesData.isEmpty
                        ? 1
                        : totalExpancesData.length,
                    itemBuilder: (context, index) {
                      return totalExpancesData.isEmpty
                          ? Center(
                              child: text(txt: 'No data Found'),
                            )
                          : Padding(
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
                                            'assets/images/${totalExpancesData[index].expance_type}.png')),
                                  ),
                                  title: text(
                                      txt: expanceTypeName[
                                          totalExpancesData[index]
                                                  .expance_type! -
                                              1]),
                                  subtitle: text(
                                      txt: totalExpancesData[index].title!),
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      text(
                                          txt:
                                              'Rs ${totalExpancesData[index].expance}'),
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      text(
                                          txt:
                                              '${dateFormating(givenDate: totalExpancesData[index].date) as String},${DateTime.now().year}'),
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
