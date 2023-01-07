import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_adoption/source/controller/home_controller.dart';
import 'package:pet_adoption/source/model/animal_model.dart';
import 'package:pet_adoption/source/view/mobile/product.dart';

class CustomSearchDelegate extends SearchDelegate {
  final HomeController _homeController = Get.find();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<AnimalModel> matchQuery = [];
    for (var animal in _homeController.animalList.values) {
      if (animal.species.toLowerCase().contains(query.toLowerCase()) ||
          animal.name.toLowerCase().contains(query.toLowerCase()) ||
          animal.age.toLowerCase().contains(query.toLowerCase()) ||
          animal.gender.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(animal);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                result.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: Text(result.gender),
          title: Text(result.name),
          subtitle: Text(result.description),
          onTap: () => Get.to(
            () => const ProductScreen(),
            arguments: _homeController.animalList[result.name],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<AnimalModel> matchQuery = [];
    for (var animal in _homeController.animalList.values) {
      if (animal.species.toLowerCase().contains(query.toLowerCase()) ||
          animal.name.toLowerCase().contains(query.toLowerCase()) ||
          animal.age.toLowerCase().contains(query.toLowerCase()) ||
          animal.gender.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(animal);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          leading: CircleAvatar(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                result.picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
          trailing: Text(result.gender),
          title: Text(result.name),
          subtitle: Text(result.description),
          onTap: () => Get.to(
            () => const ProductScreen(),
            arguments: _homeController.animalList[result.name],
          ),
        );
      },
    );
  }
}
