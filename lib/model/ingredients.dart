import 'dart:convert';

List<Ingredients> ingredientsFromJson(String str) => List<Ingredients>.from(json.decode(str).map((x) => Ingredients.fromJson(x)));

String ingredientsToJson(List<Ingredients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ingredients {
  Ingredients({
    this.title,
    this.useBy,
  });

  String title;
  DateTime useBy;

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
    title: json["title"],
    useBy: DateTime.parse(json["use-by"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "use-by": "${useBy.year.toString().padLeft(4, '0')}-${useBy.month.toString().padLeft(2, '0')}-${useBy.day.toString().padLeft(2, '0')}",
  };
}