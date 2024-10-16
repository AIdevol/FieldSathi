import 'package:get/get.dart';

class AmcStatusMonitorGraphController extends GetxController{
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;

  var upcoming = 40.obs;
  var renewal = 30.obs;
  var completed = 15.obs;
  var total = 15.obs;
}