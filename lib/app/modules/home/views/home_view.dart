import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myobat/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Activitas',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 206, 136, 218),
      ),
      body: Obx(
        () {
          if (controller.listMedicines.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Tambahkan dulu aktivitasmu :)',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              itemCount: controller.listMedicines.length,
              itemBuilder: (context, index) {
                final medicine = controller.listMedicines[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(
                        top: 5, left: 15, right: 15, bottom: 5),
                    title: Text(
                      medicine.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      "${medicine.frequency.toString()} kali sehari",
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        color: Color.fromARGB(255, 206, 136, 218)),
                    onTap: () => Get.toNamed(Routes.DETAIL_MEDICINE,
                        arguments: medicine.id),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_SCHEDULE);
        },
        backgroundColor: Color.fromARGB(255, 206, 136, 218),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
