// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:pluto_grid/pluto_grid.dart';
// import 'package:tms_sathi/constans/color_constants.dart';
// import 'package:tms_sathi/navigations/navigation.dart';
// import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
// import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
// import 'package:tms_sathi/response_models/leaves_response_model.dart';
// import 'package:intl/intl.dart';
//
// import '../../../home/widget/leave_update_screen.dart';
//
// class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController> {
//   late final PlutoGridStateManager stateManager;
//
//   final List<PlutoColumn> columns = [
//     PlutoColumn(
//       title: 'Sr. No.',
//       field: 'srNo',
//       type: PlutoColumnType.number(),
//       width: 70,
//       frozen: PlutoColumnFrozen.start,
//     ),
//     PlutoColumn(
//       title: 'Name',
//       field: 'name',
//       type: PlutoColumnType.text(),
//       width: 150,
//     ),
//     PlutoColumn(
//       title: 'Phone',
//       field: 'phone',
//       type: PlutoColumnType.text(),
//       width: 120,
//     ),
//     PlutoColumn(
//       title: 'Role',
//       field: 'role',
//       type: PlutoColumnType.text(),
//       width: 100,
//     ),
//     PlutoColumn(
//       title: 'From Date',
//       field: 'fromDate',
//       type: PlutoColumnType.date(),
//       width: 110,
//     ),
//     PlutoColumn(
//       title: 'To Date',
//       field: 'toDate',
//       type: PlutoColumnType.date(),
//       width: 110,
//     ),
//     PlutoColumn(
//       title: 'Days',
//       field: 'days',
//       type: PlutoColumnType.number(),
//       width: 70,
//     ),
//     PlutoColumn(
//       title: 'Reason',
//       field: 'reason',
//       type: PlutoColumnType.text(),
//       width: 200,
//     ),
//     PlutoColumn(
//       title: 'Status',
//       field: 'status',
//       type: PlutoColumnType.text(),
//       width: 100,
//     ),
//     PlutoColumn(
//       title: 'Leave Type',
//       field: 'leaveType',
//       type: PlutoColumnType.text(),
//       width: 120,
//     ),
//     PlutoColumn(
//       title: 'Actions',
//       field: 'actions',
//       type: PlutoColumnType.text(),
//       width: 100,
//       renderer: (rendererContext) {
//         return ElevatedButton(onPressed: (){}, child: Text('Update Status', style: MontserratStyles.montserratSemiBoldTextStyle(size: 13, color: Colors.black),));
//         /*IconButton(
//           icon: Icon(Icons.info),
//           onPressed: () {}*//*=> controller.showLeaveDetails(
//             controller.filteredLeaves[rendererContext.rowIdx],
//           ),*//*
//         );*/
//       },
//     ),
//   ];
//
//   List<PlutoRow> getRows(List<Results> leaves) {
//     return leaves.asMap().entries.map((entry) {
//       final index = entry.key;
//       final leave = entry.value;
//       return PlutoRow(cells: {
//         'srNo': PlutoCell(value: index + 1),
//         'name': PlutoCell(value: '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'),
//         'phone': PlutoCell(value: leave.userId?.phoneNumber ?? ''),
//         'role': PlutoCell(value: leave.userId?.role ?? ''),
//         'fromDate': PlutoCell(value: DateTime.parse(leave.startDate ?? '')),
//         'toDate': PlutoCell(value: DateTime.parse(leave.endDate ?? '')),
//         'days': PlutoCell(value: controller.calculateDays(
//           DateTime.parse(leave.startDate ?? ''),
//           DateTime.parse(leave.endDate ?? ''),
//         )),
//         'reason': PlutoCell(value: leave.reason ?? ''),
//         'status': PlutoCell(value: leave.status ?? ''),
//         'leaveType': PlutoCell(value: leave.leaveType ?? ''),
//         'actions': PlutoCell(value: ''),
//       });
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: appColor,
//         title: Text('Leaves',
//             style: MontserratStyles.montserratBoldTextStyle(
//                 size: 18,
//                 color: Colors.black
//             )
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.refresh),
//             onPressed: controller.hitLeavesApiCall,
//           ),
//           IconButton(
//             icon: Icon(Icons.add, size: 30),
//             onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           _buildTopBar(),
//           _buildSearchBar(),
//           Expanded(
//             child: Obx(() => controller.isLoading.value
//                 ? Center(child: CircularProgressIndicator())
//                 : _buildPlutoGrid()),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTopBar() {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(child: _buildFilterDropdown()),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildFilterDropdown() {
//     return Obx(() => DropdownButton(
//       value: controller.selectedFilter.value,
//       items: controller.filterTypes.map((String value) {
//         return DropdownMenuItem(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//       onChanged: (String? value) {
//         controller.updateSelectedFilter(value);
//         _updateGridFilter();
//       },
//     ));
//   }
//
//   Widget _buildSearchBar() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: TextField(
//         onChanged: (value) {
//           controller.updateSearchQuery(value);
//           _updateGridFilter();
//         },
//         decoration: const InputDecoration(
//           labelText: 'Search',
//           prefixIcon: Icon(Icons.search),
//           border: OutlineInputBorder(),
//         ),
//       ),
//     );
//   }
//
//   void _updateGridFilter() {
//     if (stateManager != null) {
//       stateManager.setFilter((row) {
//         final searchQuery = controller.searchQuery.value.toLowerCase();
//         final filter = controller.selectedFilter.value;
//
//         bool matchesSearch = true;
//         if (searchQuery.isNotEmpty) {
//           matchesSearch = row.cells.values.any((cell) =>
//               cell.value.toString().toLowerCase().contains(searchQuery)
//           );
//         }
//
//         bool matchesFilter = true;
//         if (filter != 'All') {
//           matchesFilter = row.cells['status']!.value.toString() == filter;
//         }
//
//         return matchesSearch && matchesFilter;
//       });
//     }
//   }
//
//   Widget _buildPlutoGrid() {
//     return PlutoGrid(
//       columns: columns,
//       rows: getRows(controller.filteredLeaves),
//       onLoaded: (PlutoGridOnLoadedEvent event) {
//         stateManager = event.stateManager;
//       },
//       configuration: PlutoGridConfiguration(
//         columnSize: PlutoGridColumnSizeConfig(
//           autoSizeMode: PlutoAutoSizeMode.scale,
//         ),
//         style: PlutoGridStyleConfig(
//           gridBorderColor: Colors.grey.shade300,
//           gridBackgroundColor: Colors.white,
//           rowHeight: 70,
//           // columnHeight: 70,
//           columnTextStyle: MontserratStyles.montserratBoldTextStyle(
//             size: 13,
//             color: Colors.black,
//           ),
//           cellTextStyle: MontserratStyles.montserratSemiBoldTextStyle(
//             size: 12,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/constans/color_constants.dart';
import 'package:tms_sathi/navigations/navigation.dart';
import 'package:tms_sathi/utilities/common_textFields.dart';
import 'package:tms_sathi/utilities/google_fonts_textStyles.dart';
import 'package:tms_sathi/page/Authentications/presentations/controllers/LeaveReportViewScreenController.dart';
import 'package:tms_sathi/response_models/leaves_response_model.dart';
import 'package:intl/intl.dart';
import 'package:tms_sathi/utilities/helper_widget.dart';

import '../../../home/widget/leave_update_screen.dart';

class LeaveReportViewScreen extends GetView<LeaveReportViewScreenController> {
  late final PlutoGridStateManager stateManager;

  final List<PlutoColumn> columns = [
    PlutoColumn(
      title: 'No.',
      field: 'srNo',
      type: PlutoColumnType.number(),
      width: 80,
      frozen: PlutoColumnFrozen.start,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Name',
      field: 'name',
      type: PlutoColumnType.text(),
      width: 180,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Phone',
      field: 'phone',
      type: PlutoColumnType.text(),
      width: 150,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Role',
      field: 'role',
      type: PlutoColumnType.text(),
      width: 120,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'From Date',
      field: 'fromDate',
      type: PlutoColumnType.date(),
      width: 130,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'To Date',
      field: 'toDate',
      type: PlutoColumnType.date(),
      width: 130,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Days',
      field: 'days',
      type: PlutoColumnType.number(),
      width: 80,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Reason',
      field: 'reason',
      type: PlutoColumnType.text(),
      width: 250,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Leave',
      field: 'leaveType',
      type: PlutoColumnType.text(),
      width: 140,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),
    PlutoColumn(
      title: 'Status',
      field: 'status',
      type: PlutoColumnType.text(),
      width: 120,
      titleTextAlign: PlutoColumnTextAlign.center,
      textAlign: PlutoColumnTextAlign.center,
    ),

    // PlutoColumn(
    //   title: 'Actions',
    //   field: 'actions',
    //   type: PlutoColumnType.text(),
    //   width: 150,
    //   titleTextAlign: PlutoColumnTextAlign.center,
    //   textAlign: PlutoColumnTextAlign.center,
    //   renderer: (rendererContext) {
    //     return Center(
    //       child: Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 4.0),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             _openDropDownFieldforStatusSubmitions();
    //           },
    //           style: ElevatedButton.styleFrom(
    //             backgroundColor: appColor,
    //             minimumSize: Size(130, 40),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(8),
    //             ),
    //           ),
    //           child: Text(
    //             'Update Status',
    //             style: MontserratStyles.montserratSemiBoldTextStyle(
    //               size: 12,
    //               color: Colors.black,
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // ),
  ];

  List<PlutoRow> getRows(List<Results> leaves) {
    return leaves.asMap().entries.map((entry) {
      final index = entry.key;
      final leave = entry.value;
      return PlutoRow(cells: {
        'srNo': PlutoCell(value: index + 1),
        'name': PlutoCell(value: '${leave.userId?.firstName ?? ''} ${leave.userId?.lastName ?? ''}'),
        'phone': PlutoCell(value: leave.userId?.phoneNumber ?? ''),
        'role': PlutoCell(value: leave.userId?.role ?? ''),
        'fromDate': PlutoCell(value: DateTime.parse(leave.startDate ?? '')),
        'toDate': PlutoCell(value: DateTime.parse(leave.endDate ?? '')),
        'days': PlutoCell(value: controller.calculateDays(
          DateTime.parse(leave.startDate ?? ''),
          DateTime.parse(leave.endDate ?? ''),
        )),
        'reason': PlutoCell(value: leave.reason ?? ''),
        'leaveType': PlutoCell(value: leave.leaveType ?? ''),
        'status': PlutoCell(value: leave.status ?? ''),
        // 'actions': PlutoCell(value: ''),
      });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: Text(
          'Leaves',
          style: MontserratStyles.montserratBoldTextStyle(
            size: 18,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: controller.hitLeavesApiCall,
          ),
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () => Get.toNamed(AppRoutes.leaveUpdateScreen),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTopBar(),
          _buildSearchBar(),
          Expanded(
            child: Obx(
                  () => controller.isLoading.value
                  ? Center(child: Container())
                  : _buildPlutoGrid(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(child: _buildFilterDropdown()),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Obx(
          () => DropdownButton<String>(
          value: controller.selectedFilter.value,
          items: controller.filterTypes.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: MontserratStyles.montserratSemiBoldTextStyle(
                size: 14,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          controller.updateSelectedFilter(value);
          _updateGridFilter();
        },
        style: MontserratStyles.montserratRegularTextStyle(
          size: 14,
          color: Colors.black,
        ),
        icon: Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
        underline: Container(
          height: 1,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        onChanged: (value) {
          controller.updateSearchQuery(value);
          _updateGridFilter();
        },
        style: MontserratStyles.montserratSemiBoldTextStyle(
          size: 14,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: 'Search',
          labelStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 14,
            color: Colors.grey,
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.black,)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: appColor),
          ),
        ),
      ),
    );
  }

  void _updateGridFilter() {
    if (stateManager != null) {
      stateManager.setFilter((row) {
        final searchQuery = controller.searchQuery.value.toLowerCase();
        final filter = controller.selectedFilter.value;

        bool matchesSearch = true;
        if (searchQuery.isNotEmpty) {
          matchesSearch = row.cells.values.any((cell) =>
              cell.value.toString().toLowerCase().contains(searchQuery));
        }

        bool matchesFilter = true;
        if (filter != 'All') {
          matchesFilter = row.cells['status']!.value.toString() == filter;
        }

        return matchesSearch && matchesFilter;
      });
    }
  }

  Widget _buildPlutoGrid() {
    return PlutoGrid(
      columns: columns,
      rows: getRows(controller.filteredLeaves),
      onLoaded: (PlutoGridOnLoadedEvent event) {
        stateManager = event.stateManager;
      },
      configuration: PlutoGridConfiguration(
        columnSize: PlutoGridColumnSizeConfig(
          autoSizeMode: PlutoAutoSizeMode.none,
        ),
        style: PlutoGridStyleConfig(
          gridBorderColor: Colors.grey.shade300,
          gridBackgroundColor: Colors.white,
          rowHeight: 60,
          columnHeight: 50,
          columnTextStyle: MontserratStyles.montserratBoldTextStyle(
            size: 13,
            color: Colors.black,
          ),
          cellTextStyle: MontserratStyles.montserratSemiBoldTextStyle(
            size: 12,
            color: Colors.black,
          ),
          defaultCellPadding: EdgeInsets.symmetric(horizontal: 10),
          gridBorderRadius: BorderRadius.circular(8),
        ),
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            ...FilterHelper.defaultFilters,
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            if (column.field == 'srNo') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            } else if (column.field == 'fromDate' || column.field == 'toDate') {
              return resolver<PlutoFilterTypeGreaterThan>() as PlutoFilterType;
            }
            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
    );
  }


}

_openDropDownFieldforStatusSubmitions(){
  final controller  = Get.put(LeaveReportViewScreenController());
  return Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        height: Get.height * 0.3,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Update Status", style: MontserratStyles.montserratBoldTextStyle(size: 20, color: Colors.black),),
            vGap(30),
            CustomTextField(
              controller: TextEditingController(
                  text: controller.defaultSelectedStatus.value
              ),
              hintText: 'Select Status',
              labletext: 'Select Status',
              suffix: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Obx(()=>DropdownButton<String>(
                  value: controller.defaultSelectedStatus.value,
                  items: controller.selectedStatus.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: MontserratStyles.montserratSemiBoldTextStyle(
                          size: 14,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    controller.updateSelectedStatus(value);
                    // _updateGridFilter();
                  },
                  style: MontserratStyles.montserratRegularTextStyle(
                    size: 14,
                    color: Colors.black,
                  ),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                  isExpanded: true,
                  ),),)
              ),
            vGap(20),
            ElevatedButton(
              onPressed: () {
                controller.hitUpdateStatusPutAPiCall();
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                minimumSize: Size(130, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text("Submit",style: MontserratStyles.montserratSemiBoldTextStyle(size: 15),),
            ),
        ]
            ),
        ),
      ),
    );

}