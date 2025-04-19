import 'package:dailylog/core/session/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/service/database_service.dart';

class HomeController extends GetxController {

  final _database = Get.find<DatabaseService>().database;

  RxDouble dailyAverageElectricityCost = 0.0.obs;

  RxDouble monthlyAverageGasCost = 0.0.obs;

  RxDouble lastWaterAtmBalance = 0.0.obs;

  RxInt estimateDaysToBeContinue = 0.obs;

  RxInt possibleDrinkCount = 0.obs;

  final _session = Get.find<SessionManager>();

  final menuList = [
    AppLocalization.electricityMeter,
    AppLocalization.cylinderGas,
    AppLocalization.waterPump,
    AppLocalization.settings,
  ];

  final iconList = [
    Icons.electric_meter_outlined,
    Icons.gas_meter_outlined,
    Icons.water_damage_outlined,
    Icons.settings,
  ];

  int estimateDays = 0;

  @override
  void onInit() {
    super.onInit();
    fetchDashboard();
  }

  void fetchDashboard(){
    _getDailyAverageElectricityCost();
    _getLastMonthlyAverageGasCost();
    _getLastWaterATMBalance();
    _getPossibleDrinkCount();
  }

  void _getDailyAverageElectricityCost() async {
    final data = await _database.electricityDao.getLastLogs();
    if (data.isEmpty || data.length == 1) return;

    double daysBetween = 0;
    double difference = 0;

    if (data.length == 3 && data.first.balance > data[data.length - 2].balance) {
      daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data.last.createdAt), DateTime.parse(data[data.length - 2].createdAt));
      difference = data.last.balance - data[data.length - 2].balance;
    } else {
      daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[1].createdAt), DateTime.parse(data.first.createdAt));
      difference = data[1].balance - data.first.balance;
    }

    if (difference == 1 && daysBetween == 0) return;

    final dailyAverage = (difference / daysBetween).toPrecision(2);
    dailyAverageElectricityCost.value = dailyAverage;

    int d = DateFormatUtil.getDaysBetween(DateTime.parse(data.first.createdAt), DateTime.now()).ceil();
    estimateDays = (data.first.balance / dailyAverage).floor();
    estimateDaysToBeContinue.value =  estimateDays - d;
  }

  void _getLastMonthlyAverageGasCost() async {
    final data = await _database.gasDao.getLastTwoLogs();
    if (data.length == 2) {
      double daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[1].createdAt), DateTime.parse(data[0].createdAt)) / 30.0;
      double difference = data[1].price;
      final dailyAverage = (difference / daysBetween).floorToDouble();
      monthlyAverageGasCost.value = dailyAverage;
    }
  }

  void _getLastWaterATMBalance() async {
    final data = await _database.waterAtmDao.getLastBalance();
    if (data != null){
      lastWaterAtmBalance.value = data.balance.toPrecision(2);
    }
  }

  void _getPossibleDrinkCount() async {
    final data = await _database.waterPumpDao.getLastTwoLogs();
    if (data.length == 2) {
      double daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[1].createdAt), DateTime.parse(data[0].createdAt));
      double difference = data[0].amount;
      final dailyAverage = difference ~/ daysBetween;
      possibleDrinkCount.value = (dailyAverage / (_session.familyMember ?? 1)).floor();
    }
  }
}