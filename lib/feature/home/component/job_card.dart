import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../saved/saved_controller.dart';
import '../../../models/job.dart';

class JobCard extends StatelessWidget {
  final Job job;
  const JobCard({required this.job, super.key});

  @override
  Widget build(BuildContext context) {
    final savedC = Get.find<SavedController>();

    return GestureDetector(
      onTap: () => Get.toNamed('/job_detail', arguments: job),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.white60, Colors.blue.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: job.thumbnail.isNotEmpty
                        ? Image.network(
                            job.thumbnail,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.work_outline,
                              color: Colors.black54,
                              size: 30,
                            ),
                          ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          job.company,
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                job.location,
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(
                              Icons.monetization_on_outlined,
                              size: 15,
                              color: Colors.black54,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "\$${job.salary.toStringAsFixed(0)} / month",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Obx(() {
                              final isSaved = savedC.isSaved(job.id);
                              return InkWell(
                                onTap: () => savedC.toggleSave(job),
                                borderRadius: BorderRadius.circular(30),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: isSaved
                                        ? null
                                        : const LinearGradient(
                                            colors: [
                                              Colors.blueGrey,
                                              Colors.white60,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                    color: isSaved ? Colors.transparent : null,
                                    border: Border.all(
                                      color: isSaved
                                          ? Colors.black54
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        isSaved
                                            ? Icons.bookmark_added
                                            : Icons.work_outline,
                                        size: 14,
                                        color: isSaved
                                            ? Colors.black87
                                            : Colors.black,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        isSaved ? 'Saved' : 'Apply',
                                        style: TextStyle(
                                          color: isSaved
                                              ? Colors.black87
                                              : Colors.black,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
