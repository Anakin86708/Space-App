import 'package:flutter/material.dart';
import 'package:space_app/views/astronauts_page/gridCard.dart';

class AstronautsPage extends StatelessWidget {
  static const padding = EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Astronautas'),
      ),
      body: Container(child: _generateGrid(), margin: EdgeInsets.all(8.0),),
    );
  }

  Widget _generateGrid() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) => Padding(
          padding: padding,
          child: new GridCard(),
        ),);
  }
}
