import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/service/api_requests.dart';

class Repository{
  final apiRequest =  APIRequest();

  Future<List<Ingredients>> getIngredients() =>
      apiRequest.getIngredients();
}