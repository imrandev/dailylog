import 'package:dailylog/core/utils/date_format_util.dart';
import 'package:dailylog/presentation/widgets/app_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/presentation/controller/settings_controller.dart';

class SettingsPage extends StatelessWidget {

  final _controller = Get.find<SettingsController>();

  final _addBalanceTextController = TextEditingController();

  final _datePickerTextController = TextEditingController();

  final _params = <String, dynamic>{};

  SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.settings.tr),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalization.switchLanguage.tr),
            subtitle: Text(AppLocalization.defaultLanguage.tr),
            trailing: Obx(() => CupertinoSwitch(
              value: _controller.isBangla.value,
              activeColor: Colors.greenAccent,
              onChanged: _controller.setLanguagePref,
            )),
          ),
          ListTile(
            onTap: () {
              _openAddBalanceForm(context);
            },
            leading: const Icon(Icons.add_card),
            title: Text(AppLocalization.rechargeWaterCard.tr),
            subtitle: Obx(() => Text("${AppLocalization.possibleWaterBalance.tr} [${_controller.lastWaterAtmBalance.value} ${AppLocalization.tk.tr}]")),
            trailing: IconButton(
              tooltip: AppLocalization.resetBalance.tr,
              onPressed: () {
                _openResetDialog(context);
              },
              icon: const Icon(Icons.restart_alt),
            ),
          ),
          ListTile(
            onTap: () {
              _openAddFamilyForm(context);
            },
            leading: const Icon(Icons.family_restroom),
            title: Text(AppLocalization.familyMember.tr),
            subtitle: Obx(() => Text("${_controller.familyMemberCount.value} ${_controller.familyMemberCount.value > 1
                ? AppLocalization.peoples.tr
                : AppLocalization.people.tr}")),
          ),
        ],
      ),
    );
  }

  void _openAddBalanceForm(BuildContext context){
    AppDialog(
      titleText: AppLocalization.newBalance.tr,
      context: context,
      widgets: [
        Obx(() => TextFormField(
          controller: _addBalanceTextController,
          decoration: InputDecoration(
            hintText: AppLocalization.hintWaterBalanceField.tr,
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
            DateFormatUtil.pickDateTime(context, (picked) {
              _datePickerTextController.text = DateFormatUtil.formatDateTime(picked);
              _params['createdAt'] = DateFormatUtil.formatDateTime(picked);
            });
          },
        ),
        const SizedBox(height: 32.0,),
        TextButton(
          onPressed: () async {
            _params['balance'] = _addBalanceTextController.value.text;
            _controller.insertBalance(_params, () {
              _addBalanceTextController.text = "";
              _datePickerTextController.text = "";
              Navigator.pop(context);
            });
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
    ).show((data) {
      _controller.clearLogInput();
    });
  }

  void _openAddFamilyForm(BuildContext context){
    AppDialog(
      titleText: AppLocalization.familyMember.tr,
      context: context,
      widgets: [
        Obx(() => TextFormField(
          controller: _controller.addFamilyTextController,
          decoration: InputDecoration(
            hintText: AppLocalization.hintFamilyField.tr,
            errorText: _controller.logEntryErrorMessage.value,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'[ ,-]')),
          ],
        )),
        const SizedBox(height: 32.0,),
        Text(
          AppLocalization.noticeFamilyCounter.tr,
        ),
        const SizedBox(height: 16.0,),
        TextButton(
          onPressed: () async {
            _controller.updateFamily(() {
              Navigator.pop(context);
            });
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
    ).show((data) {
      _controller.clearLogInput();
    });
  }

  void _openResetDialog(BuildContext context){
    AppDialog(
      titleText: AppLocalization.resetBalance.tr,
      context: context,
      widgets: [
        Text(AppLocalization.hintReset.tr),
        const SizedBox(height: 32.0,),
        TextButton(
          onPressed: () async {
            _controller.resetBalance(() {
              Navigator.pop(context);
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: Text(
            AppLocalization.confirm.tr,
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
}