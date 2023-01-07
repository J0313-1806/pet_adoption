import 'dart:developer';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';
import 'package:pet_adoption/source/database/database.dart';
import 'package:pet_adoption/source/model/animal_model.dart';

class ProductController extends GetxController {
  final HomeController _homeController = Get.find();

  RxInt currentPage = RxInt(0);
  void onCarouselPageChange(index, reason) {
    currentPage(index);
  }

  RxMap<String, AnimalModel> wishList = RxMap({});
  void onLikeButtonTap(AnimalModel animal, bool isLiked) async {
    _homeController.animalList.update(animal.name, (value) {
      animal.favorite = isLiked;
      return animal;
    });

    if (isLiked) {
      DataStorage.savePet(animal.name);
    } else {
      wishList.remove(animal.name);
      DataStorage.removeSavedPet(animal.name);
    }
    log("Liked: ${animal.name}");
  }

  void fetchWishList() {
    try {
      if (DataStorage.mapOfPets.isNotEmpty) {
        DataStorage.mapOfPets.forEach((key, value) {
          wishList.putIfAbsent(key.toString(), () {
            return _homeController.animalList[key]!;
          });
        });
      }
    } catch (e) {
      log("couldnt fetch wishlist");
    }
  }

  List<String> productSpecs = ["AGE", "SPECIES", "GENDER"];
  RxBool sendingOfferLoader = RxBool(false);
  RxBool offerSent = RxBool(false);
  RxMap<String, AnimalModel> historyList = RxMap({});
  void onOfferSendTap(AnimalModel animal, bool offer) async {
    try {
      sendingOfferLoader(true);
      if (!animal.offered && offer) {
        _homeController.animalList.update(animal.name, (value) {
          value.offered = offer;
          return value;
        });
        DataStorage.orderPet(animal.name);
        await Future.delayed(const Duration(milliseconds: 1500));
      } else if (!offer) {
        historyList.remove(animal.name);
        DataStorage.removeOrderedPet(animal.name);
      }
    } catch (e) {
      log("on send offer error: $e");
    } finally {
      sendingOfferLoader(false);
    }
  }

  void fetchHistoryList() {
    try {
      if (DataStorage.mapOfOrderedPets.isNotEmpty) {
        DataStorage.mapOfOrderedPets.forEach((key, value) {
          historyList.putIfAbsent(key.toString(), () {
            return _homeController.animalList[key]!;
          });
        });
      }
    } catch (e) {
      log("couldnt fetch history");
    }
  }
}
