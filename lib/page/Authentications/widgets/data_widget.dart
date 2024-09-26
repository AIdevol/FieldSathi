import 'package:flutter/material.dart';

class DataWidget extends StatelessWidget {
  final List<String> headers = ['Header 1', 'Header 2', 'Header 3'];
  final Map<String, dynamic> fetchedData;

  DataWidget({required this.fetchedData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row for headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: headers
                .map((header) => Expanded(
              child: Text(
                header,
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ))
                .toList(),
          ),
          SizedBox(height: 10),
          // Row for dynamic values
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: headers
                .map((header) => Expanded(
              child: Text(
                fetchedData[header] != null
                    ? fetchedData[header].toString()
                    : 'N/A', // Default if data is missing
                style: TextStyle(fontSize: 16),
              ),
            ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
