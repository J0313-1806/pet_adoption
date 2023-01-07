import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:pet_adoption/source/view/mobile/history.dart';
import 'package:pet_adoption/source/view/mobile/home.dart';
import 'package:pet_adoption/source/view/mobile/wishlist.dart';

class NavigationController extends GetxController {
  final ProductController _productController = Get.find();
  RxInt navigationPage = RxInt(0);
  RxList<Widget> screens = RxList([
    const HomeScreen(),
    const WishListScreen(),
    const OrderHistoryScreen(),
  ]);
  void navigationTap(int index) {
    navigationPage(index);
    if (index == 1) {
      _productController.fetchWishList();
    } else if (index == 2) {
      _productController.fetchHistoryList();
    }
  }

  List<IconData> navigationIcons = const [
    Icons.home,
    Icons.favorite,
    Icons.history,
  ];
  List<String> navigationLabel = const ["Home", "Wishlist", "Orders"];
}
