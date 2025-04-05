import 'package:dailylog/core/routes/route_paths.dart';
import 'package:dailylog/domain/model/water_pump_model.dart';
import 'package:dailylog/presentation/controller/water_pump_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/presentation/widgets/app_error_widget.dart';
import 'package:dailylog/presentation/widgets/wave_progress_bar.dart';

class WaterPumpPage extends StatelessWidget {

  final _waterPumpLogTextController = TextEditingController();

  final _datePickerTextController = TextEditingController();

  final _params = <String, dynamic>{};

  final _controller = Get.find<WaterPumpController>();

  WaterPumpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.waterPump.tr,
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.greenAccent,
              child: Obx(() => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: _hasWidthOverflowed(context) ? _controller.chartData.length * 60.0 : MediaQuery.of(context).size.width,
                  height: _hasHeightOverflowed(context) ? _controller.chartData.length * 20.0 : MediaQuery.of(context).size.height * 0.3,
                  child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        WaveProgressBar(
                          value: 0.25,
                          maxValue: 1,
                          height: _hasHeightOverflowed(context) ? _controller.chartData.length * 20.0 : MediaQuery.of(context).size.height * 0.3,
                          radius: 1.0,
                        ),
                        LineChart(
                          LineChartData(
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(DateFormatUtil.fromMillisecondsToString(value.toInt()));
                                  },
                                ),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    return Text(DateFormatUtil.fromMillisecondsToString(value.toInt()));
                                  },
                                ),
                              ),
                            ),
                            lineBarsData: [
                              LineChartBarData(
                                spots: _controller.chartData.map(
                                        (element) => FlSpot(element['month'], element['average'])
                                ).toList(),
                                isCurved: true,
                                barWidth: 2,
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                ),
              )),
            ),
            Expanded(
              child: Obx(() => _controller.logList.isNotEmpty ? ListView.builder(
                itemCount: _controller.logList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () {

                  },
                  title: Obx(() => Text(_controller.logList[index].createdAt.value?.split(" ")[0] ?? "")),
                  leading: const Icon(Icons.water_damage_outlined),
                  subtitle: Obx(() => Text(_controller.logList[index].createdAt.value?.split(" ")[1] ?? "")),
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
                  trailing: SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text("${_controller.logList[index].amount.value ?? "00.00"} Litre")),
                        Expanded(
                          child: IconButton(
                            onPressed: () {
                              _openOptionMenu(context, _controller.logList[index]);
                            },
                            icon: const Icon(Icons.more_vert_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ) : const AppErrorWidget()),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openWaterPumpLogForm(context);
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _openWaterPumpLogForm(BuildContext context, {WaterPumpModel? model}){
    if (model != null){
      _waterPumpLogTextController.text = "${model.amount.value ?? 0.00}";
      _datePickerTextController.text = model.createdAt.value ?? "";
    }
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        clipBehavior: Clip.antiAlias,
        contentPadding: const EdgeInsets.all(16.0),
        title: Container(
          height: 72.0,
          color: Colors.greenAccent,
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalization.entryLog.tr,
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.clear, color: Colors.black,),
              ),
            ],
          ),
        ),
        titlePadding: const EdgeInsets.only(
          left: 0.0,
          top: 0.0,
          right: 0.0,
          bottom: 8.0,
        ),
        children: [
          Obx(() => TextFormField(
            controller: _waterPumpLogTextController,
            decoration: InputDecoration(
              hintText: AppLocalization.hintWaterAmountField.tr,
              errorText: _controller.logEntryErrorMessage.value,
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'[ ,-]')),
            ],
          )),
          const SizedBox(height: 8.0,),
          TextFormField(
            controller: _datePickerTextController,
            decoration: InputDecoration(
              hintText: AppLocalization.hintCalendarField.tr,
            ),
            keyboardType: TextInputType.number,
            readOnly: true,
            onTap: () {
              DateFormatUtil.pickDateTime(context, selectedDateTime: model?.createdAt.value, (picked) {
                _datePickerTextController.text = DateFormatUtil.formatDateTime(picked);
                _params['createdAt'] = DateFormatUtil.formatDateTime(picked);
              });
            },
          ),
          const SizedBox(height: 32.0,),
          TextButton(
            onPressed: () async {
              if (model != null){
                await _controller.updateLog(
                  WaterPumpModel(
                      id: model.id,
                      amount: _waterPumpLogTextController.value.text.isNotEmpty
                          ? double.parse(_waterPumpLogTextController.value.text)
                          : null,
                      createdAt: _datePickerTextController.value.text.isNotEmpty
                          ? _datePickerTextController.value.text
                          : DateFormatUtil.formatDateTime(DateTime.now())
                  ), () {
                    _waterPumpLogTextController.text = "";
                    _datePickerTextController.text = "";
                    _params['createdAt'] = "";
                    Navigator.popUntil(context, ModalRoute.withName(RoutePaths.waterPump),);
                  },
                );
              } else {
                _params['amount'] = _waterPumpLogTextController.value.text;
                _controller.insertLog(_params, () {
                  _waterPumpLogTextController.text = "";
                  _datePickerTextController.text = "";
                  _params['createdAt'] = "";
                  _params['amount'] = "";
                  Navigator.pop(context);
                });
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            child: Text(
              AppLocalization.submit.tr,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ).then((value) {
      _controller.clearLogInput();
    });
  }

  void _openOptionMenu(BuildContext context, WaterPumpModel model) {
    Get.bottomSheet(
      Container(
        height: 160,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                _openWaterPumpLogForm(context, model: model);
              },
              leading: const Icon(Icons.edit),
              title: Text(AppLocalization.edit.tr),
            ),
            ListTile(
              onTap: () {
                _controller.deleteLog(model.id);
                Get.back();
              },
              leading: const Icon(Icons.delete),
              title: Text(AppLocalization.delete.tr),
            ),
          ],
        ),
      ),
      // Optional parameters
      isScrollControlled: true,
      enableDrag: true,
    );
  }

  bool _hasWidthOverflowed(BuildContext context) =>
      (_controller.chartData.length * 60.0) > MediaQuery.of(context).size.width;

  bool _hasHeightOverflowed(BuildContext context) =>
      (_controller.chartData.length * 20.0) > MediaQuery.of(context).size.height * 0.3;
}
