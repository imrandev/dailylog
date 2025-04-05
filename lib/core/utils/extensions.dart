import 'dart:typed_data';

extension ReverseList<T> on List<T> {
  List<T> reversedCopy() => reversed.toList();
}

extension HexList on Uint8List {
  String get hexString => map((byte) => byte.toRadixString(16).padLeft(2, '0')).join(':');
}