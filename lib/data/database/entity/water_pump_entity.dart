import 'package:floor/floor.dart';

@Entity(tableName: 'water_pump_logs')
class WaterPumpEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String createdAt;

  final double amount;

  WaterPumpEntity({
    this.id,
    required this.createdAt,
    required this.amount,
  });
}