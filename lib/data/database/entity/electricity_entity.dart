import 'package:floor/floor.dart';

@Entity(tableName: 'electricity_logs')
class ElectricityEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String createdAt;

  final double balance;

  ElectricityEntity({
    this.id,
    required this.createdAt,
    required this.balance,
  });
}