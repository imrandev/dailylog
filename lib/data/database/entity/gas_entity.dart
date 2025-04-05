import 'package:floor/floor.dart';

@Entity(tableName: 'gas_logs')
class GasEntity {

  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String createdAt;

  final double price;

  GasEntity({
    this.id,
    required this.createdAt,
    required this.price,
  });
}