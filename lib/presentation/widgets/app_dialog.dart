import 'package:flutter/material.dart';

class AppDialog extends SimpleDialog {

  final String titleText;

  final BuildContext context;

  final List<Widget> widgets;

  AppDialog({super.key, required this.titleText, required this.context, required this.widgets,}) : super(
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
            titleText,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.black,
            ),
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
    children: widgets,
  );

  void show<T>(Function(T data) callback) async {
    callback(await showDialog(
      context: context,
      builder: (context) => this,
    ));
  }
}