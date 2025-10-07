import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/auth_controller.dart';

class SignupController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;

  final authC = Get.find<AuthController>();

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> signup() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;
        final ok = await authC.signup(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        if (!ok) {
          Get.snackbar(
            'Signup Failed',
            'Could not create user. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withOpacity(0.8),
            colorText: Colors.white,
          );
        }
      } catch (e) {
        Get.snackbar('Error', 'An unexpected error occurred: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }
}
