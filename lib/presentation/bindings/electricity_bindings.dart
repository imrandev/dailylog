import 'package:get/get.dart';
import 'package:dailylog/presentation/controller/electricity_controller.dart';

class ElectricityBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => ElectricityController());
  }
}