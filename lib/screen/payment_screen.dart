import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:timebloc/main.dart';
import 'package:timebloc/payment_api.dart';
import 'package:timebloc/utils/color_resources.dart';

class PaymentScreen extends StatefulWidget {
  bool isshow;
  PaymentScreen({super.key, this.isshow = false});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool trail = true;
  bool show = false;
  @override
  void initState() {
    super.initState();
    getback();
  }

  getback() async {
    await Future.delayed(Duration(seconds: 10));
    setState(() {
      show = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          show
              ? IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return MainWidget();
                    }));
                  },
                  icon: Icon(
                    Icons.close,
                    color: Colors.black,
                    size: 30,
                  ))
              : Container(),
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: widget.isshow
                ? MediaQuery.sizeOf(context).height - 150
                : MediaQuery.sizeOf(context).height - 100,
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('asset/images/payment.jpeg'),
              fit: BoxFit.fitWidth,
            )),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 60,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Free Trial Enabled',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CupertinoSwitch(
                          value: trail,
                          activeColor: ColorResources.getSecondaryColorLight(),
                          onChanged: (v) {
                            setState(() {
                              trail = v;
                            });
                          }),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (ctx) {
                      return Center(child: CircularProgressIndicator());
                    },
                  );
                  try {
                    await PurchaseApi.makePayment(
                        Platform.isIOS ? 'productive_299_w' : 'habit_499_w');

                    Navigator.pop(context);
                  } catch (e) {
                    Navigator.pop(context);
                    print(e.toString());
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: ColorResources.getSecondaryColorLight(),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) {
                        return const AlertDialog(
                          title: Text(
                            "Fetching Purchases",
                            style: TextStyle(color: Colors.black),
                          ),
                          content: SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      },
                    );

                    var cust = await Purchases.getCustomerInfo();
                    Navigator.of(context).pop();
                    if (cust.activeSubscriptions.isNotEmpty) {
                      PurchaseApi.isPaid = true;
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text(
                              "Purchase Restored",
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              "Restore Done",
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.of(context)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (_) => const MainWidget()),
                                        (route) => false),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            title: const Text(
                              "Purchase Restored",
                              style: TextStyle(color: Colors.black),
                            ),
                            content: const Text(
                              "No Purchases to Restore",
                              style: TextStyle(color: Colors.black),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Text(
                    'Restore Purchases',
                  )),
              Text(
                'Try 3 days for free,cancel anytime \n \$2.99/week',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
