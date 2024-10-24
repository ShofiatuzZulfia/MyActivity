import 'package:get/get.dart';
import 'package:myobat/app/data/medicine.dart';
import 'package:myobat/app/data/notification.dart';
import 'package:myobat/app/helper/db_helper.dart';
import 'package:myobat/app/modules/home/controllers/home_controller.dart';
import 'package:myobat/app/utils/notification_api.dart';

class DetailMedicineController extends GetxController {
  var db = DbHelper();
  HomeController homeController = Get.put(HomeController());
  late List<Notification> listNotification;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<Medicine> getMedicineData(int id) async {
    return await db.queryOneMedicine(id);
  }

  Future<List<Notification>> getNotificationData(int id) async {
    listNotification = await db.getNotificationsByMedicineId(id);
    return listNotification;
  }

  void deleteMedicine(int id) async {
    listNotification.forEach((element) {
      NotificationApi.cancelNotification(element.id!);
    });
    await db.deleteMedicine(id);
    await db.deleteNotificationByMedicineId(id);

    homeController.getAllMedicineData();
    Get.back();
  }
}
