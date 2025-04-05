import 'package:floor/floor.dart';
import 'package:dailylog/data/database/entity/gas_entity.dart';

@dao
abstract class GasDao {

  @Query('SELECT * FROM gas_logs ORDER BY createdAt DESC LIMIT 20')
  Future<List<GasEntity>> getAllLogs();

  @Query('SELECT * FROM gas_logs WHERE id = :id')
  Future<GasEntity?> getLogById(int id);

  @insert
  Future<int> insertLog(GasEntity entity);

  @update
  Future<void> updateLog(GasEntity entity);

  @delete
  Future<void> deleteLog(GasEntity entity);

  @Query('DELETE FROM gas_logs')
  Future<void> deleteAllLogs();

  @Query('DELETE FROM gas_logs WHERE id = :id')
  Future<void> deleteLogById(int id);

  @Query('SELECT * FROM gas_logs ORDER BY createdAt DESC LIMIT 2')
  Future<List<GasEntity>> getLastTwoLogs();
}