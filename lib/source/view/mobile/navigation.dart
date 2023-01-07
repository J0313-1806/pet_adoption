import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/navigation_controller.dart';

class HomeNavigation extends StatelessWidget {
  const HomeNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<NavigationController>(
      init: NavigationController(),
      initState: (_) {},
      builder: (navigationController) {
        return Scaffold(
          body: navigationController.screens
              .elementAt(navigationController.navigationPage.value),
          bottomNavigationBar: BottomNavigationBar(
            items: List.generate(
              3,
              (index) => BottomNavigationBarItem(
                icon: Icon(navigationController.navigationIcons[index]),
                label: navigationController.navigationLabel[index],
              ),
            ),
            onTap: navigationController.navigationTap,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue,
            currentIndex: navigationController.navigationPage.value,
          ),
        );
      },
    );
  }
}
