import 'package:flutter/material.dart';

class PricingCard extends StatelessWidget {
  final String? title;
  final String? price;
  final Color? backgroundColor;
  final List<bool>? features;

  PricingCard({
   this.title,
  this.price,
     this.backgroundColor,
     this.features,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Plan Title
            Text(
              title!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Price
            Text(
              price!,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Divider(color: Colors.white),
            // Features List
            for (bool feature in features!)
              FeatureRow(isIncluded: feature),
            SizedBox(height: 10),
            // Choose Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor, // Use the same color as the background
              ),
              onPressed: () {},
              child: Text('CHOOSE'),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureRow extends StatelessWidget {
  final bool isIncluded;

  FeatureRow({required this.isIncluded});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            isIncluded ? Icons.check : Icons.close,
            color: isIncluded ? Colors.green : Colors.red,
            size: 16,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              isIncluded ? 'Included feature' : 'Not available',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
