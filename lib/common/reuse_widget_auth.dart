// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

// Input Field
Padding inputField({
  required String label,
  required TextEditingController controller,
  required save,
  required validate,
  required bool isPassword,
  required Widget icon,
  keybordType,
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
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: icon,
            // prefixIcon: iconButton != null ? iconButton : null,
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
