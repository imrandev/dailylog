import 'package:dailylog/core/routes/app_routes.dart';
import 'package:dailylog/core/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/lang/languages.dart';
import 'package:dailylog/core/session/pref_manager.dart';
import 'package:dailylog/core/session/session_manager.dart';
import 'package:dailylog/core/utils/app_colors.dart';
import 'package:dailylog/core/utils/constant.dart';
import 'package:dailylog/service/database_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize global services
  await Get.putAsync<DatabaseService>(() => DatabaseService().init());
  await Get.putAsync(() async => SessionManager(PrefManager(await SharedPreferences.getInstance())));

  runApp(DailyLogApp());
}

class DailyLogApp extends StatelessWidget {

  final _sessionManager = Get.find<SessionManager>();

  DailyLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppLocalization.dailyLog.tr,
      translations: Languages(),
      locale: Locale(_sessionManager.prefLanguage ?? Constant.english),
      fallbackLocale: const Locale(Constant.english),
      theme: ThemeData(
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          elevation: 4.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontFamily: _sessionManager.prefLanguage == Constant.bangla
                ? Constant.solaimanLipi
                : Constant.poppins,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
        ),
        fontFamily: _sessionManager.prefLanguage == Constant.bangla
            ? Constant.solaimanLipi
            : Constant.poppins,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: RoutePaths.home,
      getPages: AppRoutes.getPages(),
    );
  }
}
