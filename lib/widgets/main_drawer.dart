import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import '../auth/auth_service.dart';
import 'package:http/http.dart' as http;

import '../pages/api_intergation.dart';
import '../pages/launcher_page.dart';


class MainDrawer extends StatelessWidget {
  MainDrawer({Key? key}) : super(key: key);
  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 100,
            color: Colors.yellow[200],
          ),
          ListTile(
            onTap: () async {
              AuthService.logout().then((value) =>
                  Navigator.pushReplacementNamed(
                      context, LauncherPage.routeName));
            },
            leading: const Icon(Icons.logout),
            title: const Text('LOGOUT'),
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            onTap: () async {
              AuthService.logout().then((value) =>
                  Navigator.pushNamed(context, Api_intregation.routeName));
            },
            leading: const Icon(Icons.podcasts),
            title: const Text('See Other Post'),
          ),
          const SizedBox(
            height: 545,
          ),
          Container(
            height: 45,
            width: 50,
            child: ElevatedButton(
              onPressed: () async {
                await makePayment();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent[400]),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                'Buy me a Coffee',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> makePayment() async {
    try {
      paymentIntent = await createPaymentIntent('10000', 'GBP');

      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "GB", currencyCode: "GBP", testEnv: true);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.light,
                  merchantDisplayName: 'Abhi',
                  googlePay: gpay))
          .then((value) {});

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print(err);
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        print("Payment Successfully");
      });
    } catch (e) {
      print('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MtV0SK7aOy5qYuabhEdVPFdgXlZR3cr6brVTzJ85aOPrxACAuvruYdUsTCNX0MeowT2GCfdEb2Ee8JntxAfA9tM00EEHjVNEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
