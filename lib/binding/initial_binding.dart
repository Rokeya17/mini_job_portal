import 'package:get/get.dart';
import 'package:mini_job_portal/services/api_service.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/job_controller.dart';
import '../feature/saved/saved_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ApiService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => JobController(), fenix: true);
    Get.lazyPut(() => SavedController(), fenix: true);
  }
}
