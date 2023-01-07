import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

Future<void> initStorage() async {
  try {
    await Hive.initFlutter();
    await Hive.openBox("userBox");
    await Hive.openBox("history");
  } catch (e) {
    log("storage initialization error: $e");
  }
}

class DataStorage {
  static Box<dynamic> userBox() => Hive.box("userBox");
  static Box<dynamic> historyBox() => Hive.box("history");

  static bool? get getSaveMode => userBox().get("mode");
  static saveMode(bool mode) => userBox().put("mode", mode);

  static String? savedPet(String pet) => userBox().get(pet);
  static savePet(String pet) => userBox().put(pet, pet);

  static removeSavedPet(String pet) => userBox().delete(pet);

  static Map<dynamic, dynamic> get mapOfPets => userBox().toMap();

  static String? orderedPet(String pet) => historyBox().get(pet);
  static orderPet(String pet) => historyBox().put(pet, pet);

  static removeOrderedPet(String pet) => historyBox().delete(pet);

  static Map<dynamic, dynamic> get mapOfOrderedPets => historyBox().toMap();
}
