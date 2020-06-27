import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/model/recipes.dart';
import 'package:flutter_app/service/repository.dart';
import 'package:rxdart/rxdart.dart';

class RecipesBloc {
  final _repository = Repository();
  final _recipesFetcher = PublishSubject<List<Recipes>>();
  Stream<List<Recipes>> get recipes => _recipesFetcher.stream;


  getRecipes(List<String> ingredients) async {
    bool isError = false;
    String error;
    List<Recipes> recipes =
    await _repository.getRecipes(ingredients).timeout(const Duration(seconds: 60)).catchError((e) {
      isError = true;
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
    });
    if (isError) {

      _recipesFetcher.sink.addError(error);
    } else {
      _recipesFetcher.sink.add(recipes);
    }
  }



  disposeNetwork() {
    _recipesFetcher.close();
  }
}