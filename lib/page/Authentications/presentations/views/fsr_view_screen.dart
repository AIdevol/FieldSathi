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
import '../../../../utilities/common_textFields.dart';
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
              leading: IconButton(onPressed: ()=>Get.back(), icon: Icon(Icons.arrow_back_ios, size: 22, color: Colors.black87)),
              backgroundColor: appColor,
              title: Text(
                'FSR',
                style: MontserratStyles.montserratBoldTextStyle(
                  color: blackColor,
                  size: 15,
                ),
              ),
              actions: [
                IconButton(onPressed: (){
                  controller.hitGetFsrDetailsApiCall();
                }, icon: Icon(Icons.refresh_outlined)),
                IconButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.addfsrScreen);
                    toast("Add your New FSR");
                  },
                  icon: const Icon(FeatherIcons.plus),
                ).paddingOnly(right: 10)
              ],
            ),
            body: Column(
              children: [
                _buildSearchBar(controller),
                Expanded(
                  child: Obx(() =>
                  controller.isLoading.value
                      ? Center(child: Container())
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
                  color: Colors.white,
                  offset: Offset(0, 56),
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Edit',
                      onTap: () {
                        _showEditModelView(controller, context);
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
          /// hGap(10),
          /// _buildCheckpointStatusButton(),
          /// hGap(10),
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
        const Text('FSRs '),
        const Icon(Icons.arrow_drop_down),
      ],
    ),
    itemBuilder: (BuildContext context) {
      return entry.categories?.map((category) {
        return PopupMenuItem<String>(
          // onTap: () =>_buildCheckpointStatusButton(),
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
                         IconButton(
                          onPressed: (){
                            Navigator.pop(context);
                            _showCheckpointDialog(
                            context,
                            entry,
                            category
                            );},
                          icon:Icon(Icons.menu,
                            size: 16,
                            color: Colors.blue,)
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

  Widget _buildCheckpointStatusButton(BuildContext context, Result fsr, Category category) {
    return ElevatedButton(
      onPressed: () => _showCheckpointDialog(context, fsr, category),
      style: ElevatedButton.styleFrom(
        backgroundColor: appColor,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Checkpoint Status',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  void _showCheckpointDialog(
      BuildContext context,
      Result fsr,
      Category category,
      ) {
    final checkpointControllers = category.checkpoints?.map(
          (checkpoint) => TextEditingController(text: checkpoint.id.toString()??" "),
    ).toList() ??
        [];

    if (checkpointControllers.isEmpty) {
      checkpointControllers.add(TextEditingController());
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "FSR: ${fsr.fsrName ?? ''}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Category: ${category.name ?? ''}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              content: Container(
                width: double.maxFinite,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...List.generate(
                        category.checkpoints?.length ?? 0,
                            (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      category.checkpoints?[index].checkpointName ??
                                          '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    TextField(
                                      controller: checkpointControllers[index],
                                      decoration: InputDecoration(
                                        hintText: 'Enter status',
                                        border: OutlineInputBorder(),
                                        contentPadding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    for (var controller in checkpointControllers) {
                      controller.dispose();
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final checkpointStatuses = <String, String>{};
                    for (int i = 0;
                    i < (category.checkpoints?.length ?? 0);
                    i++) {
                      checkpointStatuses[
                      category.checkpoints?[i].id.toString()?? ''] =
                          checkpointControllers[i].text;
                    }

                    // await Get.find<FsrViewController>().hitGetFsrDetailsApiCall(
                    //   Result.id.toString() ?? '',
                    //   category.id.toString() ?? '',
                    //   checkpointStatuses,
                    // );

                    for (var controller in checkpointControllers) {
                      controller.dispose();
                    }
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appColor,
                  ),
                  child: const Text(
                    'Update Status',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
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


void _showEditModelView(FsrViewController controller, BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent dismissal by tapping outside
    builder: (context) => Dialog(
      // Set maximum size constraints for better layout
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: GetBuilder<FsrViewController>( // Add GetBuilder to update UI when controller state changes
          builder: (controller) => Column(
            mainAxisSize: MainAxisSize.min, // Make dialog size fit content
            children: [
              // Header with close button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit FSR",
                      style: MontserratStyles.montserratBoldTextStyle(
                        size: 15,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          hintText: "Name".tr,
                          controller: controller.firstNameController,
                          textInputType: TextInputType.text,
                          labletext: 'Name'.tr,
                        ),
                        vGap(20),

                        // Categories list
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.categoryNameControllers.length,
                          separatorBuilder: (context, index) => vGap(10),
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: CustomTextField(
                                    hintText: 'Categories'.tr,
                                    controller: controller.categoryNameControllers[index],
                                    maxLines: 2,
                                    textInputType: TextInputType.text,
                                    labletext: 'Categories'.tr,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.remove_circle, color: Colors.red),
                                  onPressed: () {
                                    controller.removeCategoryField(index);
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        vGap(20),

                        // Add Category button
                        Center(
                          child: SizedBox(
                            width: 230,
                            height: 50,
                            child: CupertinoButton(
                              color: appColor,
                              onPressed: () => controller.addNewCategoryField(),
                              padding: EdgeInsets.zero,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, size: 18),
                                  SizedBox(width: 5),
                                  Text(
                                    'Add Category',
                                    style: MontserratStyles.montserratBoldTextStyle(
                                      color: blackColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        vGap(20),

                        // Submit button
                        SizedBox(
                          width: double.infinity,
                          child: CupertinoButton(
                            color: appColor,
                            onPressed: () {
                              // controller.hitPostFsrDetailsApiCall();
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Update FSR',
                              style: MontserratStyles.montserratBoldTextStyle(
                                color: blackColor,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}