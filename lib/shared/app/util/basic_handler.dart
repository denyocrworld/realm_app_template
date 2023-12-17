import 'package:realm_app/core.dart';

handleCreate(Function createData) {
  showLoading();
  createData();
  hideLoading();
  Get.back();
  ss("Data created");
}

handleUpdate(Function updateData, dynamic item) {
  showLoading();
  updateData(item);
  hideLoading();
  Get.back();
  ss("Data updated");
}
