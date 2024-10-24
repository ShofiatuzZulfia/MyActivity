import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_schedule_controller.dart';

// ignore: must_be_immutable
class AddScheduleView extends GetView<AddScheduleController> {
  TimeOfDay timeOfDay = TimeOfDay.now();
  final _formKey = GlobalKey<FormState>();

  AddScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Tambah Aktivitas',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 206, 136, 218),
        ),
        body: Form(
          key: _formKey,
          child: Center(
              child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: controller.nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Nama Aktivitas',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kolom ini tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: TextFormField(
                  controller: controller.frequencyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    labelText: 'Jumlah Aktivitas',
                  ),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    controller.frequency.value = int.parse(value);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Kolom ini tidak boleh kosong';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Hanya boleh diisi dengan angka';
                    }
                    if (int.parse(value) < 1) {
                      return 'Frekuensi tidak boleh kurang dari 1';
                    }
                    return null;
                  },
                ),
              ),
              Obx(
                () => Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.frequency.value,
                      itemBuilder: (context, index) {
                        final timeController = TextEditingController();
                        return Container(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextFormField(
                            controller: timeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: 'Jam Aktivitas ke-${index + 1}',
                            ),
                            textInputAction: TextInputAction.next,
                            onTap: () {
                              displayTimePicker(context, timeController);
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Kolom ini tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                        );
                      },
                    )),
              ),
              Container(
                  height: 70,
                  padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color.fromARGB(255, 206, 136, 218),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                    child: const Text('Tambah',
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.add(
                            controller.nameController.text,
                            controller.frequency.value,
                            controller.timeController);
                        Get.back();
                      }
                    },
                  )),
            ],
          )),
        ));
  }

  Future displayTimePicker(
      BuildContext context, TextEditingController textfieldController) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      textfieldController.text = "${time.hour}:${time.minute}";
      controller.timeController.add(textfieldController);
    }
  }
}
