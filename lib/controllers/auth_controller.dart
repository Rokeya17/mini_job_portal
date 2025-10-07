import 'package:get/get.dart';
import 'package:mini_job_portal/services/storage_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  var userEmail = RxnString();
  var userName = RxnString();
  var savedJobsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final user = StorageService.getLoggedInUser();
    if (user != null && user.isNotEmpty) {
      final name = StorageService.getUserName(user) ?? "User";
      _updateUserData(user, name);
      isLoggedIn.value = true;
      Future.microtask(() => Get.offAllNamed('/main'));
    }
  }

  void _updateUserData(String email, String name) {
    userEmail.value = email;
    userName.value = name;
    savedJobsCount.value = 0;
  }

  Future<bool> signup(String name, String email, String password) async {
    await StorageService.saveUser(name, email, password);

    await StorageService.setLoggedInUser(email);
    isLoggedIn.value = true;
    _updateUserData(email, name);
    Get.offAllNamed('/main');
    return true;
  }

  Future<bool> login(String email, String password) async {
    final valid = StorageService.validateUser(email, password);

    if (valid) {
      await StorageService.setLoggedInUser(email);
      isLoggedIn.value = true;
      final name = StorageService.getUserName(email) ?? "User";
      _updateUserData(email, name);
      Get.offAllNamed('/main');
    }
    return valid;
  }

  Future<void> logout() async {
    await StorageService.logout();
    isLoggedIn.value = false;
    userEmail.value = null;
    userName.value = null;
    savedJobsCount.value = 0;
    Get.offAllNamed('/login');
  }
}
