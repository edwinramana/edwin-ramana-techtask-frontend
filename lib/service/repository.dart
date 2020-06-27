import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/model/recipes.dart';
import 'package:flutter_app/service/api_requests.dart';

class Repository{
  final apiRequest =  APIRequest();

  Future<List<Ingredients>> getIngredients() =>
      apiRequest.getIngredients();
  Future<List<Recipes>> getRecipes(List<String> ingredients) =>
      apiRequest.getRecipes(ingredients);
}