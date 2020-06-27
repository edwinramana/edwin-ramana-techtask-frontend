import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_app/model/recipes.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_app/model/ingredients.dart';

class APIRequest {
  String url = "lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com";

  Future<List<Ingredients>> getIngredients() async {

    var uri = Uri(
      scheme: 'https',
      host: url,
      path: '/dev/ingredients/',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<Ingredients> post = responseJson.map((m) => new Ingredients.fromJson(m)).toList();
      return post;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }

  Future<List<Recipes>> getRecipes(List<String> recipes) async {

    var uri = Uri(
      scheme: 'https',
      host: url,
      path: '/dev/recipes/',
      queryParameters: {
        'ingredients':recipes,
      },
    );
    
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List responseJson = json.decode(response.body);
      List<Recipes> post = responseJson.map((m) => new Recipes.fromJson(m)).toList();
      return post;
    } else {
      throw Exception(response.statusCode.toString());
    }
  }
}