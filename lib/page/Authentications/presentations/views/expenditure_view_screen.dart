import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/constans/role_based_keys.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';
import 'package:tms_sathi/response_models/technician_response_model.dart';
import 'package:tms_sathi/utilities/hex_color.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/expenses_response_model.dart';
import '../../../../utilities/customer_showModel_expense.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';

class ExpenditureScreen extends GetView<ExpenditureScreenController>{
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<ExpenditureScreenController>(
          builder: (controller) => Scaffold(
            backgroundColor: CupertinoColors.white,
            floatingActionButton: _buildFloatingActionButton(context,controller),
            appBar: AppBar(
              leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
              backgroundColor: appColor,
              title: Text(
                'Expenses',
                style: MontserratStyles.montserratBoldTextStyle(color: blackColor, size: 15),
              ),
            ),
            body: RefreshIndicator(onRefresh:()async{
              controller.refreshApiCall();
            },child: _mainScreen(controller)),
          ),
        ),
      ),
    );
  }

  Widget _mainScreen(ExpenditureScreenController controller) {
    final currentUser = storage.read(userRole);
    return Column(
      children: [
        _buildTopBar(controller),
        (currentUser != 'technician'&&currentUser != 'sales')?
         Expanded(
          child: _containerViewScreen(controller),
        )
        : Expanded(child: _buildExpenseContent(controller))
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
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListView.separated(
      itemCount: controller.technicianresults.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            width: 1,
            color: Colors.grey.shade200,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: _listViewContainerElement(controller, index),
        ),
      ),
    ),
  );
}

_buildEmptyState() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          nullVisualImage,
          width: 300,
          height: 300,
        ),
        Text(
          'No services found',
          style: MontserratStyles.montserratNormalTextStyle(
            // size: 18,
            color: blackColor,
          ),
        ),
      ],
    ),
  );
}
Widget _listViewContainerElement(ExpenditureScreenController controller, index) {
  final technicianData = controller.technicianresults[index];
  String technicianId = technicianData.id.toString();
  return Obx(() {
    if (controller.hasError.value) {
      return Center(child: Text('Error loading data'));
    } else if (controller.technicianresults.isEmpty) {
      return _buildEmptyState();
    } else {
      return InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: ()=> Get.to(() => ExpenseTableView(technicianId: technicianId,)), /*_popUpScreenDetailsForAddingServiceScreen(controller, technicianId)*/
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Hero(
                tag: 'technician_avatar_$technicianId',
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: appColor.withOpacity(0.1),
                  backgroundImage: technicianData.profileImage != null && technicianData.profileImage!.isNotEmpty
                      ? NetworkImage(technicianData.profileImage.toString())
                      : null,
                  child: technicianData.profileImage == null || technicianData.profileImage!.isEmpty
                      ? Icon(Icons.person, size: 35, color: appColor)
                      : null,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${technicianData.firstName} ${technicianData.lastName}",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 16,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${technicianData.role}'.toUpperCase(),
                      style: MontserratStyles.montserratSemiBoldTextStyle(
                        size: 14,
                        color: HexColor("757575"),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Material(
                color: appColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                // elevation: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  decoration: BoxDecoration(
                    color: appColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(technicianData.id.toString()),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  });
}



class ExpenseTableView extends GetView<ExpenditureScreenController> {
  final String? technicianId;
  const ExpenseTableView({Key? key, this.technicianId}):super(key:key);
  @override
  Widget build(BuildContext context) {
    if (technicianId != null){
      controller.hitGetExpenseApiCallDetails(technicianId!);
    }
    return MyAnnotatedRegion(
      child: GetBuilder<ExpenditureScreenController>(
        init: ExpenditureScreenController(),
        builder: (controller)=>
         Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CupertinoColors.white,
          appBar: AppBar(
            title: Text(
              'Expenditure',
              style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 15
              ),
            ),
            leading: IconButton(onPressed: (){Get.back();},icon: Icon(Icons.arrow_back_ios, color: Colors.black,)),
            backgroundColor: appColor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _showExportDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CupertinoColors.white,
                    minimumSize: Size(100, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Export",style: MontserratStyles.montserratSemiBoldTextStyle(
                          color: appColor,
                          size: 13
                      )),
                      Icon(Icons.download,size: 18,color: appColor,)
                    ],
                  ),
                ),
              )
            ],
          ),
          body: RefreshIndicator(onRefresh: ()async {
            controller.refreshExpenseApiCall(technicianId!);
          },
          child: Obx(() => _buildExpenseContent(controller))),
        ),
      ),
    );
  }

}

Widget _buildExpenseContent(ExpenditureScreenController controller) {

  if (controller.hasError.value) {
    return Center(child: Text('Error loading expenses'));
  }

  if (controller.expenseResult.isEmpty) {
    return _buildEmptyState();
  }

  return _buildExpenseTable(controller);
}

Widget _buildExpenseTable(ExpenditureScreenController controller) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 20,
        headingRowColor: MaterialStateColor.resolveWith(
                (states) => appColor.withOpacity(0.1)
        ),
        columns: [
          DataColumn(label: Text('Expense ID', style: _headerTextStyle())),
          DataColumn(label: Text('Ticket ID',style: _headerTextStyle(),)),
          DataColumn(label: Text('Date', style: _headerTextStyle())),
          DataColumn(label: Text('Expense Type', style: _headerTextStyle())),
          DataColumn(label: Text('From', style: _headerTextStyle())),
          DataColumn(label: Text('To', style: _headerTextStyle())),
          DataColumn(label: Text('Expense Date', style: _headerTextStyle())),
          DataColumn(label: Text('Amount', style: _headerTextStyle())),
          DataColumn(label: Text('Approved Amount', style: _headerTextStyle())),
          DataColumn(label: Text('Description', style: _headerTextStyle())),
          DataColumn(label: Text('Status', style: _headerTextStyle())),
          DataColumn(label: Text('Remark', style: _headerTextStyle())),
          DataColumn(label: Text('Image', style: _headerTextStyle())),
          DataColumn(label: Text('Action', style: _headerTextStyle())),

        ],
        rows: _buildExpenseRows(controller),
      ),
    ),
  );
}

List<DataRow> _buildExpenseRows(ExpenditureScreenController controller) {
  return controller.expenseResult.map((expense) {
    return _createExpenseRow(
        expenseId: expense.id.toString(),
        ticketId:expense.ticket!.id.toString(),
        date: expense.date.toString(),
        expenseType: expense.expenseType.toString(),
        from: expense!.fromField.toString(),
        to: expense.to.toString(),
        expenseDate: expense.expenseDate.toString(),
        amount: expense.amount.toString(),
        approvedAmount: expense.approvedAmount.toString(),
        description: expense.description.toString(),
        status: expense.status.toString(),
        remark: expense.approvedRemark.toString(),
        image: expense.image.toString(),
        controller: ExpenditureScreenController()
    );
  }).toList();
}

DataRow _createExpenseRow({
  required String expenseId,
  required String ticketId,
  required String date,
  required String expenseType,
  required String from,
  required String to,
  required String expenseDate,
  required String amount,
  required String approvedAmount,
  required String description,
  required String status,
  required String remark,
  required String image,
  required ExpenditureScreenController controller,
}) {
  return DataRow(cells: [
    DataCell(Text(expenseId, style: _cellTextStyle())),
    DataCell(Text(ticketId, style: _cellTextStyle(),)),
    DataCell(Text(date, style: _cellTextStyle())),
    DataCell(Text(expenseType, style: _cellTextStyle())),
    DataCell(Text(from, style: _cellTextStyle())),
    DataCell(Text(to, style: _cellTextStyle())),
    DataCell(Text(expenseDate, style: _cellTextStyle())),
    DataCell(Text('₹$amount', style: _cellTextStyle())),
    DataCell(Text('₹$approvedAmount', style: _cellTextStyle())),
    DataCell(Text(description, style: _cellTextStyle())),
    DataCell(_buildStatusChip(status)),
    DataCell(Text(remark, style: _cellTextStyle())),
    DataCell(Row(
      children: [
        Text(image, style: _cellTextStyle()),
        if (image.isNotEmpty)
          IconButton(
            icon: Icon(Icons.download, color: appColor, size: 20),
            onPressed: () {},
          ),
      ],
    )),
    DataCell(
        _addTicketViewButton(controller,expenseId)
      // IconButton(
      //   icon: Icon(Icons.remove_red_eye, color: appColor),
      //   onPressed: () {
      //     _showExpenseDetailsDialog(expenseId);
      //   },
      // ),
    ),
  ]);
}

_addTicketViewButton(ExpenditureScreenController controller,String expenseId) {
  return ElevatedButton(onPressed: () {
    _showExpenseDetailsDialog(controller, expenseId);
  },
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        minimumSize: Size(130, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text("Update Status",style: MontserratStyles.montserratBoldTextStyle(
        color: whiteColor,
        size: 13,)));
}

Widget _buildStatusChip(String status) {
  Color chipColor;
  switch (status.toLowerCase()) {
    case 'approved':
      chipColor = Colors.green;
      break;
    case 'pending':
      chipColor = Colors.orange;
      break;
    case 'rejected':
      chipColor = Colors.red;
      break;
    default:
      chipColor = Colors.grey;
  }

  return Chip(
    label: Text(
      status,
      style: TextStyle(color: Colors.white, fontSize: 12),
    ),
    backgroundColor: chipColor,
  );
}

void _showExpenseDetailsDialog(ExpenditureScreenController controller,String expenseId) {
  final expense = controller.expenseResult.firstWhere(
          (exp) => exp.id == expenseId,
      orElse: () => throw Exception('Expense not found')
  );

  Get.dialog(
    AlertDialog(
      title: Text('Expense Details - $expenseId'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Expense Type', expense.expenseType.toString()),
            _buildDetailRow('Date', expense.date.toString()),
            _buildDetailRow('From', expense.fromField.toString()),
            _buildDetailRow('To', expense.to.toString()),
            _buildDetailRow('Total Amount', '₹${expense.amount}'),
            _buildDetailRow('Approved Amount', '₹${expense.approvedAmount}'),
            _buildDetailRow('Description', expense.description.toString()),
            _buildDetailRow('Status', expense.status.toString()),
            _buildDetailRow('Remark', expense.approvedRemark.toString()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('Close'),
        ),
      ],
    ),
  );
}

Widget _buildDetailRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: MontserratStyles.montserratBoldTextStyle(
              color: Colors.black87,
              size: 14
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: MontserratStyles.montserratSemiBoldTextStyle(
                color: Colors.black,
                size: 14
            ),
          ),
        ),
      ],
    ),
  );
}

void _showExportDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Export Expenses'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Export as CSV'),
              onTap: () {
                // controller.exportExpenses('CSV');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Export as PDF'),
              onTap: () {
                // controller.exportExpenses('PDF');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

TextStyle _headerTextStyle() {
  return MontserratStyles.montserratBoldTextStyle(
      color: Colors.black87,
      size: 14
  );
}

TextStyle _cellTextStyle() {
  return MontserratStyles.montserratSemiBoldTextStyle(
      color: Colors.black54,
      size: 13
  );
}

 _buildFloatingActionButton(BuildContext context, ExpenditureScreenController controller) {
  final userrole = storage.read(userRole);

  if (userrole == 'technician') {
    return Row(
       mainAxisAlignment: MainAxisAlignment.end,
       children: [
         ElevatedButton(
          onPressed: () {
            // _leavesTypesApplicationViewScreen(context, controller);
            Get.dialog(
                Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: AddExpenseForm(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            minimumSize: Size(120, 40),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: CupertinoColors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            " Add ",
            style: MontserratStyles.montserratBoldTextStyle(
              color: CupertinoColors.white,
              size: 13,
            ),
          ),
             ),
          hGap(10),
         if (userrole == 'technician')
         ElevatedButton(
          onPressed: () {
            // _leavesTypesApplicationViewScreen(context, controller);
            controller.downLoadExportModelView(context, controller);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: appColor,
            minimumSize: Size(120, 40),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: CupertinoColors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            "Export",
            style: MontserratStyles.montserratBoldTextStyle(
              color: CupertinoColors.white,
              size: 15,
            ),
          ),
             ),
       ],
     );
  }
  }
