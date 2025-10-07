import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'saved_controller.dart';
import '../../models/job.dart';

class SavedView extends StatelessWidget {
  const SavedView({super.key});

  @override
  Widget build(BuildContext context) {
    final savedC = Get.find<SavedController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Jobs')),
      body: Obx(() {
        if (savedC.saved.isEmpty) {
          return const Center(child: Text('No saved jobs'));
        }
        return ListView.builder(
          itemCount: savedC.saved.length,
          itemBuilder: (context, i) {
            final Job job = savedC.saved[i];
            return ListTile(
              leading: job.thumbnail.isNotEmpty
                  ? Image.network(
                      job.thumbnail,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.work),
              title: Text(job.title),
              subtitle: Text(
                '${job.company} • \$${job.salary.toStringAsFixed(0)}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => savedC.toggleSave(job),
              ),
              onTap: () => Get.toNamed('/job_detail', arguments: job),
            );
          },
        );
      }),
    );
  }
}
