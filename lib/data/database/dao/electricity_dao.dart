import 'package:floor/floor.dart';
import 'package:dailylog/data/database/entity/electricity_entity.dart';

@dao
abstract class ElectricityDao {

  @Query('SELECT * FROM electricity_logs ORDER BY createdAt DESC LIMIT :limit')
  Future<List<ElectricityEntity>> getAllLogs(int limit);

  @Query('SELECT * FROM electricity_logs WHERE id = :id')
  Future<ElectricityEntity?> getLogById(int id);

  @insert
  Future<int> insertLog(ElectricityEntity entity);

  @update
  Future<void> updateLog(ElectricityEntity entity);

  @delete
  Future<void> deleteLog(ElectricityEntity entity);

  @Query('DELETE FROM electricity_logs')
  Future<void> deleteAllLogs();

  @Query('SELECT * FROM electricity_logs ORDER BY createdAt DESC LIMIT 3')
  Future<List<ElectricityEntity>> getLastLogs();

  @Query('DELETE FROM electricity_logs WHERE id = :id')
  Future<void> deleteLogById(int id);
}