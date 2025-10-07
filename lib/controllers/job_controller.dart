import 'package:get/get.dart';
import '../models/job.dart';
import '../services/api_service.dart';

class JobController extends GetxController {
  final ApiService _apiService = Get.find<ApiService>();
  var jobs = <Job>[].obs;
  var loading = false.obs;
  var error = RxnString();

  @override
  void onInit() {
    super.onInit();
    fetch();
  }

  Future<void> fetch() async {
    try {
      loading.value = true;
      final list = await _apiService.fetchJobs(limit: 50);
      jobs.assignAll(list);
      error.value = null;
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }

  Job? findById(int id) {
    try {
      return jobs.firstWhere((j) => j.id == id);
    } catch (e) {
      return null;
    }
  }
}
