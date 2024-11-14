import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PricingViewController extends GetxController {

  late Razorpay _razorpay;
  final selectedPlan = ''.obs;
  final amount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    _razorpay.clear();
    super.onClose();
  }

  void selectPlan(String plan, int planAmount) {
    selectedPlan.value = plan;
    amount.value = planAmount;
  }

  void startPayment() {
    var options = {
      'key': 'rzp_test_2P38XNePtDYveW',
      'amount': amount.value ==0
          ?400* 100
          :amount.value==1
          ?500 *100
          :600*100,// Razorpay expects amount in paise
      'name': 'Devesh Tiwari',
      'description': 'Payment for ${selectedPlan.value} Plan',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
      'Payment Successful',
      'Payment ID: ${response.paymentId}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    // TODO: Implement your logic after successful payment
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    toast('Payment failed please try again');
    // Get.snackbar(
    //   'Payment Failed',
    //   'Error: ${response.message}',
    //   snackPosition: SnackPosition.BOTTOM,
    //   backgroundColor: Colors.red,
    //   colorText: Colors.white,
    // );
    // TODO: Implement your logic for payment failure
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      'External Wallet Selected',
      'Wallet: ${response.walletName}',
      snackPosition: SnackPosition.BOTTOM,
    );
    // TODO: Implement your logic for external wallet selection
  }
}