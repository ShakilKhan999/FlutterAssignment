
import 'package:demo_stripe/pages/to_do_items.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import 'launcher_page.dart';

class RegistrationPage extends StatefulWidget {
  static const String routeName = '/registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  bool isObscureText = true;
  final formKey = GlobalKey<FormState>();
  String errMsg = '';
  late String phone;

  // @override
  // void didChangeDependencies() {
  //   phone = ModalRoute.of(context)!.settings.arguments as String;
  //   phoneController.text = phone;
  //   super.didChangeDependencies();
  // }
  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,

                decoration: const InputDecoration(
                    hintText: 'Mobile Number',
                    prefixIcon: Icon(Icons.phone),
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'Email Address',
                    prefixIcon: Icon(Icons.email),
                    fillColor: Colors.white,
                    filled: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: isObscureText,
                controller: passController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(isObscureText
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () => setState(() {
                      isObscureText = !isObscureText;
                    }),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreenAccent),
                  onPressed: () {
                    if(nameController.text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Name required'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if(emailController.text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Email required'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if(phoneController.text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Phone required'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    if(passController.text.isEmpty) {
                      const snackBar = SnackBar(
                        content: Text('Password required'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      return;
                    }
                    else {
                      authenticate();
                      Navigator.pushNamedAndRemoveUntil(
                          context, ToDoItems.routename, (route) => false);
                    }

                  },
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                errMsg,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              )
            ],
          ),
        ),
      ),
    );
  }

  authenticate() async {
    if (formKey.currentState!.validate()) {
      try {
        AuthService.register(nameController.text, phoneController.text,
            emailController.text, passController.text).then((_) =>
        Navigator.pushNamedAndRemoveUntil(context, LauncherPage.routeName, (route) => false));
      } on FirebaseAuthException catch (e) {
        setState(() {
          errMsg = e.message!;
        });
      }
    }
  }
}
