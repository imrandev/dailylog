import 'package:dailylog/data/database/entity/water_pump_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class WaterPumpDao {

  @Query('SELECT * FROM water_pump_logs ORDER BY createdAt DESC LIMIT 20')
  Future<List<WaterPumpEntity>> getAllLogs();

  @Query('SELECT * FROM water_pump_logs WHERE id = :id')
  Future<WaterPumpEntity?> getLogById(int id);

  @insert
  Future<int> insertLog(WaterPumpEntity entity);

  @update
  Future<void> updateLog(WaterPumpEntity entity);

  @delete
  Future<void> deleteLog(WaterPumpEntity entity);

  @Query('DELETE FROM water_pump_logs')
  Future<void> deleteAllLogs();

  @Query('DELETE FROM water_pump_logs WHERE id = :id')
  Future<void> deleteLogById(int id);

  @Query('SELECT * FROM water_pump_logs ORDER BY createdAt DESC LIMIT 2')
  Future<List<WaterPumpEntity>> getLastTwoLogs();
}