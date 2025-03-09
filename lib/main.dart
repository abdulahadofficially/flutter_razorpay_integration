import 'package:flutter/material.dart';
import 'package:flutter_razor_pay_integration/screens/razor_pay_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Razorpay payment integration',
      home: RazorPayPage(),
    );
  }
}
