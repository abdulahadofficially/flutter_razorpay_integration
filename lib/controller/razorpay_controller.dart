import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayController extends GetxController {
  late Razorpay _razorpay;
  final amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _onPaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _onPaymentFailure);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _onPaymentExtrnalWallet);
  }

  void proceedToPayment() async {
    if (amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter Amount');
      return;
    }
    int amount = int.parse(amountController.text) * 100;
    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': amount,
      'name': 'Abdul Ahad',
      'description': 'Test Payment',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '123456789', 'email': 'abc@gmail.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      log('Error: ${e.toString}');
    }
  }

  void _onPaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'Payment Successfully');
  }

  void _onPaymentFailure(PaymentFailureResponse response) {
    Fluttertoast.showToast(msg: 'Payment Failed.. Try Again');
  }

  void _onPaymentExtrnalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'Extrnal Wallet : ${response.walletName}');
  }

  @override
  void onClose() {
    super.onClose();
    _razorpay.clear();
  }
}
