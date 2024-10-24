import 'package:get/get.dart';
import 'package:myobat/app/data/medicine.dart';
import 'package:myobat/app/helper/db_helper.dart';

class HomeController extends GetxController {
  var db = DbHelper();
  List<Medicine> listMedicines = <Medicine>[].obs;
  @override
  void onInit() {
    super.onInit();
    getAllMedicineData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getAllMedicineData() async {
    RxStatus.loading();
    listMedicines.clear();
    final List<Medicine> medicines = await db.queryAllRowsMedicine();
    listMedicines.addAll(medicines);
    if (listMedicines.isEmpty) {
      RxStatus.empty();
    } else {
      RxStatus.success();
    }
  }
}
