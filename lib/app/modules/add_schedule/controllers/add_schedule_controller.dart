import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myobat/app/data/medicine.dart';
import 'package:myobat/app/data/notification.dart' as notif;
import 'package:myobat/app/helper/db_helper.dart';
import 'package:myobat/app/modules/home/controllers/home_controller.dart';
import 'package:myobat/app/utils/notification_api.dart';

class AddScheduleController extends GetxController {
  late TextEditingController nameController;
  late TextEditingController frequencyController;
  final List<TextEditingController> timeController =
      [TextEditingController()].obs;

  var db = DbHelper();
  final frequency = 0.obs;

  HomeController homeController = Get.put(HomeController());

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    NotificationController.init();
    NotificationApi.init();

    nameController = TextEditingController();
    frequencyController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void add(String name, int frequency,
      List<TextEditingController> timeController) async {
    await db.insertMedicine(Medicine(name: name, frequency: frequency));

    var lastMedicineId = await db.getLastMedicineId();

    for (int i = 1; i <= frequency; i++) {
      await db.insertNotification(notif.Notification(
          idMedicine: lastMedicineId, time: timeController[i].text));
    }

    List<notif.Notification> notifications =
        await db.getNotificationsByMedicineId(lastMedicineId);

    for (var element in notifications) {
      NotificationApi.scheduledNotification(
        id: element.id!,
        title: "Waktunya $name",
        body: "Jangan sampai telat yaa:)",
        payload: name,
        scheduledDate: TimeOfDay(
          hour: int.parse(element.time.split(':')[0]),
          minute: int.parse(element.time.split(':')[1]),
        ),
      ).then((value) => print("notif ${element.id} scheduled"));
    }
    print("sukses?");
    homeController.getAllMedicineData();
    Get.back();
  }
}
