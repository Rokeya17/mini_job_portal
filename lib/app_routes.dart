import 'package:get/get.dart';
import 'package:mini_job_portal/feature/signup/signup_binding.dart';
import 'package:mini_job_portal/feature/signup/signup_view.dart';
import 'package:mini_job_portal/feature/login/login_bindings.dart';
import 'package:mini_job_portal/feature/login/login_view.dart';
import 'feature/home/home_view.dart';
import 'feature/home/component/job_detail_view.dart';
import 'feature/saved/saved_view.dart';
import 'feature/profile/profile_view.dart';

class AppRoutes {
  static const initial = '/login';
  static const login = '/login';
  static const signup = '/signup';
  static const main = '/main';
  static const jobDetail = '/job_detail';
  static const saved = '/saved';
  static const profile = '/profile';

  static final routes = [
    GetPage(name: '/', page: () => const LoginView(), binding: LoginBinding()),
    GetPage(
      name: login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: signup,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(name: main, page: () => const HomeView()),
    GetPage(name: jobDetail, page: () => const JobDetailView()),
    GetPage(name: saved, page: () => const SavedView()),
    GetPage(name: profile, page: () => const ProfileView()),
  ];
}
