import 'package:get/get.dart';

class LeadFormFieldController extends GetxController{

  List<String> regionValues = [
    'Select Region'
        "North",
    "West",
    'East',
    'South'
  ];

  String defaultValue  = 'Select Region';

  void updateRegion(String newValue){
    defaultValue = newValue;
    update();
  }
}