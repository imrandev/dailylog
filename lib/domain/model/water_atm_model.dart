import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class WaterAtmModel {

  final int? id;

  RxnString createdAt;

  RxnDouble balance;

  WaterAtmModel({this.id, String? createdAt, double? balance})
      : createdAt = RxnString(createdAt), balance = RxnDouble(balance);
}