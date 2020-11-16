import 'package:flutter/material.dart';

class Labes extends StatelessWidget {
  final String ruta;
  final String label1;
  final String label2;

  const Labes(
      {Key key,
      @required this.ruta,
      @required this.label1,
      @required this.label2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            label1,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            child: Text(
              label2,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/tag-logo.png')),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
