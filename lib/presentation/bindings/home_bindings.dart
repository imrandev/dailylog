import 'package:get/get.dart';
import 'package:dailylog/presentation/controller/home_controller.dart';

class HomeBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}