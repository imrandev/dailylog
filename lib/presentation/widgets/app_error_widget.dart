import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:dailylog/core/lang/app_localization.dart';
import 'package:dailylog/core/utils/assets_path.dart';

class AppErrorWidget extends StatelessWidget {

  final String? message;

  const AppErrorWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsPath.noDataFound,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          const SizedBox(height: 16.0,),
          Text(
            message ?? AppLocalization.noDataFound.tr,
            style: const TextStyle(
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
}
