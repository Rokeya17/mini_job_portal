import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_job_portal/feature/home/component/jobs.dart';
import 'package:mini_job_portal/feature/profile/profile_view.dart';
import 'package:mini_job_portal/feature/saved/saved_jobs.dart';
import 'dart:ui';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = 0.obs;

    final List<Widget> pages = const [
      JobListPage(),
      SavedJobsPage(),
      ProfileView(),
    ];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Obx(() => IndexedStack(index: selectedIndex.value, children: pages)),
        ],
      ),

      bottomNavigationBar: Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: BottomNavigationBar(
                backgroundColor: Colors.white.withOpacity(0.7),
                elevation: 0,
                currentIndex: selectedIndex.value,
                type: BottomNavigationBarType.fixed,
                onTap: (i) => selectedIndex.value = i,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.black54,
                showUnselectedLabels: true,
                selectedFontSize: 13,
                unselectedFontSize: 12,
                items: [
                  _navItem(
                    icon: Icons.work_outline,
                    activeIcon: Icons.work,
                    label: 'Jobs',
                    index: 0,
                    selectedIndex: selectedIndex.value,
                  ),
                  _navItem(
                    icon: Icons.bookmark_border,
                    activeIcon: Icons.bookmark,
                    label: 'Saved',
                    index: 1,
                    selectedIndex: selectedIndex.value,
                  ),
                  _navItem(
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: 'Profile',
                    index: 2,
                    selectedIndex: selectedIndex.value,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _navItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    required int selectedIndex,
  }) {
    final bool isSelected = index == selectedIndex;

    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Colors.blueAccent, Colors.white60],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? activeIcon : icon,
          color: isSelected ? Colors.white : Colors.black54,
          size: 24,
        ),
      ),
      label: label,
    );
  }
}
