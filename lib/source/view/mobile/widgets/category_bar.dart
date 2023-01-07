import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: GetX<HomeController>(builder: (homeController) {
        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 5.0),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: homeController.category.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(
                right: index == homeController.category.length - 1 ? 0.0 : 8.0),
            child: Obx(
              () => Stack(
                children: [
                  OutlinedButton(
                    onPressed: () => homeController.chipsOnTap(index),
                    child: Text(
                      homeController.category[index],
                      style: TextStyle(
                          color: homeController.selectedSpecies.value == index
                              ? Colors.white
                              : null),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor:
                          homeController.selectedSpecies.value == index
                              ? Colors.blue
                              : Colors.transparent,
                      side: const BorderSide(
                        color: Colors.blue,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      shape: const StadiumBorder(),
                      shadowColor: homeController.dark.value
                          ? Colors.grey.shade600
                          : Colors.black,
                      elevation: homeController.selectedSpecies.value == index
                          ? 6.5
                          : 0.0,
                    ),
                  ),
                  homeController.selectedSpecies.value == index
                      ? Positioned(
                          top: -16,
                          right: -16,
                          child: IconButton(
                            onPressed: homeController.chipsOnClose,
                            icon: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      : const Center(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
