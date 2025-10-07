import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/auth_controller.dart';

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
