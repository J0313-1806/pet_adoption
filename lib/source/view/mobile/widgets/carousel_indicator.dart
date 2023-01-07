import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/product_controller.dart';
import 'package:pet_adoption/source/model/animal_model.dart';

class CarouselWithIndicator extends StatelessWidget {
  const CarouselWithIndicator(
      {Key? key, required this.productController, required this.animal})
      : super(key: key);

  final ProductController productController;
  final AnimalModel animal;
  static final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: 3,
          itemBuilder: (context, index, realIndex) {
            return Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(19.0),
                image: DecorationImage(
                  image: AssetImage(animal.picture),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: productController.onCarouselPageChange,
          ),
        ),
        Positioned(
          bottom: 2,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) {
              return GestureDetector(
                onTap: () => _carouselController.animateToPage(index),
                child: Obx(
                  () => AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    key: ValueKey<int>(index),
                    width: productController.currentPage.value == index
                        ? 12.0
                        : 8.0,
                    height: productController.currentPage.value == index
                        ? 12.0
                        : 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
