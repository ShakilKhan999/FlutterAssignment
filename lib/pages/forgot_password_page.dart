import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/reset_password';
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreenAccent, // Set the background color
                ),
                onPressed: (){
              resetPassword();
            }, child: Text('Sent email',style: TextStyle(color: Colors.black),)),
          ],
        ),
      ),
    );
  }
  Future resetPassword() async {
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),));
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());

      Navigator.of(context).pop();
      const snackBar = SnackBar(
        content: Text('Reset mail sent'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
    }
  }
}
