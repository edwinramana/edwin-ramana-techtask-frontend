import 'dart:convert';

List<Recipes> recipesFromJson(String str) => List<Recipes>.from(json.decode(str).map((x) => Recipes.fromJson(x)));

String recipesToJson(List<Recipes> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Recipes {
  Recipes({
    this.title,
    this.ingredients,
  });

  String title;
  List<String> ingredients;

  factory Recipes.fromJson(Map<String, dynamic> json) => Recipes(
    title: json["title"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
  };
}
