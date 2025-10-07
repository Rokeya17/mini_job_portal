import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/job.dart';

class SavedController extends GetxController {
  var saved = <Job>[].obs;
  late SharedPreferences _prefs;
  static const _savedJobsKey = 'saved_jobs';

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    final raw = _prefs.getStringList(_savedJobsKey) ?? [];
    final list = raw
        .map((s) {
          try {
            final m = json.decode(s);
            return Job.fromJson(Map<String, dynamic>.from(m));
          } catch (e) {
            return null;
          }
        })
        .whereType<Job>()
        .toList();
    saved.assignAll(list);
  }

  Future<void> toggleSave(Job job) async {
    final exists = saved.any((j) => j.id == job.id);
    if (exists) {
      saved.removeWhere((j) => j.id == job.id);
    } else {
      saved.add(job);
    }
    await _persist();
  }

  bool isSaved(int id) => saved.any((j) => j.id == id);

  Future<void> _persist() async {
    final raws = saved.map((j) => json.encode(j.toJson())).toList();
    await _prefs.setStringList(_savedJobsKey, raws);
  }
}
