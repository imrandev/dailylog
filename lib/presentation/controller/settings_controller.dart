import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/utils/constant.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/data/database/entity/water_atm_entity.dart';
import 'package:dailylog/service/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/session/session_manager.dart';

class SettingsController extends GetxController {

  RxBool isBangla = false.obs;

  final _sessionManager = Get.find<SessionManager>();

  final _database = Get.find<DatabaseService>().database;

  RxDouble lastWaterAtmBalance = 0.0.obs;

  RxInt familyMemberCount = 1.obs;

  RxnString logEntryErrorMessage = RxnString();

  RxnString lastResetDate = RxnString();

  final session = Get.find<SessionManager>();

  final addFamilyTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    familyMemberCount = RxInt(_sessionManager.familyMember ?? 1);
    addFamilyTextController.text = "${familyMemberCount.value}";
    isBangla.value = _sessionManager.prefLanguage == Constant.bangla;
    _getLastWaterATMBalance();
  }

  void setLanguagePref(bool value){
    isBangla.value = value;
    _sessionManager.prefLanguage = isBangla.value ? Constant.bangla : Constant.english;
    Get.updateLocale(Locale(value ? Constant.bangla : Constant.english));
  }

  void _getLastWaterATMBalance() async {
    final data = await _database.waterAtmDao.getLastBalance();
    if (data != null){
      lastWaterAtmBalance.value = data.balance;
      lastResetDate.value = data.createdAt;
    }
  }

  Future<void> insertBalance(Map<String, dynamic> input, Function() callback, {int? id}) async {
    if (!input.containsKey("balance") || input['balance'].toString().isEmpty){
      logEntryErrorMessage.value = AppLocalization.errorWaterAtmBalance.tr;
      return;
    }
    clearLogInput();
    double balance = double.parse(input['balance']);
    final data = await _database.waterAtmDao.getAllLogs();
    if (data.isNotEmpty){
      final data = await _database.waterAtmDao.getLastBalance();
      balance = (data?.balance ?? 0) + double.parse(input['balance']);
    }
    await _database.waterAtmDao.insertLog(
        WaterAtmEntity(
          waterPumpId: id,
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          balance: balance,
        )
    );
    _getLastWaterATMBalance();
    callback();
  }

  void clearLogInput(){
    logEntryErrorMessage.value = null;
  }

  void updateFamily(Function() callback) {
    final data = addFamilyTextController.value.text;
    if (data.isEmpty) {
      logEntryErrorMessage.value = AppLocalization.errorFamilyMember.tr;
    }
    session.familyMember = int.parse(data);
    familyMemberCount.value = int.parse(data);
    callback();
  }

  void resetBalance(Function() callback) async {
    await _database.waterAtmDao.deleteAllLogs();
    _getLastWaterATMBalance();
    callback();
  }
}