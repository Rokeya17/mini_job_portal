import 'package:get/get.dart';
import '../saved/saved_controller.dart';

class ProfileController extends GetxController {
  final SavedController savedController = Get.find();

  String get displayName {
    final email = 'No user';
    return email;
  }

  int get savedCount => savedController.saved.length;
}
