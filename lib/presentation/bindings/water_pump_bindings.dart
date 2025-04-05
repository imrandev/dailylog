import 'package:dailylog/presentation/controller/water_pump_controller.dart';
import 'package:get/get.dart';

class WaterPumpBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => WaterPumpController());
  }
}