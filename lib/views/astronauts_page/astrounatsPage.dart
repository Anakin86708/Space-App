import 'package:flutter/material.dart';
import 'package:space_app/model/api/astronautData.dart';

class AstronautsPage extends StatelessWidget {
  const AstronautsPage(this.data) : super();

  final AstronautData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: Text("Teste"),
    );
  }
}
