import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/database/database.dart';
import 'package:pet_adoption/source/model/animal_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  void onInit() {
    super.onInit();
    onDarkMode(initialize: true);
  }

  @override
  void onReady() {
    super.onReady();
    addingAnimalsToMap(initialize: true);
  }

  RxBool dark = RxBool(DataStorage.getSaveMode ?? false);
  void onDarkMode({bool initialize = false}) {
    !initialize ? dark.toggle() : null;
    Get.changeThemeMode(dark.value ? ThemeMode.dark : ThemeMode.light);
    log("get theme mode: ${Get.isDarkMode}");
    DataStorage.saveMode(dark.value);
  }

  void addingAnimalsToMap({bool initialize = false}) {
    animalList.clear();
    if (initialize) {
      for (var animal in animalListAll) {
        String isFav = DataStorage.savedPet(animal.name) ?? "null";
        String isOrdered = DataStorage.orderedPet(animal.name) ?? "null";
        animalList.addAll({animal.name: animal});
        animalList.update(animal.name, (value) {
          value.favorite = isFav == animal.name ? true : false;
          value.offered = isOrdered == animal.name ? true : false;
          return value;
        });
      }
    } else {
      for (var animal in animalListAll) {
        animalList.addAll({animal.name: animal});
      }
    }
  }

  void chipsOnTap(int index) {
    selectedSpecies(index);
    addingAnimalsToMap();
    animalList
        .removeWhere((key, value) => !value.species.contains(category[index]));
  }

  void chipsOnClose() {
    selectedSpecies(-1);
    addingAnimalsToMap();
  }

  void deleteBox() async {
    await DataStorage.userBox().clear();
  }

  RxList<String> category = RxList([
    "Bird",
    "Cat",
    "Dog",
    "Guinea Pig",
    "Rabbit",
    "Turtle",
  ]);
  RxInt selectedSpecies = RxInt(-1);
  RxMap<String, AnimalModel> animalList = RxMap({});
  RxList<AnimalModel> animalListAll = RxList([
    AnimalModel(
      picture: "assets/dog1.jpg",
      name: "Tiger",
      age: "10",
      species: "Dog",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$100",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/dog2.jpg",
      name: "Bob",
      age: "6",
      species: "Dog",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$120",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/dog3.jpg",
      name: "Rocky",
      age: "3",
      species: "Dog",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$70",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/cat1.jpg",
      name: "Hannah",
      age: "8",
      species: "Cat",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$80",
      gender: "Female",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/bird3.jpg",
      name: "Blue",
      age: "2",
      species: "Bird",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$110",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/dog4.jpg",
      name: "Lion",
      age: "13",
      species: "Dog",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$90",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/bird2.jpg",
      name: "Red",
      age: "1",
      species: "Bird",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$50",
      gender: "Female",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/dog5.jpg",
      name: "Edgar",
      age: "10",
      species: "Dog",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$60",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/cat2.jpg",
      name: "Maya",
      age: "5",
      species: "Cat",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$150",
      gender: "Female",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/cat3.jpg",
      name: "Rachel",
      age: "12",
      species: "Cat",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$40",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/pig.jpg",
      name: "Estawan",
      age: "9",
      species: "Guinea Pig",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$30",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/bird1.jpg",
      name: "Black",
      age: "6",
      species: "Bird",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$50",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/turtle.jpg",
      name: "Rack",
      age: "15",
      species: "Turtle",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$65",
      gender: "Male",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/rabbit1.jpg",
      name: "Ode",
      age: "10",
      species: "Rabbit",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$85",
      gender: "Female",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
    AnimalModel(
      picture: "assets/rabbit2.jpg",
      name: "Joy",
      age: "10",
      species: "Rabbit",
      description: "Very well trained, healthy and already vaccinated",
      price: "\$105",
      gender: "Female",
      favorite: false,
      offered: false,
      location: "Mumbai",
    ),
  ]);
}
