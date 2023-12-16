import 'package:auther/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../features/user_auth/presentation/pages/profile_page.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {

    final contoller = Get.put(NavigationContoller());

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 75,
          elevation: 0,
          selectedIndex: contoller.selectedindex.value,
          onDestinationSelected: (index) => contoller.selectedindex.value = index,
          indicatorColor: Colors.amber.withOpacity(0.4),


          destinations: [
            NavigationDestination(icon: Icon(Icons.fullscreen), label: 'Сканер'),
    NavigationDestination(icon: Icon(Icons.person), label: 'Профиль')],
        ),
      ),
      body: Obx(()=> contoller.screens[contoller.selectedindex.value]),
    );
  }
}

class NavigationContoller extends GetxController{
  final Rx<int> selectedindex = 0.obs;

  final screens = [const HomePage(), const ProfilePage()];
}