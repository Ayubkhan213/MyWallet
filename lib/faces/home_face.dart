// ignore_for_file: unused_import, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/controller/home_controller.dart';
import 'package:my_wallet/controller/update_expance_controller.dart';
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
    var updateController = Get.find<UpdateExpancesController>();
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                //First row for logout and add expancetype with padding//

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
                /* Second row with container for monthly expance and 
              categories of that expance type */
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
                                        controller.expanceTypeData.isEmpty
                                            ? 0
                                            : controller.expanceTypeData.length,
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
                                                      controller.expanceTypeData[
                                                              index]
                                                          ['expance_type'],
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
                /* third row for heaging expance record and show 
               view all record on another page*/
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
                /* 
                List view bulider with multiple listtile for showing 
                one expance type name title date and prize by one listtile
                */
                SizedBox(
                  height: height * 0.5,
                  child: ListView.builder(
                      itemCount: controller.expanceData.length < 10
                          ? controller.expanceData.length
                          : 10,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Slidable(
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: ((context) async {
                                    updateController.initateData['id'] =
                                        controller.expanceData[index]['id'];
                                    updateController.initateData['title'] =
                                        controller.expanceData[index]['title'];
                                    updateController
                                            .initateData['expance_type'] =
                                        controller.expanceData[index]
                                            ['expance_type'];
                                    updateController.initateData['expance'] =
                                        controller.expanceData[index]
                                            ['expance'];
                                    updateController.initateData['date'] =
                                        controller.expanceData[index]['date'];
                                    updateController.initateData['source'] =
                                        controller.expanceData[index]['source'];
                                    await updateController.initializeValue();
                                    await Get.to(const UpdateExpancesFace(),
                                        arguments: {
                                          'expance_type':
                                              controller.expanceTypeData[
                                                  controller.expanceData[index]
                                                          ['expance_type'] -
                                                      1]['expance_type'],
                                        });
                                  }),
                                  backgroundColor: Colors.lightBlue,
                                  icon: Icons.update_outlined,
                                  foregroundColor: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: ((context) async {
                                    HomeDBHelper.instance
                                        .deleteRowOfTable(
                                            id: controller.expanceData[index]
                                                ['id'])
                                        .then((val) =>
                                            print('Successfully Delete Data'))
                                        .catchError((e) =>
                                            print('Error in Delete data: $e'));
                                    controller.clearReload();
                                  }),
                                  backgroundColor: Colors.red,
                                  icon: Icons.delete,
                                  foregroundColor: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ],
                            ),
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
                                        controller.expanceData[index]
                                                ['expance_type'] -
                                            1]['expance_type']
                                    .toString()),
                                subtitle: Text(
                                    controller.expanceData[index]['title']),
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
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      //Last floation action button for to add new expance //
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const ExpancesFace());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
