import 'package:get/get.dart';
import 'package:dailylog/service/database_service.dart';

abstract class LogController<U,D> extends GetxController {

  final database = Get.find<DatabaseService>().database;

  Future<void> getLogs();

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    await getLogs();
  }

  Future<void> insertLog(Map<String, dynamic> input, Function() callback);

  Future<void> updateLog(U obj, Function() callback);

  Future<void> deleteLog(D obj);

  Future<void> clearAllLogs();
}