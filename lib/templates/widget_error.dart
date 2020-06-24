import 'package:flutter/material.dart';

class WidgetError extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(constraints: BoxConstraints(maxHeight: 200), child: Icon(
                Icons.error,
                color: Colors.grey,
              )),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "Patience is bitter, but its fruit is sweet.\nTap to retry.",
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
