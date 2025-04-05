import 'dart:async';

import 'package:dailylog/data/database/dao/water_atm_dao.dart';
import 'package:dailylog/data/database/dao/water_pump_dao.dart';
import 'package:dailylog/data/database/entity/water_atm_entity.dart';
import 'package:dailylog/data/database/entity/water_pump_entity.dart';
import 'package:floor/floor.dart';
import 'package:dailylog/data/database/dao/electricity_dao.dart';
import 'package:dailylog/data/database/dao/gas_dao.dart';
import 'package:dailylog/data/database/entity/electricity_entity.dart';
import 'package:dailylog/data/database/entity/gas_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 10, entities: [ElectricityEntity, GasEntity, WaterPumpEntity, WaterAtmEntity])
abstract class AppDatabase extends FloorDatabase {

  ElectricityDao get electricityDao;

  GasDao get gasDao;

  WaterPumpDao get waterPumpDao;

  WaterAtmDao get waterAtmDao;
}