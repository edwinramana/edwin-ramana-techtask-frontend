import 'package:flutter/material.dart';
import 'package:flutter_app/bloc/bloc.dart';
import 'package:flutter_app/model/ingredients.dart';
import 'package:flutter_app/templates/color_loader.dart';
import 'package:flutter_app/templates/widget_error.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    bloc.dateBloc.setDate(now);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Front End Technical Test"),
      ),
      body: StreamBuilder(
        stream: bloc.dateBloc.date,
          builder: (context, snapshot) {
          DateTime date = snapshot.data??DateTime.now();
        return Column(
          children: <Widget>[
            Expanded(flex: 1, child: DatePicker(selectedDate: date,)),
            Expanded(flex: 8, child: IngredientList(selectedDate: date,)),
          ],
        );
      }),
    );
  }


}

class DatePicker extends StatefulWidget {
  final DateTime selectedDate;

  const DatePicker({Key key, this.selectedDate}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        callDatePicker();
      },
      child: Container(
        alignment: Alignment.center,
        child: Text(
          DateFormat('yMd').format(widget.selectedDate),
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  void callDatePicker() async {
    var date = await getDate();
    setState(() {
      bloc.dateBloc.setDate(date);
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }
}

class IngredientList extends StatefulWidget {
  final selectedDate;

  const IngredientList({Key key, this.selectedDate}) : super(key: key);

  @override
  _IngredientListState createState() => _IngredientListState();
}

class _IngredientListState extends State<IngredientList> with WidgetsBindingObserver {
  List<Ingredients> ingredients;
  List<Ingredients> selectedIngredients;
  ScrollController _scrollController = new ScrollController();
  var selectedDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshIngredientsData();
  }

  Future _refreshIngredientsData() {
    return bloc.ingredientsBloc.getIngredients();
  }

  void callDatePicker() async {
    var date = await getDate();
    setState(() {
      selectedDate = date;
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<List<Ingredients>>(
      stream: bloc.ingredientsBloc.ingredients,
      builder: (context, snapshot) {
        if (snapshot.hasError || snapshot.connectionState == ConnectionState.done) {
          print(snapshot.error);
          return InkWell(
              child: WidgetError(),
              onTap: () {
                setState(() {
                  _refreshIngredientsData();
                });
              });
        } else if (snapshot.hasData) {
          return RefreshIndicator(
              onRefresh: () {
                return _refreshIngredientsData();
              },
              child: (snapshot.data.length == 0)
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
                      itemCount: snapshot.data.length,
                      controller: _scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        ingredients = snapshot.data;
                        return Column(
                          children: <Widget>[
                            ListTile(
                              title: Text(ingredients[index].title),
                              subtitle: Text(ingredients[index].useBy.toString()),
                              onLongPress: () {
                                setState(() {
                                  if (selectedIngredients.contains(ingredients[index])) {
                                    Fluttertoast.showToast(
                                        msg: ingredients[index].title + " has already been added",
                                        toastLength: Toast.LENGTH_SHORT,
                                        fontSize: 16.0);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Adding " + ingredients[index].title + " " + widget.selectedDate.toString(),
                                        toastLength: Toast.LENGTH_SHORT,
                                        fontSize: 16.0);
                                    selectedIngredients.add(ingredients[index]);
                                  }
                                });
                              },
                            ),
                            Divider()
                          ],
                        );
                      }));
        }
        return Container(
            alignment: Alignment.center,
            child: ColorLoader(
              dotOneColor: Colors.blue,
              dotTwoColor: Colors.lightBlue,
              dotThreeColor: Colors.lightBlueAccent,
            ));
      },
    );
  }
}
