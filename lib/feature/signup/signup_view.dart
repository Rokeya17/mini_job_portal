import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white38, Colors.black54],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Create Account',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Start your journey with us!',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(color: Colors.black),
                            decoration: _inputDecoration(
                              'Full Name',
                              Icons.person_outline,
                            ),
                            validator: (v) => (v?.isEmpty ?? true)
                                ? 'Name is required'
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: const TextStyle(color: Colors.black),
                            decoration: _inputDecoration(
                              'Email',
                              Icons.email_outlined,
                            ),
                            validator: (v) {
                              if (v?.isEmpty ?? true) {
                                return 'Email is required';
                              }
                              if (!GetUtils.isEmail(v!)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: controller.passwordController,
                            style: const TextStyle(color: Colors.black),
                            decoration: _inputDecoration(
                              'Password',
                              Icons.lock_outline,
                            ),
                            obscureText: true,
                            validator: (v) {
                              if (v?.isEmpty ?? true) {
                                return 'Password is required';
                              }
                              final passwordRegex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
                              );
                              if (!passwordRegex.hasMatch(v!)) {
                                return 'Password must contain at least:\n• 8 characters\n• One uppercase letter\n• One lowercase letter\n• One number\n• One special character';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Obx(
                            () => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black.withOpacity(0.8),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: controller.isLoading.value
                                  ? null
                                  : controller.signup,
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text('Sign Up'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () => Get.offNamed('/login'),
                            child: const Text(
                              'Already have an account? Log In',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black87),
      prefixIcon: Icon(icon, color: Colors.black87),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      errorStyle: TextStyle(
        color: const Color.fromARGB(255, 178, 19, 7),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
