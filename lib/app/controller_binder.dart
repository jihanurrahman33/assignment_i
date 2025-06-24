import 'package:assignment/features/auth/ui/controllers/login_controller.dart';
import 'package:assignment/features/customer_list/ui/controllers/customer_list_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.put(CustomerListController());
  }
}
