import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/app_routes.dart';
import 'package:mini_job_portal/binding/initial_binding.dart';

class JobPortal extends StatelessWidget {
  const JobPortal({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.initial,
      initialBinding: InitialBinding(),
      getPages: AppRoutes.routes,
    );
  }
}
