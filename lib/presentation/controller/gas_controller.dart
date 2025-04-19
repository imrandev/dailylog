import 'package:dailylog/core/lang/app_localization.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/utils/extensions.dart';
import 'package:dailylog/presentation/controller/log_controller.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/data/database/entity/gas_entity.dart';
import 'package:dailylog/domain/model/gas_model.dart';

class GasController extends LogController<GasModel, int> {

  final logList = <GasModel>[].obs;

  final chartData = [].obs;

  RxnString logEntryErrorMessage = RxnString();

  @override
  Future<void> getLogs() async {
    final data = await database.gasDao.getAllLogs(10);
    final model = data.map((e) => GasModel(id: e.id, createdAt: e.createdAt, price: e.price)).toList();
    logList.addAll(model);
    _getChartData();
  }

  @override
  Future<void> insertLog(Map<String, dynamic> input, Function() callback) async {
    if (!input.containsKey("price") || input['price'].toString().isEmpty){
      logEntryErrorMessage.value = AppLocalization.errorGasPrice.tr;
      return;
    }
    clearLogInput();
    int id = await database.gasDao.insertLog(
        GasEntity(
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          price: double.parse(input['price']),
        )
    );
    logList.insert(
        0,
        GasModel(
          id: id,
          createdAt: input.containsKey("createdAt")
              ? input['createdAt']
              : DateFormatUtil.formatDateTime(DateTime.now()),
          price: double.parse(input['price']),
        )
    );
    callback();
  }

  void clearLogInput(){
    logEntryErrorMessage.value = null;
  }

  @override
  Future<void> updateLog(GasModel obj, Function() callback) async {
    if (obj.price.value == null){
      logEntryErrorMessage.value = AppLocalization.errorGasPrice.tr;
      return;
    }
    await database.gasDao.updateLog(
        GasEntity(
          id: obj.id,
          createdAt: obj.createdAt.value ?? "",
          price: obj.price.value ?? 0.00,
        )
    );
    int index = logList.indexWhere((element) => element.id == obj.id);
    logList[index].price.value = obj.price.value;
    logList[index].createdAt.value = obj.createdAt.value;
    callback();
  }

  @override
  Future<void> deleteLog(int? obj) async {
    if (obj == null) return;
    await database.gasDao.deleteLogById(obj);
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
      double previous = data[i].price.value ?? 0.0;
      double next = data[i + 1].price.value ?? 1.0;
      double daysBetween = DateFormatUtil.getDaysBetween(DateTime.parse(data[i].createdAt.value ?? ""), DateTime.parse(data[i + 1].createdAt.value ?? "")) / 30;
      double difference = previous;
      if (difference >= 0) {
        chartData.add({
          "average_cost": (difference / daysBetween).floorToDouble(),
          "month": DateTime.parse(data[i].createdAt.value ?? "").millisecondsSinceEpoch.toDouble(),
        });
      }
    }
  }
}