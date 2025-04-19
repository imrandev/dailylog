import 'package:dailylog/core/routes/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/presentation/controller/home_controller.dart';
import 'package:dailylog/presentation/widgets/wave_progress_bar.dart';

class HomePage extends StatelessWidget {

  final _controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.dailyLog.tr,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getElectricityDashWidget(context),
            _getGasAverageCostWidget(context),
            Row(
              children: [
                Expanded(
                  child: _getWaterPumpCostWidget(context),
                ),
                Expanded(
                  child: _getAverageDrinkWidget(context),
                ),
              ],
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _controller.menuList.length,
              itemBuilder: (context, index) => _getOptionMenuTile(context, index),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getElectricityDashWidget(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    alignment: Alignment.center,
    margin: const EdgeInsets.only(bottom: 16.0,),
    child: Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Obx(() => WaveProgressBar(
                  value: _controller.dailyAverageElectricityCost.value,
                  maxValue: 19.6,
                  height: 48.0,
                  radius: 1.0,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.only(left: 8.0,),
                      child: const Icon(
                        Icons.electric_bolt,
                        size: 24.0,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalization.dailyAverageCost.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                          Obx(() => Text(
                            "${_controller.dailyAverageElectricityCost.value.toStringAsFixed(2)} ${AppLocalization.tk.tr}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 48.0,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Obx(() => WaveProgressBar(
                  value: _controller.estimateDaysToBeContinue.value.toDouble(),
                  maxValue: _controller.estimateDays.toDouble(),
                  height: 48.0,
                  radius: 1.0,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white70,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.only(left: 8.0,),
                      child: const Icon(Icons.access_time_outlined, size: 24.0, color: Colors.black),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalization.itMayContinueFor.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 10.0,
                            ),
                          ),
                          Obx(() => Text(
                            "${_controller.estimateDaysToBeContinue.value} ${_controller.estimateDaysToBeContinue.value > 1
                                ? AppLocalization.days.tr
                                : AppLocalization.day.tr
                            }",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _getGasAverageCostWidget(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16.0, right: 4.0, left: 4.0),
    padding: const EdgeInsets.only(left: 8.0, right: 24.0),
    height: 48.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24.0),
      color: Colors.greenAccent,
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        const WaveProgressBar(
          value: 0,
          maxValue: 1,
          height: 48.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70,
              ),
              padding: const EdgeInsets.all(4.0),
              child: const Icon(Icons.gas_meter_outlined, size: 24.0, color: Colors.black),
            ),
            Text(
              AppLocalization.lastAverageMonthlyCost.tr,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
            Obx(() => Text(
              "${_controller.monthlyAverageGasCost.value} ${AppLocalization.tk.tr}",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
          ],
        ),
      ],
    ),
  );

  Widget _getWaterPumpCostWidget(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16.0, right: 4.0, left: 4.0),
    height: 48.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24.0),
      color: Colors.greenAccent,
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        const WaveProgressBar(
          value: 0,
          maxValue: 1,
          height: 48.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70,
              ),
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 8.0,),
              child: const Icon(Icons.water_damage_outlined, size: 24.0, color: Colors.black),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalization.possibleWaterBalance.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                    ),
                  ),
                  Obx(() => Text(
                    "${_controller.lastWaterAtmBalance.value} ${AppLocalization.tk.tr}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _getAverageDrinkWidget(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 16.0, right: 4.0, left: 4.0),
    height: 48.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24.0),
      color: Colors.greenAccent,
    ),
    child: Stack(
      alignment: Alignment.centerLeft,
      children: [
        const WaveProgressBar(
          value: 0,
          maxValue: 1,
          height: 48.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white70,
              ),
              padding: const EdgeInsets.all(4.0),
              margin: const EdgeInsets.only(left: 8.0,),
              child: const Icon(Icons.water_drop_outlined, size: 24.0, color: Colors.black),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalization.dailyWaterIntake.tr,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10.0,
                    ),
                  ),
                  Obx(() => Text(
                    "${_controller.possibleDrinkCount.value}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _getOptionMenuTile(BuildContext context, int index) => Stack(
    alignment: Alignment.bottomCenter,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    children: [
      const WaveProgressBar(
        value: 0.5,
        maxValue: 1,
        radius: 16.0,
      ),
      ListTile(
        onTap: () {
          _navigateTo(_controller.menuList[index]);
        },
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: const BorderSide(
            color: Colors.greenAccent,
            width: 0.5,
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_controller.iconList[index], size: 54.0, color: Colors.green,),
            SizedBox(
              width: 100,
              child: Text(
                _controller.menuList[index].tr,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  void _navigateTo(String menu) {
    switch(menu){
      case AppLocalization.cylinderGas:
        Get.toNamed(RoutePaths.gas)?.then((value) {
          _controller.fetchDashboard();
        });
        break;
      case AppLocalization.electricityMeter:
        Get.toNamed(RoutePaths.electric)?.then((value) {
          _controller.fetchDashboard();
        });
        break;
      case AppLocalization.waterPump:
        Get.toNamed(RoutePaths.waterPump)?.then((value) {
          _controller.fetchDashboard();
        });
        break;
      case AppLocalization.settings:
        Get.toNamed(RoutePaths.settings)?.then((value) {
          _controller.fetchDashboard();
        });
        break;
      default:
        Get.snackbar(AppLocalization.newFeature.tr, AppLocalization.comingSoon.tr);
        break;
    }
  }
}
