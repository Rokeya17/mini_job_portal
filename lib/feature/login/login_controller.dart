import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/auth_controller.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailTEcontroller = TextEditingController();
  final passTEcontroller = TextEditingController();
  final isLoading = false.obs;

  @override
  void onClose() {
    emailTEcontroller.dispose();
    passTEcontroller.dispose();
    super.onClose();
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;
        final auth = Get.find<AuthController>();
        final ok = await auth.login(
          emailTEcontroller.text.trim(),
          passTEcontroller.text.trim(),
        );
        if (!ok) {
          Get.snackbar(
            'Login Failed',
            'Invalid credentials. Please try again or sign up.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      } finally {
        isLoading.value = false;
      }
    }
  }
}
