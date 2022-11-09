// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/home_controller.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/faces/all_expances_transcation_face.dart';
import 'package:my_wallet/faces/expance_type_face.dart';

import 'package:my_wallet/faces/expances_face.dart';
import 'package:my_wallet/faces/update_expance_face.dart';

class HomeFace extends StatelessWidget {
  const HomeFace({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    var controller = Get.find<HomeController>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(const ExpancesTypeFace());
                        },
                        icon: const Icon(
                          Icons.settings,
                          color: Color.fromARGB(255, 77, 148, 195),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.logout();
                        },
                        icon: const Icon(
                          Icons.logout_outlined,
                          color: Color.fromARGB(255, 77, 148, 195),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: height * 0.25,
                    width: width,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 77, 148, 195),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                '${controller.month[int.parse(DateFormat('M').format(controller.formateDate)) - 1]},${DateTime.now().year}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                'Rs ${controller.totalExpance.value.toString()} ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.clearReload();
                                },
                                child: const Icon(
                                  Icons.update_outlined,
                                  color: Colors.white,
                                  size: 18.0,
                                ),
                              ),
                              const Text(
                                ' Update Expantion',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SizedBox(
                            height: 80.0,
                            child: controller.expanceTypeValue.isEmpty
                                ? const SizedBox()
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.expanceTypeName.isEmpty
                                            ? 2
                                            : controller.expanceTypeName.length,
                                    itemBuilder: (context, index) {
                                      return controller
                                                  .expanceTypeValue[index] ==
                                              0
                                          ? const SizedBox()
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                height: height * 0.01,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      controller
                                                              .expanceTypeName[
                                                          index],
                                                      style: const TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 77, 148, 195),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Rs. ${controller.expanceTypeValue[index].toString()}',
                                                      style: const TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              77,
                                                              148,
                                                              195)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                    }),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expance Record',
                        style: TextStyle(
                          color: Color(0xFF2980b9),
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const AllExpanceTranscationFace());
                        },
                        child: const Text(
                          'View all',
                          style: TextStyle(
                            color: Color(0xFF2980b9),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Obx(
                  () => SizedBox(
                    height: height / 1.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              border: TableBorder.all(),
                              columns: [
                                ...List.generate(
                                  controller.tableColumn.length,
                                  (index) => DataColumn(
                                    label: Text(
                                      controller.tableColumn[index],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: [
                                ...List.generate(
                                  controller.expanceData.length > 10
                                      ? 10
                                      : controller.expanceData.length,
                                  (index) => DataRow(
                                      onLongPress: () async {
                                        Get.defaultDialog(
                                          title: 'Warning!',
                                          middleText:
                                              'Here you can update or Delete',
                                          confirm: GestureDetector(
                                            onTap: () async {
                                              Get.back();
                                              var expanceType = await controller
                                                  .getExpanceTypeName(
                                                      id: controller
                                                                  .expanceData[
                                                              index]
                                                          ['expance_type']);
                                              await Get.to(
                                                  const UpdateExpancesFace(),
                                                  arguments: {
                                                    'id': controller
                                                            .expanceData[index]
                                                        ['id'],
                                                    'title': controller
                                                            .expanceData[index]
                                                        ['title'],
                                                    'expance_type_id':
                                                        controller.expanceData[
                                                                index]
                                                            ['expance_type'],
                                                    'expance_type': expanceType,
                                                    'expance': controller
                                                            .expanceData[index]
                                                        ['expance'],
                                                    'date': controller
                                                            .expanceData[index]
                                                        ['date'],
                                                    'source': controller
                                                            .expanceData[index]
                                                        ['source'],
                                                  });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Colors.amber),
                                              child: const Text('Update'),
                                            ),
                                          ),
                                          cancel: GestureDetector(
                                            onTap: () {
                                              print('Delete');
                                              Get.back();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  color: Colors.red),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: const Text('Delete'),
                                            ),
                                          ),
                                        );
                                        // await HomeDBHelper.instance
                                        //     .deleteRowOfTable(
                                        //         id: controller
                                        //             .expanceData[index]['id'])
                                        //     .then((val) => print(
                                        //         'successfully delete data'))
                                        //     .catchError((e) => print(e));
                                      },
                                      cells: [
                                        DataCell(
                                          GestureDetector(
                                            onTap: () {
                                              print(controller
                                                  .expanceData[index]);
                                            },
                                            child: Text(controller
                                                .expanceData[index]['title']),
                                          ),
                                        ),
                                        DataCell(
                                          FutureBuilder(
                                              future:
                                                  controller.getExpanceTypeName(
                                                      id: controller
                                                                  .expanceData[
                                                              index]
                                                          ['expance_type']),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  return Text(
                                                      snapshot.data.toString());
                                                }
                                                return const Text(
                                                    'Loading ...');
                                              }),
                                        ),
                                        DataCell(
                                          Text(controller.expanceData[index]
                                                  ['expance']
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(controller.expanceData[index]
                                                  ['date']
                                              .toString()),
                                        ),
                                        DataCell(
                                          Text(controller.expanceData[index]
                                              ['source']),
                                        ),
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ExpancesFace());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}


  //  Obx(
  //               () => Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     horizontal: 20.0, vertical: 7.0),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     controller.showTextField.value
  //                         ? Container(
  //                             width: width - 80,
  //                             decoration: BoxDecoration(
  //                               color: Colors.grey.shade200,
  //                               borderRadius: BorderRadius.circular(10.0),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.only(left: 20.0),
  //                               child: TextFormField(
  //                                 controller: controller.searchController,
  //                                 onChanged: (val) {
  //                                   controller.search.value = val;
  //                                 },
  //                                 decoration: const InputDecoration(
  //                                   border: InputBorder.none,
  //                                 ),
  //                               ),
  //                             ),
  //                           )
  //                         : const SizedBox(),
  //                     GestureDetector(
  //                       onTap: () {
  //                         controller.toggle();
  //                       },
  //                       child: controller.showTextField.value
  //                           ? const Icon(
  //                               Icons.search,
  //                               size: 25.0,
  //                               color: Color(0xFF2980b9),
  //                             )
  //                           : const Icon(
  //                               Icons.search,
  //                               size: 20.0,
  //                               color: Color(0xFF2980b9),
  //                             ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
              
 // color: const Color.fromARGB(
                                                //     255, 77, 148, 195),
                                                // boxShadow: const [
                                                //   BoxShadow(
                                                //     color: Color(0xFF2980b9),
                                                //     offset: Offset(5, 5),
                                                //     spreadRadius: 1,
                                                //     blurRadius: 15.0,
                                                //   ),
                                                //   BoxShadow(
                                                //     color: Color.fromARGB(
                                                //         255, 101, 167, 211),
                                                //     offset: Offset(-5, -5),
                                                //     spreadRadius: 1,
                                                //     blurRadius: 10.0,
                                                //   ),
                                                // ],
