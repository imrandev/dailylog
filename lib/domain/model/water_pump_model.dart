import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class WaterPumpModel {

  final int? id;

  RxnString createdAt;

  RxnDouble amount;

  WaterPumpModel({this.id, String? createdAt, double? amount})
      : createdAt = RxnString(createdAt), amount = RxnDouble(amount);
}