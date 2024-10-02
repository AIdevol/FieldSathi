import 'package:get/get.dart';

class AmcStatusMonitorGraphController extends GetxController{
  final _touchedIndex = (-1).obs;
  int get touchedIndex => _touchedIndex.value;
  void setTouchedIndex(int index) => _touchedIndex.value = index;
}