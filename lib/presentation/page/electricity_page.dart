import 'package:dailylog/presentation/widgets/app_dialog.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/domain/model/electricity_model.dart';
import 'package:dailylog/presentation/controller/electricity_controller.dart';
import 'package:dailylog/presentation/widgets/app_error_widget.dart';
import 'package:dailylog/presentation/widgets/wave_progress_bar.dart';

class ElectricityPage extends StatelessWidget {

  final _electricityLogTextController = TextEditingController();

  final _datePickerTextController = TextEditingController();

  final _params = <String, dynamic>{};

  final _controller = Get.find<ElectricityController>();

  ElectricityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalization.electricityLogs.tr,
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
                              spots: _controller.chartData.map((element) => FlSpot(element['month'], element['average_cost'])).toList(),
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
                  leading: const Icon(Icons.electric_meter_outlined),
                  subtitle: Obx(() => Text(_controller.logList[index].createdAt.value?.split(" ")[1] ?? "")),
                  dense: true,
                  contentPadding: const EdgeInsets.only(left: 16.0, right: 4.0),
                  trailing: SizedBox(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => Text("${_controller.logList[index].balance.value ?? "00.00"} Tk")),
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
          _openMeterLogForm(context);
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void _openMeterLogForm(BuildContext context, {ElectricityModel? model}){
    if (model != null){
      _electricityLogTextController.text = "${model.balance.value ?? 0.00}";
      _datePickerTextController.text = model.createdAt.value ?? "";
    }
    AppDialog(
      titleText: AppLocalization.entryLog.tr,
      context: context,
      widgets: [
        Obx(() => TextFormField(
          controller: _electricityLogTextController,
          decoration: InputDecoration(
            hintText: AppLocalization.hintElectricityField.tr,
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
                ElectricityModel(
                    id: model.id,
                    balance: _electricityLogTextController.value.text.isNotEmpty
                        ? double.parse(_electricityLogTextController.value.text)
                        : null,
                    createdAt: _datePickerTextController.value.text.isNotEmpty
                        ? _datePickerTextController.value.text
                        : DateFormatUtil.formatDateTime(DateTime.now())
                ),
                    () {
                  _electricityLogTextController.text = "";
                  _datePickerTextController.text = "";
                  Navigator.popUntil(context, ModalRoute.withName('/meter'),);
                },
              );
            } else {
              _params['balance'] = _electricityLogTextController.value.text;
              _controller.insertLog(_params, () {
                _electricityLogTextController.text = "";
                _datePickerTextController.text = "";
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
    ).show((data){
      _controller.clearLogInput();
    });
  }

  void _openOptionMenu(BuildContext context, ElectricityModel model) {
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
                _openMeterLogForm(context, model: model);
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
    );
  }

  bool _hasWidthOverflowed(BuildContext context) => (_controller.chartData.length * 60.0) > MediaQuery.of(context).size.width;

  bool _hasHeightOverflowed(BuildContext context) => (_controller.chartData.length * 20.0) > MediaQuery.of(context).size.height * 0.3;
}
