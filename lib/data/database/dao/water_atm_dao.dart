import 'package:dailylog/data/database/entity/water_atm_entity.dart';
import 'package:floor/floor.dart';

@dao
abstract class WaterAtmDao {

  @Query('SELECT * FROM water_atm_logs ORDER BY createdAt DESC LIMIT 20')
  Future<List<WaterAtmEntity>> getAllLogs();

  @Query('SELECT * FROM water_atm_logs WHERE id = :id')
  Future<WaterAtmEntity?> getLogById(int id);

  @insert
  Future<int> insertLog(WaterAtmEntity entity);

  @update
  Future<void> updateLog(WaterAtmEntity entity);

  @delete
  Future<void> deleteLog(WaterAtmEntity entity);

  @Query('DELETE FROM water_atm_logs')
  Future<void> deleteAllLogs();

  @Query('DELETE FROM water_atm_logs WHERE water_pump_id = :id')
  Future<void> deleteLogById(int id);

  @Query('SELECT * FROM water_atm_logs ORDER BY createdAt DESC LIMIT 1')
  Future<WaterAtmEntity?> getLastBalance();
}