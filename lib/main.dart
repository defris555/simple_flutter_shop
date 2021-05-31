import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'main_app.dart';

main() async {
  await GetStorage.init();
  runApp(MainApp());
}
