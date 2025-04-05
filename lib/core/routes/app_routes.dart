import 'package:dailylog/core/routes/route_paths.dart';
import 'package:dailylog/presentation/bindings/electricity_bindings.dart';
import 'package:dailylog/presentation/bindings/gas_bindings.dart';
import 'package:dailylog/presentation/bindings/home_bindings.dart';
import 'package:dailylog/presentation/bindings/settings_bindings.dart';
import 'package:dailylog/presentation/bindings/water_pump_bindings.dart';
import 'package:dailylog/presentation/page/electricity_page.dart';
import 'package:dailylog/presentation/page/gas_page.dart';
import 'package:dailylog/presentation/page/home_page.dart';
import 'package:dailylog/presentation/page/settings_page.dart';
import 'package:dailylog/presentation/page/water_pump_page.dart';
import 'package:get/get.dart';

class AppRoutes {

  static List<GetPage> getPages() => [
    GetPage(
      name: RoutePaths.home,
      page: () => HomePage(),
      binding: HomeBindings(),
    ),
    GetPage(
      name: RoutePaths.electric,
      page: () => ElectricityPage(),
      binding: ElectricityBindings(),
    ),
    GetPage(
      name: RoutePaths.gas,
      page: () => GasPage(),
      binding: GasBindings(),
    ),
    GetPage(
      name: RoutePaths.waterPump,
      page: () => WaterPumpPage(),
      binding: WaterPumpBindings(),
    ),
    GetPage(
      name: RoutePaths.settings,
      page: () => SettingsPage(),
      binding: SettingsBindings(),
    ),
  ];
}