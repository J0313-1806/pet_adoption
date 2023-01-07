import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:pet_adoption/source/view/mobile/widgets/carousel_indicator.dart';
import 'package:pet_adoption/source/view/mobile/widgets/seller_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  static final ProductController _productController =
      Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Get.isDarkMode ? Colors.transparent : Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          Get.arguments.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Get.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Hero(
            tag: Get.arguments.picture,
            child: CarouselWithIndicator(
                productController: _productController, animal: Get.arguments),
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
              title: Text(
                Get.arguments.price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.green,
                ),
              ),
              trailing: SizedBox(
                width: 50,
                child: LikeButton(
                  isLiked: Get.arguments.favorite,
                  onTap: (isLiked) async {
                    _productController.onLikeButtonTap(Get.arguments, !isLiked);
                    return !isLiked;
                  },
                ),
              )),
          Container(
            width: Get.width - 20,
            margin: const EdgeInsets.only(left: 18, right: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ...List.generate(
                  3,
                  (index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _productController.productSpecs[index],
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            index == 0
                                ? Get.arguments.age
                                : index == 1
                                    ? Get.arguments.species
                                    : Get.arguments.gender,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          index == 2
                              ? Get.arguments.gender == "Male"
                                  ? const Icon(
                                      Icons.male,
                                      color: Colors.blue,
                                    )
                                  : const Icon(
                                      Icons.female,
                                      color: Colors.pink,
                                    )
                              : const Center(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "LOCATION",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Get.arguments.location,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  "DETAILS",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  Get.arguments.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SellerCard(),
        ],
      ),
      bottomNavigationBar: _offerButton(_productController),
    );
  }

  Widget _offerButton(ProductController productController) {
    return GestureDetector(
      onTap: () => _productController.onOfferSendTap(Get.arguments, true),
      child: Container(
        height: 60,
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Get.arguments.offered
                ? const Text(
                    "Offer Sent",
                    key: ValueKey<String>("offer"),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Center(),
            const SizedBox(
              width: 10,
            ),
            Obx(
              () => AnimatedSwitcher(
                duration: const Duration(seconds: 1),
                child: _productController.sendingOfferLoader.value
                    ? const Center(
                        key: ValueKey<String>("loader"),
                        child: SizedBox(
                          height: 23,
                          width: 23,
                          child: CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                            strokeWidth: 2.0,
                          ),
                        ),
                      )
                    : Get.arguments.offered
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Colors.white,
                            size: 26,
                            key: ValueKey("sent"),
                          )
                        : const Text(
                            "Make Offer",
                            key: ValueKey<String>("make"),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
