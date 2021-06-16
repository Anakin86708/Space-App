import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/apiAstronaut/astronautBloc.dart';
import 'package:space_app/bloc/apiAstronaut/astronautEvents.dart';
import 'package:space_app/bloc/apiAstronaut/astronautStates.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/views/astronauts_page/astrounatsPage.dart';
import 'package:space_app/views/astronauts_page/gridCard.dart';

class AstronautsGrid extends StatelessWidget {
  static const padding = EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AstronautBloc>(context).add(RequestListData());
    return Scaffold(
      appBar: AppBar(
        title: Text('Astronauts'),
      ),
      body: BlocBuilder<AstronautBloc, AstronautStates>(
          builder: (context, state) => Container(
                child: _generateGrid(context, state),
                margin: EdgeInsets.all(8.0),
              )),
    );
  }

  Widget _generateGrid(BuildContext context, state) {
    try {
      if (state.data.length <= 0) {
        throw Exception();
      }
      return GridView.builder(
        itemCount: 100,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) => Padding(
          padding: padding,
          child: GestureDetector(
            child: new AstronautGridCard.fromAstronautData(state.data[index]),
            onTap: () {
              print("clicou");
              return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AstronautsPage(state.data[index])));
            },
          ),
        ),
      );
    } on Exception catch (e) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
