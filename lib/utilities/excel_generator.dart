import 'dart:io';

import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ExcelExportService {
  /// Converts data to Excel file and saves it locally
  /// [data] - List of Maps containing the data to export
  /// [fileName] - Name of the excel file (without extension)
  /// Returns the path where file is saved
  Future<String> exportToExcel({
    required List<Map<String, dynamic>> data,
    required String fileName,
  }) async {
    try {
      // Request storage permission
      if (!await _requestStoragePermission()) {
        throw Exception('Storage permission denied');
      }

      // Create Excel workbook
      final excel = Excel.createExcel();
      final Sheet sheet = excel['Sheet1'];

      // Add headers (using keys from first data item)
      if (data.isNotEmpty) {
        final headers = data.first.keys.toList();
        for (var i = 0; i < headers.length; i++) {
          sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
              .value = headers[i] as CellValue?;
        }
      }

      // Add data rows
      for (var rowIndex = 0; rowIndex < data.length; rowIndex++) {
        final rowData = data[rowIndex];
        final rowKeys = rowData.keys.toList();

        for (var colIndex = 0; colIndex < rowKeys.length; colIndex++) {
          sheet
              .cell(CellIndex.indexByColumnRow(
              columnIndex: colIndex, rowIndex: rowIndex + 1))
              .value = rowData[rowKeys[colIndex]].toString() as CellValue?;
        }
      }

      // Get application documents directory
      final directory = await _getExcelDirectory();
      final filePath = '${directory.path}/$fileName.xlsx';

      // Save the excel file
      final fileBytes = excel.save();
      if (fileBytes != null) {
        File(filePath)
          ..createSync(recursive: true)
          ..writeAsBytesSync(fileBytes);
        return filePath;
      }

      throw Exception('Failed to generate Excel file');
    } catch (e) {
      throw Exception('Error exporting to Excel: $e');
    }
  }

  /// Request storage permission from user
  Future<bool> _requestStoragePermission() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; // iOS doesn't need explicit permission for app documents directory
  }

  /// Get directory to save Excel file
  Future<Directory> _getExcelDirectory() async {
    if (Platform.isAndroid) {
      // For Android, save in Downloads folder
      return Directory('/storage/emulated/0/Download');
    } else {
      // For iOS, save in app documents directory
      return await getApplicationDocumentsDirectory();
    }
  }
}