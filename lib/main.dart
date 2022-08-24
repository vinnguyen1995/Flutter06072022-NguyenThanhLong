import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/constants/variable_constant.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "QuickSan",
        primarySwatch: Colors.blue,
      ),
      routes: {
        VariableConstant.SIGN_IN_ROUTE: (context) => SignInPage()
      },
      initialRoute: VariableConstant.SIGN_IN_ROUTE,
    );
  }
}

