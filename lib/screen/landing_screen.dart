import 'package:date_picker_timeline/extra/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timebloc/main.dart';
import 'package:timebloc/payment_api.dart';
import 'package:timebloc/screen/payment_screen.dart';
import 'package:timebloc/utils/color_resources.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Spacer(flex: 2),
          Image.asset('asset/images/landing.jpg'),
          Spacer(flex: 2),
          Text(
            "Say hi to your personal daily \nplanner",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Spacer(),
          Text(
            "Productive Daily Planner is the premier time blocking application designed to streamline your \ndaily plans and routines.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Spacer(flex: 2),
          CupertinoButton(
            onPressed: () {
              GetStorage.init();
              var box = GetStorage();
              box.write('land', true);
              if (PurchaseApi.isPaid) {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (_) {
                  return MainWidget();
                }));
              } else {
                Navigator.pushReplacement(context,
                    CupertinoPageRoute(builder: (_) {
                  return PaymentScreen();
                }));
              }
            },
            child: Container(
              height: 60,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: ColorResources.getSecondaryColorLight(),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
