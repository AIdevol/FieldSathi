import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/const_local_keys.dart';
import '../../../../main.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class GraphViewController extends GetxController {
  RxBool isLoading = true.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;
  RxList<TicketResponseModel> ticketData = <TicketResponseModel>[].obs;


  // Ticket counts
  final RxInt totalTicketsCount = 0.obs;
  final RxInt completedTicketsCount = 0.obs;
  final RxInt ongoingTicketsCount = 0.obs;
  final RxInt rejectedTicketsCount = 0.obs;
  final RxInt inactiveTicketsCount = 0.obs;
  final RxInt onHoldTicketsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTicketsApiCall();
  }

  double getPercentage(int count) {
    if (totalTicketsCount.value == 0) return 0;
    return (count / totalTicketsCount.value) * 100;
  }

  void _calculateTicketDetails() {
    int total = 0;
    int completed = 0;
    int ongoing = 0;
    int rejected = 0;
    int inactive = 0;
    int onHold = 0;

    for (var ticket in ticketData) {
      total++;
      String status = ticket.status.toString().toLowerCase();
      print("kya bhai kya kr rhe ho ye sb: $status");

      switch (status) {
        case 'completed':
          completed++;
          break;
        case 'ongoing':
        case 'in progress':
          ongoing++;
          break;
        case 'rejected':
          rejected++;
          break;
        case 'inactive':
          inactive++;
          break;
        case 'on hold':
        case 'onhold':
          onHold++;
          break;
      }
    }

    // Update observable values
    totalTicketsCount.value = total;
    completedTicketsCount.value = completed;
    ongoingTicketsCount.value = ongoing;
    rejectedTicketsCount.value = rejected;
    inactiveTicketsCount.value = inactive;
    onHoldTicketsCount.value = onHold;

    update(); // Trigger UI update
  }

  void fetchTicketsApiCall() async {
    isLoading.value = true;
    try {
      final tickets = await Get.find<AuthenticationApiService>().getticketDetailsApiCall();
      ticketData.assignAll(tickets);
      _calculateTicketDetails();
    } catch (error) {
      toast(error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}