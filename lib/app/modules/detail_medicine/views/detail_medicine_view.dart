import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myobat/app/data/medicine.dart';
import 'package:myobat/app/data/notification.dart' as notif;
import 'package:myobat/app/utils/notification_api.dart';
import '../controllers/detail_medicine_controller.dart';

class DetailMedicineView extends GetView<DetailMedicineController> {
  const DetailMedicineView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Detail Aktivitas',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 206, 136, 218),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: ListView(
          children: [
            FutureBuilder<Medicine>(
              future: controller.getMedicineData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      title: Text(
                        snapshot.data!.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "${snapshot.data!.frequency.toString()} kali sehari",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 13),
            FutureBuilder<List<notif.Notification>>(
              future: controller.getNotificationData(Get.arguments),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 2,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            child: ListTile(
                              leading: const Icon(Icons.alarm),
                              title: Text(snapshot.data![index].time),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 206, 136, 218),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  controller.deleteMedicine(Get.arguments);
                  NotificationApi.showNotification(
                    id: 99, // A unique ID for this notification
                    title: 'Good!',
                    body: 'Aktivitas selesai',
                    payload: 'Congrats notification',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
