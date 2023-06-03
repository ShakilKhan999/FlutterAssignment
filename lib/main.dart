import 'package:demo_stripe/pages/api_intergation.dart';
import 'package:demo_stripe/pages/details_page.dart';
import 'package:demo_stripe/pages/forgot_password_page.dart';
import 'package:demo_stripe/pages/launcher_page.dart';
import 'package:demo_stripe/pages/login_page.dart';
import 'package:demo_stripe/pages/newtodo_page.dart';
import 'package:demo_stripe/pages/registration_page.dart';
import 'package:demo_stripe/pages/see_post_page.dart';
import 'package:demo_stripe/pages/to_do_items.dart';
import 'package:demo_stripe/provider/todo_provider.dart';
import 'package:demo_stripe/provider/post_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51MtV0SK7aOy5qYua6WoCCU7FVQ1Jz1drilD9iH3r821EOuzchqh2YWF7FgMYi5uMldm8eEAwC4AxI4JWbbV3zWhY00NRhq94vJ';
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> TodoProvider() ..getAllToDoItem()),
        ChangeNotifierProvider.value(value: PostProvider())
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:

      LauncherPage.routeName,
      routes: {
        LauncherPage.routeName: (_) => LauncherPage(),
        LoginPage.routeName: (_) => LoginPage(),
        ToDoItems.routename:(context)=>ToDoItems(),
        NewToDoPage.routename:(context)=> NewToDoPage(),
        RegistrationPage.routeName: (_) => RegistrationPage(),
        ForgotPasswordScreen.routeName:(_)=>ForgotPasswordScreen(),
        SeePostPage.routeName:(_)=> SeePostPage(),
        DetailsPage.routeName:(_)=>DetailsPage(),
        Api_intregation.routeName:(_)=> Api_intregation()
      },
    );
  }
}
