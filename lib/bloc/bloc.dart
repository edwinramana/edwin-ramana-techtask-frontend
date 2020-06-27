import 'package:flutter_app/bloc/date_bloc.dart';
import 'package:flutter_app/bloc/ingredients_bloc.dart';
import 'package:flutter_app/bloc/recipes_bloc.dart';

class Bloc {

  IngredientsBloc ingredientsBloc = IngredientsBloc();
  DateBloc dateBloc = DateBloc();
  RecipesBloc recipesBloc =  RecipesBloc();

}

final bloc = Bloc();