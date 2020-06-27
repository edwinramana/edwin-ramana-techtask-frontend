import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/model/recipes.dart';
import 'package:flutter_app/templates/color_loader.dart';
import 'package:flutter_app/templates/widget_error.dart';

class PageRecipes extends StatefulWidget {
  final List<Ingredients> ingredientList;

  const PageRecipes({Key key, this.ingredientList}) : super(key: key);

  @override
  _PageRecipesState createState() => _PageRecipesState();
}

class _PageRecipesState extends State<PageRecipes> {
  List<String> ingredients = new List<String>();
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    for (Ingredients ingredient in widget.ingredientList) {
      ingredients.add(ingredient.title);
    }
    bloc.recipesBloc.getRecipes(ingredients);
  }

  Future _refreshRecipesData() {
    return bloc.ingredientsBloc.getIngredients();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Recipes")),
        body: StreamBuilder<List<Recipes>>(
          stream: bloc.recipesBloc.recipes,
          builder: (context, snapshot) {
            if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
              print(snapshot.error);
              return InkWell(
                  child: WidgetError(),
                  onTap: () {
                    setState(() {
                      _refreshRecipesData();
                    });
                  });
            } else if (snapshot.hasData) {
              return _recipesListView(snapshot.data);
            }
            return Container(
                alignment: Alignment.center,
                child: ColorLoader(
                  dotOneColor: Colors.blue,
                  dotTwoColor: Colors.lightBlue,
                  dotThreeColor: Colors.lightBlueAccent,
                ));
          },
        ));
  }

  Widget _recipesListView(List<Recipes> recipesList) {
    return RefreshIndicator(
        onRefresh: () {
          return _refreshRecipesData();
        },
        child: (recipesList.length == 0)
            ? ListView(
                children: <Widget>[
                  Text(
                    "No data available",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            : ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: recipesList.length,
                controller: _scrollController,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: ListTile(
                          title: Text(recipesList[index].title),
                          subtitle: Text(recipesList[index].ingredients.toString()),
                          onLongPress: () {
                            setState(() {});
                          },
                        ),
                      ),
                      Divider()
                    ],
                  );
                }));
  }
}
