import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_widget.dart';
class SignInPage extends StatefulWidget {

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      providers: [],
      child: SignInContainer(),
    );
  }
}

class SignInContainer extends StatefulWidget {
  const SignInContainer({Key? key}) : super(key: key);

  @override
  State<SignInContainer> createState() => _SignInContainerState();
}

class _SignInContainerState extends State<SignInContainer> {
  @override
  Widget build(BuildContext context) {
    return Text("Demo");
  }
}

