import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:intl/intl.dart';

import 'hex_color.dart';

class ExcelDownloadHandler {
  static Future<String> downloadAttendanceReport(List<Map<String, dynamic>> data) async {
    try {
      // Request storage permission
      var status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception('Storage permission is required to download the file');
      }

      // Create Excel workbook and sheet
      var excel = Excel.createExcel();
      Sheet sheetObject = excel['Attendance Report'];

      // Define headers
      final headers = ["User", "Punch In", "Punch Out", "Date", "Status", "Total Hours"];
      for (int i = 0; i < headers.length; i++) {
        var cell = sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0));
        cell.value = TextCellValue(headers[i]);

        // Style header cells
        cell.cellStyle = CellStyle(
          bold: true,
          // backgroundColorHex:'#FFD9EAD3',
          horizontalAlign: HorizontalAlign.Center,
        );
      }

      // Add data rows
      for (int row = 0; row < data.length; row++) {
        var item = data[row];

        // Format date and time values
        DateTime? punchIn = item['Punch In'] != null ? DateTime.parse(item['Punch In']) : null;
        DateTime? punchOut = item['Punch Out'] != null ? DateTime.parse(item['Punch Out']) : null;

        String formattedPunchIn = punchIn != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(punchIn)
            : '';
        String formattedPunchOut = punchOut != null
            ? DateFormat('yyyy-MM-dd HH:mm:ss').format(punchOut)
            : '';

        // Calculate total hours if both punch in and out exist
        String totalHours = '';
        if (punchIn != null && punchOut != null) {
          Duration difference = punchOut.difference(punchIn);
          totalHours = '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
        }

        // Add row data
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row + 1))
            .value = TextCellValue(item['User'] ?? '');
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row + 1))
            .value = TextCellValue(formattedPunchIn);
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: row + 1))
            .value = TextCellValue(formattedPunchOut);
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: row + 1))
            .value = TextCellValue(item['Date'] ?? '');
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: row + 1))
            .value = TextCellValue(item['Status'] ?? '');
        sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: row + 1))
            .value = TextCellValue(totalHours);
      }

      // Auto-size columns
      for (int i = 0; i < headers.length; i++) {
        sheetObject.setColumnWidth(i, 15.0);
      }

      // Generate file name with timestamp
      String timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      String fileName = 'attendance_report_$timestamp.xlsx';

      // Get download directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = Directory('/storage/emulated/0/Download');
        // Create directory if it doesn't exist
        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create full file path
      String filePath = '${directory.path}/$fileName';

      // Save file
      File excelFile = File(filePath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);

      return filePath;
    } catch (e) {
      throw Exception('Failed to download report: $e');
    }
  }
}