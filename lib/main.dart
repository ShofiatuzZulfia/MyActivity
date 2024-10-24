import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myobat/app/utils/notification_api.dart';
import 'app/routes/app_pages.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationApi.init();
  runApp(
    GetMaterialApp(
      title: "MyActivity",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
