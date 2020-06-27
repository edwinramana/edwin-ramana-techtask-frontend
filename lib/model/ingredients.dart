import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

List<Ingredients> ingredientsFromJson(String str) => List<Ingredients>.from(json.decode(str).map((x) => Ingredients.fromJson(x)));

String ingredientsToJson(List<Ingredients> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Ingredients {
  Ingredients({
    this.title,
    this.useBy,
    this.isSelected
  });

  String title;
  DateTime useBy;
  bool isSelected;

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
    title: json["title"],
    useBy: DateTime.parse(json["use-by"]),
    isSelected: false
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "use-by": "${useBy.year.toString().padLeft(4, '0')}-${useBy.month.toString().padLeft(2, '0')}-${useBy.day.toString().padLeft(2, '0')}",
  };
}