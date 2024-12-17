import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../../../constans/color_constants.dart';
import '../../../../constans/string_const.dart';
import '../../../../navigations/navigation.dart';
import '../../../../response_models/fsr_response_model.dart';
import '../../../../utilities/common_textFields.dart';
import '../../../../utilities/google_fonts_textStyles.dart';
import '../../../../utilities/helper_widget.dart';
import '../controllers/fsr_screen_controller.dart';

class FsrViewScreen extends GetView<FsrViewController> {
  const FsrViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyAnnotatedRegion(
      child: SafeArea(
        child: GetBuilder<FsrViewController>(
          builder: (controller) =>
              Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: _buildPaginationControls(controller),
                appBar: _buildAppBar(controller),
                body: _buildBody(controller),
              ),
        ),
      ),
    );
  }

  // App Bar Construction
  PreferredSizeWidget _buildAppBar(FsrViewController controller) {
    return AppBar(
      leading: _buildBackButton(),
      backgroundColor: appColor,
      title: _buildAppBarTitle(),
      actions: _buildAppBarActions(controller),
      elevation: 2,
    );
  }

  // Back Button
  Widget _buildBackButton() {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 22,
        color: Colors.black87,
      ),
    );
  }

  // App Bar Title
  Widget _buildAppBarTitle() {
    return Text(
      'FSRs',
      style: MontserratStyles.montserratBoldTextStyle(
        color: blackColor,
        size: 15,
      ),
    );
  }

  // App Bar Action Buttons
  List<Widget> _buildAppBarActions(FsrViewController controller) {
    return [
      IconButton(
        onPressed: controller.hitGetFsrDetailsApiCall,
        icon: const Icon(Icons.refresh_outlined),
      ),
      IconButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addfsrScreen);
          toast("Add your New FSR");
        },
        icon: const Icon(FeatherIcons.plus),
      ).paddingOnly(right: 10),
    ];
  }

  // Body Content
  Widget _buildBody(FsrViewController controller) {
    return Column(
      children: [
        _buildSearchBar(controller),
        Expanded(
          child: Obx(() =>
          controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : _buildDataContent(controller)),
        ),
      ],
    );
  }

  // Search Bar
  Widget _buildSearchBar(FsrViewController controller) {
    return Container(
      height: Get.height * 0.07,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildSearchField(controller),
      ),
    );
  }

  // Search Input Field
  Widget _buildSearchField(FsrViewController controller) {
    return Container(
      height: Get.height * 0.07,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: TextField(
        controller: controller.searchController,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: MontserratStyles.montserratSemiBoldTextStyle(
            color: Colors.grey,
          ),
          prefixIcon: const Icon(FeatherIcons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
        style: MontserratStyles.montserratSemiBoldTextStyle(
          color: Colors.black,
        ),
        onChanged: controller.updateSearch,
      ),
    );
  }

  // Content Display
  Widget _buildDataContent(FsrViewController controller) {
    return controller.allFsr.isEmpty
        ? _buildEmptyState()
        : Padding(
      padding: const EdgeInsets.all(18.0),
      child: _buildDataTable(controller),
    );
  }

  // Empty State Widget
  Widget _buildEmptyState() {
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
              color: blackColor,
            ),
          ),
        ],
      ),
    );
  }

  // Data Table Construction
  Widget _buildDataTable(FsrViewController controller) {
    // Calculate paginated data
    final paginatedData = _getPaginatedData(controller);

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columnSpacing: 16,
            headingRowColor: MaterialStateColor.resolveWith(
                  (states) => appColor.withOpacity(0.1),
            ),
            columns: _buildDataColumns(),
            rows: paginatedData.map((entry) => _buildDataRow(entry,controller)).toList(),
          ),
        ),
        // _buildPaginationControls(controller),
      ],
    );
  }

  // Data Columns
  List<DataColumn> _buildDataColumns() {
    return [
      const DataColumn(label: Text(
          'FSR Name', style: TextStyle(fontWeight: FontWeight.bold))),
      const DataColumn(label: Text(
          'FSR Categories', style: TextStyle(fontWeight: FontWeight.bold))),
      const DataColumn(label: Text(
          'Actions', style: TextStyle(fontWeight: FontWeight.bold))),
    ];
  }

  // Data Row
  DataRow _buildDataRow(Result entry,FsrViewController controller) {
    return DataRow(
      cells: [
        DataCell(Text(entry.fsrName ?? '')),
        DataCell(_fsrCategoriesData(entry)),
        DataCell(_buildActionMenu(entry, controller)),
      ],
    );
  }
  Widget _buildPaginationControls(FsrViewController controller) {
    return Obx(() {
      final totalPages = (controller.allFsr.length / 10).ceil();
      final currentPage = controller.currentPage.value;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: currentPage > 1
                ? () => controller.changePage(currentPage - 1)
                : null,
          ),
          Text(
            'Page $currentPage of $totalPages',
            style: TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: currentPage < totalPages
                ? () => controller.changePage(currentPage + 1)
                : null,
          ),
        ],
      );
    });
  }

  // Get Paginated Data
  List<Result> _getPaginatedData(FsrViewController controller) {
    final start = (controller.currentPage.value - 1) * 10;
    final end = start + 10;
    return controller.allFsr.sublist(
        start,
        end > controller.allFsr.length ? controller.allFsr.length : end
    );
  }
}
  // FSR Categories Popup
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
                            onPressed: () {
                              Navigator.pop(context);
                              _showCheckpointDialog(context, entry, category);
                            },
                            icon: const Icon(
                              Icons.menu,
                              size: 16,
                              color: Colors.blue,
                            ),
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
        print('Selected category: $value');
      },
    );
  }

  // Action Menu
  Widget _buildActionMenu(Result entry, FsrViewController controller) {
    return PopupMenuButton<String>(
      color: Colors.white,
      offset: const Offset(0, 56),
      itemBuilder: (BuildContext context) =>
      [
        _buildPopupMenuItem(
          value: 'Edit',
          icon: Icons.edit_calendar_outlined,
          text: 'Edit',
          onTap: () => _showEditModelView(controller, context),
        ),
        _buildPopupMenuItem(
          value: 'Delete',
          icon: Icons.delete,
          text: 'Delete',
          color: Colors.red,
          onTap: () {
            // Implement delete logic
          },
        ),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Icon(Icons.more_vert, size: 20),
      ),
    );
  }

  // Popup Menu Item
  PopupMenuItem<String> _buildPopupMenuItem({
    required String value,
    required IconData icon,
    required String text,
    VoidCallback? onTap,
    Color? color,
  }) {
    return PopupMenuItem<String>(
      value: value,
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon, size: 20, color: color ?? Colors.black),
        title: Text(text),
      ),
    );
  }

  // Checkpoint Dialog
  void _showCheckpointDialog(BuildContext context,
      Result fsr,
      Category category,) {
    final checkpointControllers = category.checkpoints?.map(
          (checkpoint) =>
          TextEditingController(text: checkpoint.id.toString() ?? " "),
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
                    maxHeight: MediaQuery
                        .of(context)
                        .size
                        .height * 0.7,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ...List.generate(
                          category.checkpoints?.length ?? 0,
                              (index) =>
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                            category.checkpoints?[index]
                                                .checkpointName ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          TextField(
                                            controller: checkpointControllers[index],
                                            decoration: const InputDecoration(
                                              hintText: 'Enter status',
                                              border: OutlineInputBorder(),
                                              contentPadding: EdgeInsets
                                                  .symmetric(
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
                      for (int i = 0; i <
                          (category.checkpoints?.length ?? 0); i++) {
                        checkpointStatuses[
                        category.checkpoints?[i].id.toString() ?? ''] =
                            checkpointControllers[i].text;
                      }

                      // Uncomment and implement API call if needed
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
        });
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
      builder: (context) =>
          Dialog(
            // Set maximum size constraints for better layout
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery
                    .of(context)
                    .size
                    .width * 0.9,
                maxHeight: MediaQuery
                    .of(context)
                    .size
                    .height * 0.8,
              ),
              child: GetBuilder<
                  FsrViewController>( // Add GetBuilder to update UI when controller state changes
                builder: (controller) =>
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      // Make dialog size fit content
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
                                    itemCount: controller
                                        .categoryNameControllers
                                        .length,
                                    separatorBuilder: (context, index) =>
                                        vGap(10),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: CustomTextField(
                                              hintText: 'Categories'.tr,
                                              controller: controller
                                                  .categoryNameControllers[index],
                                              maxLines: 2,
                                              textInputType: TextInputType.text,
                                              labletext: 'Categories'.tr,
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.remove_circle,
                                                color: Colors.red),
                                            onPressed: () {
                                              controller.removeCategoryField(
                                                  index);
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
                                        onPressed: () =>
                                            controller.addNewCategoryField(),
                                        padding: EdgeInsets.zero,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.add, size: 18),
                                            SizedBox(width: 5),
                                            Text(
                                              'Add Category',
                                              style: MontserratStyles
                                                  .montserratBoldTextStyle(
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
                                        style: MontserratStyles
                                            .montserratBoldTextStyle(
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
