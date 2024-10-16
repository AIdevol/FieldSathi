import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/expenditure_screen_controller.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
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
              'Technician',
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
    child: Obx(()=>
        ListView.separated(
            itemCount: controller.results.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10),
            itemBuilder: (context, index){
              var technician = controller.results[index];
              return GestureDetector(
                onTap: (){
                  _popUpScreenDetailsForAddingServiceScreen(controller);
                },
                child: Container(
                  height: Get.height * 0.1,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(color: whiteColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 5),
                      ),
                    ],
                    border:Border.all(
                      width: 0.80,
                      color: Colors.black,
                    ),),
                  child: ListTile(
                    title: Text('${technician.firstName} ${technician.lastName}'),
                    subtitle: Text('${technician.role}'),
                    leading: CircleAvatar(backgroundImage: AssetImage(userImageIcon)),
                  )
                ),
              );

            }
        ),)
  );
}

_listViewContainerElement(ExpenditureScreenController controller, index){
  final technicianData = controller.results[index];
  return Obx((){
    if(controller.isLoading.value){
      return Center(child: CircularProgressIndicator(),);
    }else if(controller.results.isEmpty){
      return Center(child: Text("No Data Available"),);
    }
    return Row(
        children: [
      Padding(
        padding: const EdgeInsets.only( left: 10,right: 20),
        child: CircleAvatar(radius: 35,
            backgroundImage: AssetImage(userImageIcon,)),
      ),
      hGap(10),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Text("${technicianData.firstName} ${technicianData.lastName}", style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: blackColor),),
          vGap(10),
          Text('${technicianData.role}', style: MontserratStyles.montserratSemiBoldTextStyle(size: 15, color: blackColor),),
        ],),

      )
    ]);
  });
}

void _popUpScreenDetailsForAddingServiceScreen(ExpenditureScreenController controller) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.8, // Ensures the dialog is responsive to screen size
          padding: EdgeInsets.all(24),
          color: CupertinoColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with Title and Download Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Expenditure",
                      style: MontserratStyles.montserratBoldTextStyle(size: 24, color: blackColor),
                      overflow: TextOverflow.ellipsis, // Prevent text overflow
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Add download logic here
                    },
                    icon: Icon(Icons.download, size: 24, color: Colors.black),
                  ),
                ],
              ),
              Divider(
               color: Colors.grey,
              ),
              SizedBox(height: 24),

              // Horizontally Scrollable DataTable
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Expense ID	', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Date', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Expense Type', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('From', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('To', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Amount', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Approved Amount', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Description', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Status', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Remark', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),
                    DataColumn(label: Text('Image', style: MontserratStyles.montserratBoldTextStyle(size: 16,color: Colors.black))),

                  ],
                  rows: controller.expensesData.map((technician)=>DataRow(
                    cells: [
                      DataCell(Text('')),
                      DataCell(Text('Category ')),
                      DataCell(Text('Description for Category ')),
                      DataCell(Text('Type ')),
                      DataCell(Text('2024-10-')),
                      DataCell(Text( 'Inactive')),
                      DataCell(Text( 'Inactive')),
                      DataCell(Text('Inactive')),
                      DataCell(Text( 'Inactive')),
                      DataCell(Text( 'Inactive')),
                      DataCell(Text( 'Inactive')),
                    ],
                  ),).toList()
                ),
              ),
              SizedBox(height: 24),

              // Buttons for Cancel and Submit
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add save logic here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(
                        "Submit",
                        style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// void _popUpScreenDetailsForAddingServiceScreen(ExpenditureScreenController controller) {
//   Get.dialog(
//     Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: SingleChildScrollView(
//         child: Container(color: appColor,)
//         // Container(
//         //   width: Get.width * 0.8,
//         //   padding: EdgeInsets.all(24),
//         //   child: Column(
//         //     crossAxisAlignment: CrossAxisAlignment.start,
//         //     mainAxisSize: MainAxisSize.min,
//         //     children: [
//         //       Center(
//         //         child: Text(
//         //           "Add Service Category",
//         //           style: MontserratStyles.montserratBoldTextStyle(size: 24, color: blackColor),
//         //         ),
//         //       ),
//         //       SizedBox(height: 24),
//         //       Text(
//         //         "Category Name",
//         //         style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
//         //       ),
//         //       SizedBox(height: 8),
//         //       TextField(
//         //         decoration: InputDecoration(
//         //           hintText: "Enter category name",
//         //           border: OutlineInputBorder(
//         //             borderRadius: BorderRadius.circular(8),
//         //           ),
//         //           filled: true,
//         //           fillColor: Colors.grey[100],
//         //         ),
//         //       ),
//         //       SizedBox(height: 24),
//         //       Text(
//         //         "Category Description",
//         //         style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
//         //       ),
//         //       SizedBox(height: 8),
//         //       TextField(
//         //         maxLines: 8,
//         //         decoration: InputDecoration(
//         //           hintText: "Enter category description",
//         //           border: OutlineInputBorder(
//         //             borderRadius: BorderRadius.circular(8),
//         //           ),
//         //           filled: true,
//         //           fillColor: Colors.grey[100],
//         //         ),
//         //       ),
//         //       SizedBox(height: 24),
//         //       Text(
//         //         "Category Icon",
//         //         style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
//         //       ),
//         //       SizedBox(height: 8),
//         //       Row(
//         //         children: [
//         //           InkWell(
//         //             onTap: () {
//         //               // Add icon selection logic here
//         //             },
//         //             child: Container(
//         //               width: 80,
//         //               height: 80,
//         //               decoration: BoxDecoration(
//         //                 color: Colors.grey[200],
//         //                 borderRadius: BorderRadius.circular(8),
//         //               ),
//         //               child: Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
//         //             ),
//         //           ),
//         //           SizedBox(width: 16),
//         //           Text(
//         //             "Upload Image",
//         //             style: MontserratStyles.montserratRegularTextStyle(size: 16, color: Colors.grey),
//         //           ),
//         //         ],
//         //       ),
//         //       SizedBox(height: 24),
//         //       Row(
//         //         mainAxisAlignment: MainAxisAlignment.end,
//         //         children: [
//         //           TextButton(
//         //             onPressed: () => Get.back(),
//         //             child: Text(
//         //               "Cancel",
//         //               style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
//         //             ),
//         //           ),
//         //           SizedBox(width: 16),
//         //           ElevatedButton(
//         //             onPressed: () {
//         //               // Add save logic here
//         //             },
//         //             style: ElevatedButton.styleFrom(
//         //               backgroundColor: appColor,
//         //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         //               padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         //             ),
//         //             child: Text(
//         //               "Submit",
//         //               style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
//         //             ),
//         //           ),
//         //         ],
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ),
//     ),
//   );
// }

void _popUpScreenDetailsForAddingSubServiceScreen(ExpenditureScreenController controller) {
  final List<String> categoryTypes = ['Type A', 'Type B', 'Type C', 'Type D'];
  String selectedType = categoryTypes[0];
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SingleChildScrollView(
        child: Container(
          width: Get.width * 0.8,
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  "Add Sub-Service Category",
                  style: MontserratStyles.montserratBoldTextStyle(size: 24, color: blackColor),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Sub-Category Name",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  hintText: "Enter sub-category name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Sub-Category Description",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              TextField(
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: "Enter Sub-category description",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Type",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                  color: Colors.grey[100],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: selectedType,
                    items: categoryTypes.map((String type) {
                      return DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        selectedType = newValue;
                        // You might want to use setState here if this is a StatefulWidget
                        // or use a state management solution like GetX to update the UI
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Category Icon",
                style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Add icon selection logic here
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(FontAwesomeIcons.upload, size: 32, color: appColor),
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    "Upload Image",
                    style: MontserratStyles.montserratRegularTextStyle(size: 16, color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "Cancel",
                      style: MontserratStyles.montserratMediumTextStyle(size: 16, color: Colors.grey),
                    ),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add save logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      "Submit",
                      style: MontserratStyles.montserratBoldTextStyle(size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

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


// class ServiceRequestSearchDelegate extends SearchDelegate<String> {
//   final ServiceRequestScreenController controller;
//
//   ServiceRequestSearchDelegate(this.controller);
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, '');
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // Implement your search results here
//     return Container();
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // Implement your search suggestions here
//     return Container();
//   }
// }
//


//   Widget _mainScreenWidget(ExpenditureScreenController controller){
//      return  Padding(
//        padding: const EdgeInsets.all(12.0),
//        child: Column(children: [
//          _searchBarscaffoldViewWidget(controller)
//        ],),
//      );
//   }
// }
// _searchBarscaffoldViewWidget(ExpenditureScreenController controller){
//     return Container(
//       height: Get.height * 0.2,
//       width: Get.width,
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: whiteColor,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 1,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//
//     );
