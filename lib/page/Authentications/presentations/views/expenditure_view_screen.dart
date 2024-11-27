import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../response_models/expenses_response_model.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ExpenditureScreen extends GetView<ExpenditureScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<ExpenditureScreenController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
              backgroundColor: appColor,
              title: Text(
                'Expenditure',
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
              ),
              actions: [
                IconButton(
                  icon: Obx(() => Icon(controller.isSearching.value ? Icons.close : Icons.search)),
                  onPressed: () {
                    controller.toggleSearch();
                  },
                ),
              ],
            ),
            body: _mainScreen(controller),
          ),
        ),
      ),
    );
  }

  Widget _mainScreen(ExpenditureScreenController controller) {
    return Column(
      children: [
        _buildTopBar(controller),
        Expanded(
          child: _containerViewScreen(controller),
        ),
      ],
    );
  }
}

Widget _buildTopBar(ExpenditureScreenController controller) {
  return Container(
    height: Get.height * 0.09,
    width: Get.width,
    decoration: BoxDecoration(
      color: whiteColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 5,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Users',
              style: MontserratStyles.montserratSemiBoldTextStyle(
                  size: 17,
                  color: Colors.black
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ),
        hGap(10),
      ],
    ),
  );
}

ButtonStyle _buttonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: appColor,
    foregroundColor: Colors.white,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    shadowColor: Colors.black.withOpacity(0.5),
  );
}

Widget _containerViewScreen(ExpenditureScreenController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.separated(
      itemCount: controller.technicianresults.length,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) => Container(
        height: Get.height * 0.1,
        width: Get.width * 0.4,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            width: 0.80,
            color: Colors.black,
          ),
        ),
        child: _listViewContainerElement(controller, index),
      ),
    ),
  );
}

Widget _listViewContainerElement(ExpenditureScreenController controller, index) {
  final technicianData = controller.technicianresults[index];
  String technicianId = technicianData.id.toString();
  return Obx(() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    } else if (controller.hasError.value) {
      return Center(child: Text('Error loading data'));
    } else if (controller.technicianresults.isEmpty) {
      return Center(child: Text('No data available'));
    } else {
      return InkWell(
        onTap: ()=>_popUpScreenDetailsForAddingServiceScreen(controller, technicianId ) ,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 20),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: technicianData.profileImage != null && technicianData.profileImage!.isNotEmpty
                    ? NetworkImage(technicianData.profileImage.toString())
                    : null,
                child: technicianData.profileImage == null || technicianData.profileImage!.isEmpty
                    ? const Icon(Icons.person, size: 35)
                    : null,
              ),
            ),
            hGap(10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${technicianData.firstName} ${technicianData.lastName}",
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 15,
                        color: blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    vGap(10),
                    Text(
                      '${technicianData.role}'.toUpperCase(),
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 13,
                        color: blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  });
}


void _popUpScreenDetailsForAddingServiceScreen(ExpenditureScreenController controller, String technicianId) {
  controller.hitGetExpenseApiCallDetails(technicianId);
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: Get.width * 0.9,
        height: Get.height * 0.8,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expenditure",
                  style: MontserratStyles.montserratBoldTextStyle(
                    size: 24,
                    color: blackColor,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Add download logic here
                  },
                  icon: const Icon(Icons.download, size: 24),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() => ExpenseDataTable(
                expenses: controller.expenseResult,
                isLoading: controller.isLoading.value,
                hasError: controller.hasError.value,
              )),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  controller.clearExpenseResults();
                  Get.back();
                },
                child: Text(
                  "Close",
                  style: MontserratStyles.montserratMediumTextStyle(
                    size: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}/*,*/
_searchScreen(ExpenditureScreenController controller){
  return Obx(() => controller.isSearching.value
      ? _buildSearchResults(controller)
      : _buildNormalContent(controller)
  );
}
Widget _buildSearchResults(ExpenditureScreenController controller) {
  // Implement your search results here
  return ListView.builder(
    itemCount: controller.searchResults.length,
    itemBuilder: (context, index) {
      // Build your search result item
      return ListTile(
        title: Text(controller.searchResults[index]),
        // Add more details or customize as needed
      );
    },
  );
}

Widget _buildNormalContent(ExpenditureScreenController controller) {
  // Implement your normal screen content here
  return Container(
    // Your existing content
  );
}


class ExpenseDataTable extends StatelessWidget {
  final List<ExpenseResult> expenses;
  final bool isLoading;
  final bool hasError;

  const ExpenseDataTable({
    Key? key,
    required this.expenses,
    required this.isLoading,
    required this.hasError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (hasError) {
      return const Center(child: Text('No expenses found'));
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 20,
          headingRowHeight: 50,
          dataRowHeight: 60,
          columns: _buildColumns(),
          rows: _buildRows(),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _buildColumns() {
    final headerStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.black87,
    );

    return [
      DataColumn(
        label: Text('ID', style: headerStyle),
        tooltip: 'Expense ID',
      ),
      DataColumn(
        label: Text('Date', style: headerStyle),
        tooltip: 'Expense Date',
      ),
      DataColumn(
        label: Text('Type', style: headerStyle),
        tooltip: 'Expense Type',
      ),
      DataColumn(
        label: Text('From', style: headerStyle),
        tooltip: 'Starting Location',
      ),
      DataColumn(
        label: Text('To', style: headerStyle),
        tooltip: 'Destination',
      ),
      DataColumn(
        label: Text('Amount', style: headerStyle),
        tooltip: 'Expense Amount',
        numeric: true,
      ),
      DataColumn(
        label: Text('Approved', style: headerStyle),
        tooltip: 'Approved Amount',
        numeric: true,
      ),
      DataColumn(
        label: Text('Status', style: headerStyle),
        tooltip: 'Expense Status',
      ),
      DataColumn(
        label: Text('Actions', style: headerStyle),
        tooltip: 'Available Actions',
      ),
    ];
  }

  List<DataRow> _buildRows() {
    return expenses.map((expense) {
      return DataRow(
        cells: [
          DataCell(Text('#${expense.id}')),
          DataCell(Text(_formatDate(expense.date))),
          DataCell(Text(expense.expenseType)),
          DataCell(Text(expense.fromField)),
          DataCell(Text(expense.to)),
          DataCell(Text('₹${expense.amount}')),
          DataCell(Text(expense.approvedAmount ?? '-')),
          DataCell(_buildStatusCell(expense.status)),
          DataCell(_buildActionsCell(expense)),
        ],
      );
    }).toList();
  }

  Widget _buildStatusCell(String status) {
    Color backgroundColor;
    Color textColor = Colors.white;

    switch (status.toLowerCase()) {
      case 'approved':
        backgroundColor = Colors.green;
        break;
      case 'pending':
        backgroundColor = Colors.orange;
        break;
      case 'rejected':
        backgroundColor = Colors.red;
        break;
      default:
        backgroundColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildActionsCell(ExpenseResult expense) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.visibility, size: 20),
          onPressed: () => _viewExpenseDetails(expense),
          tooltip: 'View Details',
        ),
        if (expense.image.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.image, size: 20),
            onPressed: () => _viewExpenseImage(expense),
            tooltip: 'View Receipt',
          ),
      ],
    );
  }

  String _formatDate(String date) {
    try {
      final DateTime dateTime = DateTime.parse(date);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return date;
    }
  }

  void _viewExpenseDetails(ExpenseResult expense) {
    Get.dialog(
      AlertDialog(
        title: Text('Expense Details #${expense.id}'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Date', _formatDate(expense.date)),
              _buildDetailRow('Type', expense.expenseType),
              _buildDetailRow('From', expense.fromField),
              _buildDetailRow('To', expense.to),
              _buildDetailRow('Amount', '₹${expense.amount}'),
              _buildDetailRow('Status', expense.status),
              _buildDetailRow('Description', expense.description),
              if (expense.approvedAmount != null)
                _buildDetailRow('Approved Amount', '₹${expense.approvedAmount}'),
              if (expense.paidRemark != null)
                _buildDetailRow('Remarks', expense.paidRemark!),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _viewExpenseImage(ExpenseResult expense) {
    Get.dialog(
      Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppBar(
              title: Text('Receipt #${expense.id}'),
              leading: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Get.back(),
              ),
            ),
            Flexible(
              child: Image.network(
                expense.image,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text('Failed to load image'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}