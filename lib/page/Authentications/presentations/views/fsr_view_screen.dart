import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tms_sathi/main.dart';
import 'package:tms_sathi/page/Authentications/widgets/controller/add_fsr_view_controller.dart';
import '../../../../constans/color_constants.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/fsr_screen_controller.dart';

class FsrViewScreen extends GetView<FsrViewController> {
  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<FsrViewController>(
          builder: (controller) => Scaffold(
            appBar: AppBar(
              backgroundColor: appColor,
              title: Text(
                'FSR',
                style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 15,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addfsrScreen);
                    toast("Add your New FSR");
                  },
                  icon: const Icon(FeatherIcons.plus),
                ).paddingOnly(left: 20.0)
              ],
            ),
            body: Column(
              children: [
                _buildSearchBar(controller),
                Expanded(
                  child: Obx(() =>
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : _buildDataTable(controller),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildDataTable(FsrViewController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          // DataColumn(label: Text('Sr. No.')),
          DataColumn(label: Text('FSR Name')),
          DataColumn(label: Text('FSR Categories')),
          DataColumn(label: Text('Actions')),
        ],
        rows: controller.allFsr.map((entry) {
          final index = 0.obs;
        String? categoryNames = entry.categories?.map((categoryData)=> categoryData.name).toString();
        print("category data = $categoryNames");
          return DataRow(
            cells: [
              // DataCell(Text((index + 1).toString())), // Sr. No.
              DataCell(Text(entry.fsrName ?? '')),  // FSR Name
              DataCell(
                  _fsrCategoriesData(entry)
                  // TextButton.icon(onPressed: (){}, label: Text(categoryNames!),icon: Icon(Icons.menu_rounded),)
              ),          // FSR Categories
              DataCell(
                PopupMenuButton<String>(
                  color: CupertinoColors.white,
                  offset: Offset(0, 56),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Edit',
                      onTap: () {
                        // Get.toNamed(AppRoutes.editProfile);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black),
                        title: Text('Edit'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Delete',
                      onTap: () {
                        // Get.toNamed(AppRoutes.editProfile);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.delete, size: 20, color: Colors.red),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Icon(Icons.more_vert, size: 20),
                  ),
                ),
              ), // Actions
            ],
          );
        }).toList(),
      ),
    );
  }


/*
  Widget _buildPlutoGrid(FsrViewcontroller controller) {
    List<PlutoColumn> columns = [
      PlutoColumn(
        title: 'Sr. No.',
        field: 'srNo',
        type: PlutoColumnType.number(),
      ),
      PlutoColumn(
        title: 'FSR Name',
        field: 'fsrName',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'FSR Categories',
        field: 'fsrCategories',
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: 'Actions',
        field: 'actions',
        type: PlutoColumnType.number(),
        renderer: (rendererContext) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: PopupMenuButton<String>(
                  color: CupertinoColors.white,
                  offset: Offset(0, 56),
                  itemBuilder: (BuildContext context)=><PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Edit',
                      onTap: (){
                        // Get.toNamed(AppRoutes.editProfile);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.edit_calendar_outlined, size: 20, color: Colors.black,),
                        title: Text('Edit'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'Delete',
                      onTap: (){
                        // Get.toNamed(AppRoutes.editProfile);
                      },
                      child: const ListTile(
                        leading: Icon(Icons.delete, size: 20,color: Colors.red,),
                        title: Text('Delete'),
                      ),
                    ),
                  ],
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Icon(Icons.more_vert, size: 20,))
              ),
            ),
          );
        },
      ),
    ];

    List<PlutoRow> rows = controller.filteredTickets.asMap().entries.map((entry) {
      final index = entry.key;
      final FsrResponseModel fsrData = entry.value;

      String categoryNames = fsrData.categories
          .map((category) => category.name)
          .where((name) => name.isNotEmpty)
          .join(', ') ?? '';

      return PlutoRow(
        cells: {
          'srNo': PlutoCell(value: index + 1),
          'fsrName': PlutoCell(value: fsrData.fsrName),
          'fsrCategories': PlutoCell(value: categoryNames),
          'actions':PlutoCell(value: '')
        },
      );
    }).toList();

    return PlutoGrid(
      columns: columns,
      rows: rows,
      onLoaded: (PlutoGridOnLoadedEvent event) {
        // You can perform actions when the grid is loaded
      },
      onChanged: (PlutoGridOnChangedEvent event) {
        // Handle changes in the grid
      },
      configuration: PlutoGridConfiguration(
        columnFilter: PlutoGridColumnFilterConfig(
          filters: const [
            ...FilterHelper.defaultFilters,
          ],
          resolveDefaultColumnFilter: (column, resolver) {
            if (column.field == 'number') {
              return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
            }

            return resolver<PlutoFilterTypeContains>() as PlutoFilterType;
          },
        ),
      ),
    );
  }
*/

  Widget _buildSearchBar(FsrViewController controller) {
    return Container(
      height: Get.height * 0.07,
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
        children: [
          Expanded(
            child: _buildSearchField(controller),
          ),
          hGap(10),
          _buildCheckpointStatusButton(),
          hGap(10),
        ],
      ),
    );
  }

  Widget _buildSearchField(FsrViewController controller) {
    return Container(
      height: Get.height * 0.05,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          width: 1,
          color: Colors.grey,
        ),
      ),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: Colors.grey,
          ),
          prefixIcon: Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.black,
        ),
        onChanged: (value) {
          controller.updateSearch(value);
        },
      ),
    );
  }

  Widget _buildCheckpointStatusButton() {
    return ElevatedButton(
      onPressed: () => _buildAlertDialog(Get.context!),
      style: _buttonStyle(),
      child: Text(
        'CheckPoint Status',
        style: MontserratStyles.montserratBoldTextStyle(
          color: whiteColor,
          size: 13,
        ),
      ),
    );
  }

  // void _buildAlertDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             "Checkpoint Status",
  //             style: MontserratStyles.montserratBoldTextStyle(
  //               color: Colors.black,
  //               size: 16,
  //             ),
  //           ),
  //           vGap(10),
  //           TextField(
  //             controller: controller.checkPointStatusCheckingController,
  //             focusNode: controller.checkPointStatusCheckingFocusNode,
  //             decoration: InputDecoration(
  //               hintText: 'Checkpoint status',
  //               border: OutlineInputBorder(),
  //             ),
  //           ),
  //           vGap(20),
  //           Align(
  //             alignment: Alignment.centerLeft,
  //             child: ElevatedButton(
  //               onPressed: () {
  //                 controller.hitPostCheckingStatusApiCall();
  //                 Navigator.of(context).pop();
  //               },
  //               style: _buttonStyle(),
  //               child: Text(
  //                 '+CheckPoint Status',
  //                 style: MontserratStyles.montserratBoldTextStyle(
  //                   color: whiteColor,
  //                   size: 13,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           vGap(20),
  //           Align(
  //             alignment: Alignment.centerLeft,
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     // controller.hitPostCheckingStatusApiCall();
  //                     Navigator.of(context).pop();
  //                   },
  //                   style: _buttonStyle(),
  //                   child: Text(
  //                     'Cancel',
  //                     style: MontserratStyles.montserratBoldTextStyle(
  //                       color: whiteColor,
  //                       size: 13,
  //                     ),
  //                   ),
  //                 ),
  //                 hGap(10),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     controller.hitPostCheckingStatusApiCall();
  //                     Navigator.of(context).pop();
  //                   },
  //                   style: _buttonStyle(),
  //                   child: Text(
  //                     'Submit',
  //                     style: MontserratStyles.montserratBoldTextStyle(
  //                       color: whiteColor,
  //                       size: 13,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
  void _buildAlertDialog(BuildContext context) {
    // Keep track of text fields in the controller
    final RxList<Map<String, dynamic>> checkpoints = <Map<String, dynamic>>[
      {
        'controller': TextEditingController(),
        'focusNode': FocusNode(),
      }
    ].obs;

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Obx(() => Container(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Checkpoint Status",
                  style: MontserratStyles.montserratBoldTextStyle(
                    color: Colors.black,
                    size: 16,
                  ),
                ),
                vGap(10),
                // Generate text fields dynamically
                ...checkpoints.asMap().entries.map((entry) {
                  final index = entry.key;
                  final checkpoint = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextField(
                      controller: checkpoint['controller'],
                      focusNode: checkpoint['focusNode'],
                      decoration: InputDecoration(
                        hintText: 'Checkpoint status ${index + 1}',
                        border: OutlineInputBorder(),
                        suffixIcon: index != 0 ? IconButton(
                          icon: Icon(Icons.remove_circle_outline, color: Colors.red),
                          onPressed: () {
                            // Dispose the controllers and focus nodes
                            checkpoint['controller'].dispose();
                            checkpoint['focusNode'].dispose();
                            // Remove the field
                            checkpoints.removeAt(index);
                          },
                        ) : null,
                      ),
                      onSubmitted: (_) {
                        if (index == checkpoints.length - 1) {
                          // Add new field when Enter is pressed on the last field
                          checkpoints.add({
                            'controller': TextEditingController(),
                            'focusNode': FocusNode(),
                          });
                          // Focus the new field
                          checkpoints.last['focusNode'].requestFocus();
                        } else {
                          // Focus next field
                          checkpoints[index + 1]['focusNode'].requestFocus();
                        }
                      },
                      textInputAction: index == checkpoints.length - 1
                          ? TextInputAction.done
                          : TextInputAction.next,
                    ),
                  );
                }).toList(),
                vGap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                    onPressed: () {
                      checkpoints.add({
                        'controller': TextEditingController(),
                        'focusNode': FocusNode(),
                      });
                      // Focus the new field after it's added
                      Future.delayed(Duration(milliseconds: 100), () {
                        checkpoints.last['focusNode'].requestFocus();
                      });
                    },
                    style: _buttonStyle(),
                    child: Text(
                      '+ CheckPoint Status',
                      style: MontserratStyles.montserratBoldTextStyle(
                        color: whiteColor,
                        size: 13,
                      ),
                    ),
                  ),
                ),
                vGap(20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Clean up all controllers and focus nodes
                          for (var checkpoint in checkpoints) {
                            checkpoint['controller'].dispose();
                            checkpoint['focusNode'].dispose();
                          }
                          Navigator.of(context).pop();
                        },
                        style: _buttonStyle(),
                        child: Text(
                          'Cancel',
                          style: MontserratStyles.montserratBoldTextStyle(
                            color: whiteColor,
                            size: 13,
                          ),
                        ),
                      ),
                      hGap(10),
                      ElevatedButton(
                        onPressed: () {
                          // Get all non-empty checkpoint values
                          final List values = checkpoints
                              .map((cp) => cp['controller'].text)
                              .where((text) => text.isNotEmpty)
                              .toList();

                          // Clean up all controllers and focus nodes
                          for (var checkpoint in checkpoints) {
                            checkpoint['controller'].dispose();
                            checkpoint['focusNode'].dispose();
                          }

                          // Process the values
                          print('Checkpoint values: $values');
                          controller.hitPostCheckingStatusApiCall();
                          Navigator.of(context).pop();
                        },
                        style: _buttonStyle(),
                        child: Text(
                          'Submit',
                          style: MontserratStyles.montserratBoldTextStyle(
                            color: whiteColor,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
  ButtonStyle _buttonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all(appColor),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      padding: MaterialStateProperty.all(
        EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      elevation: MaterialStateProperty.all(3),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      shadowColor: MaterialStateProperty.all(Colors.black.withOpacity(0.3)),
    );
  }
}

Widget _fsrCategoriesData(Result entry) {
  return PopupMenuButton<String>(
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          entry.categories?.length.toString() ?? '0',
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 4),
        const Text('Categories '),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
    itemBuilder: (BuildContext context) {
      return entry.categories?.map((category) {
        return PopupMenuItem<String>(
          value: category.name,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.menu,
                          size: 16,
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            category.name ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (category.checkpoints?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(left: 24, top: 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: category.checkpoints!.map((checkpoint) {
                            return Row(
                              children: [
                                const Icon(
                                  Icons.check_circle_outline,
                                  size: 14,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 4),
                                Expanded(
                                  child: Text(
                                    checkpoint.checkpointName ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_right,
                color: Colors.grey,
              ),
            ],
          ),
        );
      }).toList() ?? [
        const PopupMenuItem<String>(
          value: 'none',
          child: Text('No categories available'),
        ),
      ];
    },
    onSelected: (String value) {
      // Handle category selection if needed
      print('Selected category: $value');
    },
  );
}