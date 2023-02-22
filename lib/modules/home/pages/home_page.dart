// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/common/reusable_list.dart';
import 'package:my_wallet/common/reuse_widget_auth.dart';
import 'package:my_wallet/db/db_helper_home.dart';
import 'package:my_wallet/modules/home/controller/home_controller.dart';
import 'package:my_wallet/routes/app_pages.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //MediaQuery
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                // First row for logout
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
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
                              child: text(
                                txt:
                                    '${DateFormat('MMMM').format(DateTime.now())},${DateTime.now().year}',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: text(
                                txt:
                                    'Rs ${controller.totalExpance.value.toString()} ',
                                color: Colors.white,
                                size: 30.0,
                                weight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        //Row For updating data
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
                              text(
                                txt: ' Update Expantion',
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: SizedBox(
                            height: 95.0,
                            child: expanceTypeValue.isEmpty
                                ? const SizedBox()
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: expanceTypeValue.isEmpty
                                        ? 0
                                        : expanceTypeValue.length,
                                    itemBuilder: (context, index) {
                                      return expanceTypeValue[index] == 0
                                          ? const SizedBox()
                                          //Box for storing icon expencetype name & prize
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7.0,
                                                        horizontal: 12.0),
                                                height: height * 0.01,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.white,
                                                ),
                                                child: Column(
                                                  children: [
                                                    Expanded(
                                                      flex: 2,
                                                      child: CircleAvatar(
                                                        child: Image(
                                                          image: AssetImage(
                                                              'assets/images/$index.png'),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: text(
                                                        txt: expanceTypeName[
                                                            index - 1],
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 77, 148, 195),
                                                        weight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: text(
                                                          txt:
                                                              'Rs. ${expanceTypeValue[index].toString()}',
                                                          color: const Color
                                                                  .fromARGB(255,
                                                              77, 148, 195)),
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
                SizedBox(
                  height: height * 0.02,
                ),
                /* third row for heading expance record and show 
               view all record on another page*/
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17.0,
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
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.ALL_EXPENCES);
                        },
                        child: text(
                          txt: 'View all',
                          color: const Color(0xFF2980b9),
                          weight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                /* 
                List view bulider with multiple list tile for showing 
                one expance type name title date and prize by one list tile
                */
                SizedBox(
                  height: height * 0.55,
                  child: ListView.builder(
                      itemCount: monthlyExpanceData.isEmpty
                          ? 1
                          : monthlyExpanceData.length < 10 &&
                                  monthlyExpanceData.isNotEmpty
                              ? monthlyExpanceData.length
                              : 10,
                      itemBuilder: (context, index) {
                        return monthlyExpanceData.isEmpty
                            ? const Center(
                                child: Image(
                                  image:
                                      AssetImage('assets/images/empty_box.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                                child: Slidable(
                                  //start slidable action for update data
                                  startActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: ((context) async {
                                          await Get.toNamed(
                                              Routes.UPDATE_EXPENCES,
                                              arguments: {
                                                'id': monthlyExpanceData[index]
                                                    .id,
                                                'title':
                                                    monthlyExpanceData[index]
                                                        .title,
                                                'expance_type': expanceTypeName[
                                                    monthlyExpanceData[index]
                                                            .expance_type! -
                                                        1],
                                                'expance_type_id':
                                                    monthlyExpanceData[index]
                                                        .expance_type,
                                                'expance':
                                                    monthlyExpanceData[index]
                                                        .expance,
                                                'date':
                                                    monthlyExpanceData[index]
                                                        .date,
                                                'source':
                                                    monthlyExpanceData[index]
                                                        .source,
                                              });
                                        }),
                                        backgroundColor: Colors.lightBlue,
                                        icon: Icons.update_outlined,
                                        foregroundColor: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ],
                                  ),
                                  //End slidable action for delete data
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: ((context) async {
                                          DBHelper.instance
                                              .deleteRowOfTable(
                                                  id: monthlyExpanceData[index]
                                                      .id!)
                                              .then((val) => print(
                                                  'Successfully Delete Data'))
                                              .catchError((e) => print(
                                                  'Error in Delete data: $e'));
                                          controller.clearReload();
                                        }),
                                        backgroundColor: Colors.red,
                                        icon: Icons.delete,
                                        foregroundColor: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                    ],
                                  ),

                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Image(
                                            image: AssetImage(
                                                'assets/images/${monthlyExpanceData[index].expance_type}.png')),
                                      ),
                                      title: text(
                                          txt: expanceTypeName[
                                              monthlyExpanceData[index]
                                                      .expance_type! -
                                                  1]),
                                      subtitle: text(
                                          txt:
                                              monthlyExpanceData[index].title!),
                                      trailing: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          text(
                                              txt:
                                                  'Rs ${monthlyExpanceData[index].expance}'),
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                          text(
                                            txt:
                                                '${dateFormating(givenDate: monthlyExpanceData[index].date) as String},${DateTime.now().year}',
                                          ),
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
          Get.toNamed(Routes.ADD_EXPANCES);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
