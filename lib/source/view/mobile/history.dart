import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:pet_adoption/source/view/mobile/widgets/pet_view.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  static final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.transparent : Colors.white,
        title: Text(
          "Order History",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: PetView(animals: _productController.historyList, page: 2),
    );
  }
}
