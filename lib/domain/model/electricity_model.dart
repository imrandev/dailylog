import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ElectricityModel {

  final int? id;

  RxnString createdAt;

  RxnDouble balance;

  ElectricityModel({this.id, String? createdAt, double? balance})
      : balance = RxnDouble(balance), createdAt = RxnString(createdAt);
}