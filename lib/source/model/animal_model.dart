class AnimalModel {
  AnimalModel({
    required this.picture,
    required this.name,
    required this.age,
    required this.species,
    required this.description,
    required this.price,
    required this.gender,
    required this.location,
    required this.favorite,
    required this.offered,
  });
  final String picture;
  final String name;
  final String age;
  final String species;
  final String description;
  final String price;
  final String gender;
  final String location;
  bool favorite;
  bool offered;
}
