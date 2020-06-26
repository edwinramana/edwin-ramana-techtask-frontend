import 'package:flutter/material.dart';
import 'package:flutter_app/model/ingredients.dart';

class PageRecipes extends StatefulWidget{
  final List <Ingredients> ingredientList;

  const PageRecipes({Key key, this.ingredientList}) : super(key: key);
  @override
  _PageRecipesState createState() => _PageRecipesState();
}

class _PageRecipesState extends State<PageRecipes> {
  String ingredients="";

  @override
  void initState() {
      super.initState();
      for(Ingredients ingredient in widget.ingredientList){
        ingredients += ingredient.title.toString()+", ";
      }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text(ingredients)),
    );
  }


}