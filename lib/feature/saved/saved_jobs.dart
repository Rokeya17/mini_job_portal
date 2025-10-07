import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/feature/home/component/job_card.dart';
import 'package:mini_job_portal/feature/saved/saved_controller.dart';

class SavedJobsPage extends StatelessWidget {
  const SavedJobsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final savedC = Get.find<SavedController>();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
            'Saved Jobs',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (savedC.saved.isEmpty) {
          return const Center(
            child: Text(
              'You have no saved jobs yet.\nStart saving by tapping the Save icon!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }
        return ListView.builder(
          itemCount: savedC.saved.length,
          itemBuilder: (context, i) {
            final job = savedC.saved[i];
            return JobCard(job: job);
          },
        );
      }),
    );
  }
}
