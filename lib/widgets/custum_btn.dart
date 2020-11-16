import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final Function onPress;
  final String label;

  const CustomButtom({@required this.onPress, @required this.label});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.blue,
        shape: StadiumBorder(),
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ),
        ),
        onPressed: onPress);
  }
}
