import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:pet_adoption/source/model/animal_model.dart';
import 'package:pet_adoption/source/view/mobile/product.dart';

class PetView extends StatelessWidget {
  const PetView({Key? key, required this.animals, required this.page})
      : super(key: key);

  final RxMap<String, AnimalModel> animals;
  final int page;
  static final ProductController _productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (homeController) {
      return animals.isEmpty
          ? Center(
              child: Text(page == 1
                  ? "Your Wishlist is Empty"
                  : "Your History is Empty"),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1,
              ),
              padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 8.0),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: animals.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => Get.to(
                    () => const ProductScreen(),
                    arguments: animals.values.elementAt(index),
                  ),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
                    decoration: BoxDecoration(
                      color: homeController.dark.value
                          ? const Color(0xff292d32)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: [
                        homeController.dark.value
                            ? const BoxShadow(
                                color: Color.fromARGB(255, 60, 60, 60),
                                offset: Offset(5, 5),
                                spreadRadius: 1,
                                blurRadius: 15,
                              )
                            : BoxShadow(
                                color: Colors.grey.shade400,
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: const Offset(5, 5),
                              ),
                        homeController.dark.value
                            ? const BoxShadow(
                                color: Color(0xff0b0f14),
                                offset: Offset(-5, -5),
                                blurRadius: 15,
                                spreadRadius: 1)
                            : const BoxShadow(
                                color: Colors.white,
                                offset: Offset(-5, -5),
                                blurRadius: 15,
                                spreadRadius: 1),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Hero(
                            tag: animals.values.elementAt(index).picture,
                            child: Image.asset(
                              animals.values.elementAt(index).picture,
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              animals.values.elementAt(index).name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            page == 2
                                ? OutlinedButton(
                                    onPressed: () =>
                                        _productController.onOfferSendTap(
                                            animals[
                                                animals.keys.elementAt(index)]!,
                                            false),
                                    child: const Text("CANCEL"),
                                  )
                                : LikeButton(
                                    onTap: (isLiked) async {
                                      _productController.onLikeButtonTap(
                                          animals[animals.values
                                              .elementAt(index)
                                              .name]!,
                                          !isLiked);

                                      return !isLiked;
                                    },
                                    isLiked: animals.values
                                        .elementAt(index)
                                        .favorite,
                                  ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              animals.values.elementAt(index).price,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            animals.values.elementAt(index).gender == "Male"
                                ? const Icon(
                                    Icons.male,
                                    color: Colors.blue,
                                  )
                                : const Icon(
                                    Icons.female,
                                    color: Colors.pinkAccent,
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}
