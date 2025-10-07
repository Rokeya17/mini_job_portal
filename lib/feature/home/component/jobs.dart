import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/controllers/job_controller.dart';
import 'package:mini_job_portal/feature/home/component/job_card.dart';

class JobListPage extends StatelessWidget {
  const JobListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final jobC = Get.find<JobController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Job Feed',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFD), Color(0xFFEFF3F8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Obx(() {
          if (jobC.loading.value) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.teal,
              ),
            );
          }

          if (jobC.error.value != null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.redAccent,
                    size: 48,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Error: ${jobC.error.value}',
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: const Text(
                      'Retry',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: jobC.fetch,
                  ),
                ],
              ),
            );
          }

          if (jobC.jobs.isEmpty) {
            return const Center(
              child: Text(
                'No jobs available right now ',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return RefreshIndicator(
            color: Colors.teal,
            backgroundColor: Colors.white,
            onRefresh: jobC.fetch,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: jobC.jobs.length,
              itemBuilder: (context, i) {
                final job = jobC.jobs[i];
                return AnimatedOpacity(
                  opacity: 1,
                  duration: Duration(milliseconds: 400 + (i * 50)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: JobCard(job: job),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
