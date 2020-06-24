import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter_app/model/ingredients.dart';

class APIRequest {
  String url = "https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev";

  Future<List<Ingredients>> getIngredients() async {


    final response = await http.get(url+'/ingredients');

    if (response.statusCode == 200) {
      print("getIngredients statusCode:200");
      // If server returns an OK response, parse the JSON
      List responseJson = json.decode(response.body);
      print(response.body);
      List<Ingredients> post = responseJson.map((m) => new Ingredients.fromJson(m)).toList();
      return post;
    } else {
      print("failed to getIngredients " + response.statusCode.toString());
      throw Exception(response.statusCode.toString());
    }
  }
}