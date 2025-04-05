import 'package:dailylog/core/lang/app_localization.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/utils/extensions.dart';
import 'package:dailylog/presentation/controller/log_controller.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/data/database/entity/electricity_entity.dart';
import 'package:dailylog/domain/model/electricity_model.dart';

class ElectricityController extends LogController<ElectricityModel, int> {

  final logList = <ElectricityModel>[].obs;

  final chartData = [].obs;

  RxnString logEntryErrorMessage = RxnString();

  @override
  Future<void> getLogs() async {
    final data = await database.electricityDao.getAllLogs();
    final model = data.map((entity) => ElectricityModel(id: entity.id, createdAt: entity.createdAt, balance: entity.balance)).toList();
    logList.addAll(model);
    _getChartData();
  }

  @override
  Future<void> insertLog(Map<String, dynamic> input, Function() callback) async {
    if (!input.containsKey("balance") || input['balance'].toString().isEmpty){
      logEntryErrorMessage.value = AppLocalization.errorElectricityBalance.tr;
      return;
    }
    clearLogInput();
    int id = await database.electricityDao.insertLog(
        ElectricityEntity(
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          balance: double.parse(input['balance']),
        )
    );
    logList.insert(
        0,
        ElectricityModel(
          id: id,
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          balance: double.parse(input['balance']),
        )
    );
    callback();
  }

  void clearLogInput(){
    logEntryErrorMessage.value = null;
  }

  @override
  Future<void> updateLog(ElectricityModel obj, Function() callback) async {
    if (obj.balance.value == null){
      logEntryErrorMessage.value = AppLocalization.errorElectricityBalance.tr;
      return;
    }
    await database.electricityDao.updateLog(
        ElectricityEntity(
          id: obj.id,
          createdAt: obj.createdAt.value ?? "",
          balance: obj.balance.value ?? 0.00,
        )
    );
    int index = logList.indexWhere((element) => element.id == obj.id);
    logList[index].balance.value = obj.balance.value;
    logList[index].createdAt.value = obj.createdAt.value;
    callback();
  }

  @override
  Future<void> deleteLog(int? obj) async {
    if (obj == null) return;
    await database.electricityDao.deleteLogById(obj);
    logList.removeWhere((element) => element.id == obj);
  }

  @override
  Future<void> clearAllLogs() async {
    await database.electricityDao.deleteAllLogs();
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
      double current = data[i].balance.value ?? 0.0;
      double next = data[i + 1].balance.value ?? 1.0;
      double daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[i].createdAt.value ?? ""), DateTime.parse(data[i + 1].createdAt.value ?? ""));
      double difference = current - next;
      if (difference >= 0) {
        chartData.add({
          "average_cost": (difference / daysBetween).toPrecision(2),
          "month": DateTime.parse(data[i].createdAt.value ?? "").millisecondsSinceEpoch.toDouble(),
        });
      }
    }
  }

  List<double> _getDifference() {
    final data = logList.map((e) => e.balance).toList();
    return data
        .asMap()
        .entries
        .where((entry) => entry.key < data.length - 1)
        .map((entry) => (data[entry.key + 1].value ?? 1.0) - (entry.value.value ?? 0.00))
        .where((diff) => diff >= 0) // Filter non-negative
        .toList();
  }
}