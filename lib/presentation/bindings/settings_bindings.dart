import 'package:get/get.dart';
import 'package:dailylog/presentation/controller/settings_controller.dart';

class SettingsBindings extends Bindings {

  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}