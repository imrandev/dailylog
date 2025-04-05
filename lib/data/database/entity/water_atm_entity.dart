import 'package:dailylog/data/database/entity/water_pump_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'water_atm_logs', foreignKeys: [
  ForeignKey(
    childColumns: ['water_pump_id'],
    parentColumns: ['id'],
    entity: WaterPumpEntity,
    onDelete: ForeignKeyAction.cascade,
  )
])
class WaterAtmEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String createdAt;

  final double balance;

  @ColumnInfo(name: 'water_pump_id')
  final int? waterPumpId;

  WaterAtmEntity({
    this.id,
    required this.createdAt,
    required this.balance,
    this.waterPumpId,
  });
}