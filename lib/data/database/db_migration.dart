import 'package:floor/floor.dart';

class DbMigration {

  static List<Migration> list() => [
    Migration(3, 4, (database) async {
      await database.execute('ALTER TABLE meter_logs RENAME TO electricity_logs');

    }),
    Migration(5, 6, (database) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `water_atm_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL)');

    }),
    Migration(5, 6, (database) async {
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `water_pump_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL)');

    }),
    Migration(6, 7, (database) async {
      await database.execute('DROP TABLE water_pump_logs');
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `water_pump_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `amount` REAL NOT NULL)');
    }),
    Migration(8, 9, (database) async {
      await database.execute('DROP TABLE water_atm_logs');
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `water_atm_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL)');
    }),
    Migration(9, 10, (database) async {
      await database.execute('DROP TABLE water_atm_logs');
      await database.execute(
          'CREATE TABLE IF NOT EXISTS `water_atm_logs` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createdAt` TEXT NOT NULL, `balance` REAL NOT NULL, `water_pump_id` INTEGER, FOREIGN KEY (water_pump_id) REFERENCES water_pump_logs(id) ON DELETE CASCADE)');
    }),
  ];
}