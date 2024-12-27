import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:tms_sathi/main.dart';
import '../../../../response_models/ticket_response_model.dart';
import '../../../../services/APIs/auth_services/auth_api_services.dart';

class GraphViewController extends GetxController {
  RxBool isLoading = true.obs;
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;

  // Store the ticket response model
  Rx<TicketResponseModel?> ticketData = Rx<TicketResponseModel?>(null);

  // Ticket counts
  final RxInt totalTicketsCount = 0.obs;
  final RxInt completedTicketsCount = 0.obs;
  final RxInt ongoingTicketsCount = 0.obs;
  final RxInt rejectedTicketsCount = 0.obs;
  final RxInt inactiveTicketsCount = 0.obs;
  final RxInt onHoldTicketsCount = 0.obs;
  final RxInt acceptedTicketsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    hitTicketCountsApiCall();
    fetchTicketsApiCall();
  }

  double getPercentage(int count) {
    if (totalTicketsCount.value == 0) return 0;
    return (count / totalTicketsCount.value) * 100;
  }

  // void _calculateTicketDetails() {
  //   if (ticketData.value == null) return;
  //
  //   // First, calculate the individual status counts
  //   completedTicketsCount.value = ticketData.value!.results
  //       .where((ticket) => ticket.status.toLowerCase() == 'completed')
  //       .length;
  //
  //   ongoingTicketsCount.value = ticketData.value!.results
  //       .where((ticket) =>
  //   ticket.status.toLowerCase() == 'ongoing' ||
  //       ticket.status.toLowerCase() == 'in progress')
  //       .length;
  //
  //   rejectedTicketsCount.value = ticketData.value!.results
  //       .where((ticket) => ticket.status.toLowerCase() == 'rejected')
  //       .length;
  //
  //   inactiveTicketsCount.value = ticketData.value!.results
  //       .where((ticket) => ticket.status.toLowerCase() == 'inactive')
  //       .length;
  //
  //   onHoldTicketsCount.value = ticketData.value!.results
  //       .where((ticket) =>
  //   ticket.status.toLowerCase() == 'on hold' ||
  //       ticket.status.toLowerCase() == 'onhold')
  //       .length;
  //
  //   // Set total from the API response
  //   totalTicketsCount.value = ticketData.value!.count;
  //
  //   // Debug logging to verify calculations
  //   print('API Total Count: ${totalTicketsCount.value}');
  //   print('Completed: ${completedTicketsCount.value}');
  //   print('Ongoing: ${ongoingTicketsCount.value}');
  //   print('Rejected: ${rejectedTicketsCount.value}');
  //   print('Inactive: ${inactiveTicketsCount.value}');
  //   print('On Hold: ${onHoldTicketsCount.value}');
  //   print('Sum of statuses: ${
  //       completedTicketsCount.value +
  //           ongoingTicketsCount.value +
  //           rejectedTicketsCount.value +
  //           inactiveTicketsCount.value +
  //           onHoldTicketsCount.value
  //   }');
  //
  //   update(); // Trigger UI update
  // }

  void fetchTicketsApiCall() async {
    isLoading.value = true;
    try {
      final response = await Get.find<AuthenticationApiService>().getticketDetailsApiCall();
      ticketData.value = response;

      if (ticketData.value != null) {
        print('Received ${ticketData.value!.results?.length} tickets');
        print('Total count from API: ${ticketData.value!.count}');

        // Log all statuses to debug
        ticketData.value!.results?.forEach((ticket) {
          // print('Ticket ID: ${ticket?.id}, Status: ${ticket?.status}');
        });
      }

      // _calculateTicketDetails();

    } catch (error) {
      toast('Error fetching ticket details: ${error.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void hitTicketCountsApiCall(){
    isLoading.value = true;
    customLoader.show();
    FocusManager.instance.primaryFocus!.unfocus();
    Get.find<AuthenticationApiService>().getTicketCountsApiCall().then((value){
      totalTicketsCount.value = value.total!;
      completedTicketsCount.value = value.completed!;
      ongoingTicketsCount.value = value.ongoing!;
      inactiveTicketsCount.value = value.inactive!;
      onHoldTicketsCount.value = value.onHold!;
      rejectedTicketsCount.value = value.rejected!;
      acceptedTicketsCount.value =value.accepted!;
    }).onError((error, stackError){
      toast(error.toString());
      customLoader.hide();
    });
  }

  Future<void>refreshTicketData()async{
    fetchTicketsApiCall();
    hitTicketCountsApiCall();
  }
}