import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class GasModel {

  final int? id;

  RxnString createdAt;

  RxnDouble price;

  GasModel({this.id, String? createdAt, double? price})
      : createdAt = RxnString(createdAt), price = RxnDouble(price);
}