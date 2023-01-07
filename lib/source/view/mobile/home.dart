import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';
import 'package:pet_adoption/source/view/mobile/widgets/category_bar.dart';
import 'package:pet_adoption/source/view/mobile/widgets/custom_search.dart';
import 'widgets/pet_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(
      builder: (homeController) {
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(
              Icons.pets_rounded,
              color: Colors.blue,
            ),
            title: Text(
              "Pet Adoption",
              style: TextStyle(
                  color:
                      homeController.dark.value ? Colors.white : Colors.black),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                },
                icon: const Icon(
                  Icons.search,
                  color: Colors.blue,
                ),
              ),
              IconButton(
                onPressed: homeController.onDarkMode,
                icon: AnimatedSwitcher(
                  duration: const Duration(
                    milliseconds: 150,
                  ),
                  child: homeController.dark.value
                      ? Icon(
                          Icons.dark_mode,
                          color: Colors.yellow.shade800,
                          key: const ValueKey<String>("dark"),
                        )
                      : Icon(
                          Icons.light_mode,
                          color: Colors.yellow.shade800,
                          key: const ValueKey<String>("light"),
                        ),
                  transitionBuilder: (child, animation) => RotationTransition(
                    turns: animation,
                    child: child,
                  ),
                ),
              ),
            ],
            bottom: const PreferredSize(
              child: CategoryBar(),
              preferredSize: Size.fromHeight(50),
            ),
            elevation: 0,
            backgroundColor:
                homeController.dark.value ? Colors.transparent : Colors.white,
          ),
          body: ListView(
            shrinkWrap: true,
            primary: false,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, bottom: 10),
                child: Text(
                  "Pets",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              PetView(animals: homeController.animalList, page: 0),
            ],
          ),
        );
      },
    );
  }
}
