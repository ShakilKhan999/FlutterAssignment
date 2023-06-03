

import 'package:demo_stripe/pages/to_do_items.dart';
import 'package:flutter/material.dart';



import '../auth/auth_service.dart';
import 'login_page.dart';


class LauncherPage extends StatefulWidget {
  static const String routeName = '/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {

  @override
  void initState() {
    Future.delayed(Duration (seconds: 3), () {
      if(AuthService.user == null) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      } else {
        Navigator.pushReplacementNamed(context, ToDoItems.routename);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset('images/Launcher.png'),
              CircularProgressIndicator(),
            ],
          ),
      ),
    );
  }
}
