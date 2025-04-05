import 'package:get/get.dart';
import 'package:dailylog/presentation/controller/gas_controller.dart';

class GasBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => GasController());
  }
}