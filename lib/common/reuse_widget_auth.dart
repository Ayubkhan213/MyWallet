// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

//Text
Widget text({
  required String txt,
  color,
  size,
  weight,
  style,
  align,
}) {
  return Text(
    txt,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontWeight: weight,
      fontStyle: style,
    ),
    textAlign: align,
  );
}

// Input Field
Padding inputField({
  required String label,
  required TextEditingController controller,
  required save,
  required validate,
  required bool isPassword,
  required Widget icon,
  keybordType,
  tab,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 7.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
        child: TextFormField(
          onTap: tab,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: icon,
            label: Text(label),
            border: InputBorder.none,
          ),
          obscureText: isPassword,
          keyboardType: keybordType,
          onSaved: save,
          validator: validate,
        ),
      ),
    ),
  );
}

Widget box({
  required double width,
  required double percent,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: width * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            offset: Offset(-2, -2),
            color: Colors.white,
            spreadRadius: 1,
            blurRadius: 15.0,
          ),
          BoxShadow(
            offset: const Offset(2, 2),
            color: Colors.grey.shade300,
            spreadRadius: 1,
            blurRadius: 15.0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            child: CircularPercentIndicator(
              radius: 25.0,
              percent: percent,
              // progressColor: const Color(0xFF2980b9),
              linearGradient: LinearGradient(colors: [
                Color(0xFF2980b9),
                Color(0xFF2980b9),
                Color.fromARGB(255, 185, 220, 244),
                Color(0xFF2980b9),
              ]),
              animation: true,
              animationDuration: 1500,
              lineWidth: 7.0,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget selectDateButton({
  required BuildContext context,
  selectDateType,
  value,
}) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1980),
                  lastDate: DateTime(2030))
              .then(value);
        },
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  selectDateType,
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Expanded(
                child: Icon(
                  Icons.calendar_month_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
