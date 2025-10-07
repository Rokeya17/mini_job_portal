import 'package:flutter/material.dart';
import 'package:mini_job_portal/app.dart';
import 'package:mini_job_portal/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  runApp(const JobPortal());
}
