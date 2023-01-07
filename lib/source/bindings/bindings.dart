import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ProductController());
  }
}
