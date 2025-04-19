import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/session/session_manager.dart';
import 'package:dailylog/core/utils/constant.dart';
import 'package:dailylog/data/database/entity/water_atm_entity.dart';
import 'package:dailylog/data/database/entity/water_pump_entity.dart';
import 'package:dailylog/domain/model/water_pump_model.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/utils/extensions.dart';
import 'package:dailylog/presentation/controller/log_controller.dart';
import 'package:dailylog/core/utils/date_format_util.dart';

class WaterPumpController extends LogController<WaterPumpModel, int> {

  final logList = <WaterPumpModel>[].obs;

  final chartData = [].obs;

  RxnString logEntryErrorMessage = RxnString();

  final _sessionManager = Get.find<SessionManager>();

  @override
  Future<void> getLogs() async {
    final data = await database.waterPumpDao.getAllLogs();
    final model = data.map((e) => WaterPumpModel(id: e.id, createdAt: e.createdAt, amount: e.amount)).toList();
    logList.addAll(model);
    _getChartData();
  }

  @override
  Future<void> insertLog(Map<String, dynamic> input, Function() callback) async {
    if (!input.containsKey("amount") || input['amount'].toString().isEmpty){
      logEntryErrorMessage.value = AppLocalization.errorWaterPumpAmount.tr;
      return;
    }
    clearLogInput();
    int id = await database.waterPumpDao.insertLog(
        WaterPumpEntity(
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          amount: double.parse(input['amount']),
        )
    );
    logList.insert(
        0,
        WaterPumpModel(
          id: id,
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          amount: double.parse(input['amount']),
        )
    );
    await _insertBalance(id);
    callback();
  }

  Future<void> _insertBalance(int? id) async {
    final lastData = await database.waterAtmDao.getLastBalance();
    if (lastData == null){
      logEntryErrorMessage.value = AppLocalization.noticeWaterAtmBalance.tr;
      return;
    }
    final data = await database.waterPumpDao.getLastLog();
    final price = (data?.amount ?? 0.0) * (_sessionManager.pricePerLitre ?? Constant.perLitrePrice);
    final lastBalance = await database.waterAtmDao.getLastBalance();
    if ((lastBalance?.balance ?? 0) < 1){
      logEntryErrorMessage.value = AppLocalization.noticeWaterAtmBalance.tr;
      return;
    }
    final balance = (lastBalance?.balance ?? 0) - price;
    await database.waterAtmDao.insertLog(
        WaterAtmEntity(
          waterPumpId: id,
          createdAt: DateFormatUtil.formatDateTime(DateTime.now()),
          balance: balance,
        )
    );
  }

  void clearLogInput(){
    logEntryErrorMessage.value = null;
  }

  @override
  Future<void> updateLog(WaterPumpModel obj, Function() callback) async {
    if (obj.amount.value == null){
      logEntryErrorMessage.value = AppLocalization.errorWaterPumpAmount.tr;
      return;
    }
    if (obj.id == null) return;
    await database.waterPumpDao.updateLog(
        WaterPumpEntity(
          id: obj.id,
          createdAt: obj.createdAt.value ?? "",
          amount: obj.amount.value ?? 0.00,
        )
    );
    await database.waterAtmDao.deleteLogById(obj.id ?? 0);
    await _insertBalance(obj.id);

    int index = logList.indexWhere((element) => element.id == obj.id);
    logList[index].amount.value = obj.amount.value;
    logList[index].createdAt.value = obj.createdAt.value;
    callback();
  }

  @override
  Future<void> deleteLog(int? obj) async {
    if (obj == null) return;
    await database.waterPumpDao.deleteLogById(obj);
    logList.removeWhere((element) => element.id == obj);
  }

  @override
  Future<void> clearAllLogs() async {
    await database.waterPumpDao.deleteAllLogs();
  }

  @override
  void dispose() {
    clearLogInput();
    super.dispose();
  }

  void _getChartData(){
    if (logList.isEmpty) return;
    final data = logList.reversedCopy();
    for (int i = 0; i < data.length - 1; i++) {
      double previous = data[i].amount.value ?? 0.0;
      double next = data[i + 1].amount.value ?? 1.0;
      double daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[i].createdAt.value ?? ""), DateTime.parse(data[i + 1].createdAt.value ?? ""));
      double difference = previous;
      if (difference >= 0) {
        chartData.add({
          "average": (difference / daysBetween).floorToDouble(),
          "month": DateTime.parse(data[i].createdAt.value ?? "").millisecondsSinceEpoch.toDouble(),
        });
      }
    }
  }
}