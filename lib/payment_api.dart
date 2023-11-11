import 'dart:developer';
import 'dart:io';

import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static const _apiKeyAndroid = 'goog_ekHaeWdEngqdVOQaUcDjIkFtcAx';
  static const _apiKeiIos = 'appl_gozuRQYarkhqUVnhNEgIGxgXOdO';
  static bool isPaid = false;

  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    await Purchases.configure(
      PurchasesConfiguration(Platform.isIOS ? _apiKeiIos : _apiKeyAndroid),
    );
    await Purchases.getCustomerInfo().then((value) {
      print('User Purchased: ${value.entitlements.active.isNotEmpty}');
      isPaid = value.entitlements.active.isNotEmpty;
    });
  }

  static Future makePayment(String productname) async {
    try {
      await Purchases.purchaseProduct(productname);
      PurchaseApi.isPaid = true;
    } catch (e) {
      log(e.toString());
    }
  }
}
