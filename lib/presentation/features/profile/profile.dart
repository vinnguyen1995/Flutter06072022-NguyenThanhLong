import 'package:flutter/material.dart';
import 'package:flutter_app_sale_06072022/common/bases/base_widget.dart';
import 'package:flutter_app_sale_06072022/common/constants/variable_constant.dart';
import 'package:flutter_app_sale_06072022/data/datasources/local/cache/app_cache.dart';
import 'package:flutter_app_sale_06072022/presentation/features/sign_in/sign_in_page.dart';
import '../profile/signOut.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      appBar: AppBar(
        title: const Text("My Profile"),
      ),
      providers: [],
      child: ProfileContainer(),
    );
  }
}

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({Key? key}) : super(key: key);

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8),
            child: Image.asset(
              "assets/images/avatar.png",
              fit: BoxFit.fitWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 24),
            child: Row(children: const <Widget>[
              Expanded(
                child: Text(
                  'Jonathan Ive',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
          ),
          Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Are you sure you want to Sign Out?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: const Text(
                            'Sign Out',
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /* {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => SignInPage()));
                  } */
                  child: Container(
                      margin: const EdgeInsets.only(bottom: 40),
                      child: const Text('Sign Out')),
                )),
          ),
        ],
      ),
    );
  }
}
