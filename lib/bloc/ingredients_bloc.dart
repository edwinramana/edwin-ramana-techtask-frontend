import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/service/repository.dart';
import 'package:rxdart/rxdart.dart';

class IngredientsBloc {
  final _repository = Repository();
  final _ingredientsFetcher = PublishSubject<List<Ingredients>>();
  final _selectedIngredientsFetcher = PublishSubject<List<Ingredients>>();
  Stream<List<Ingredients>> get ingredients => _ingredientsFetcher.stream;
  Stream<List<Ingredients>> get selectedIngredients => _selectedIngredientsFetcher.stream;



  getIngredients() async {
    bool isError = false;
    String error;
    List<Ingredients> ingredients =
    await _repository.getIngredients().timeout(const Duration(seconds: 60)).catchError((e) {
      isError = true;
      error = e.toString();
      if (e.toString().toLowerCase().contains("timeout")) {
        error = "timeout";
      }
    });
    if (isError) {

      _ingredientsFetcher.sink.addError(error);
    } else {
      _ingredientsFetcher.sink.add(ingredients);
    }
  }

  setSelectedIngredients(List<Ingredients> ingredients){
    _selectedIngredientsFetcher.sink.add(ingredients);
  }

  disposeNetwork() {
    _ingredientsFetcher.close();
    _selectedIngredientsFetcher.close();
  }
}