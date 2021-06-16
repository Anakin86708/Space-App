import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/apiAgency/agencyBloc.dart';
import 'package:space_app/bloc/apiAgency/agencyEvents.dart';
import 'package:space_app/bloc/apiAgency/agencyStates.dart';
import 'package:space_app/views/agency_page/gridCard.dart';

import 'agenciesPage.dart';

class AgenciesGrid extends StatelessWidget {
  static const padding = EdgeInsets.all(8.0);
  
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AgencyBloc>(context).add(RequestListData());
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Agencies",
      )),
      body: BlocBuilder<AgencyBloc, AgencyStates>(builder: (context, state) => Container(
        child: _generateGrid(context, state),
        margin: EdgeInsets.all(8.0),
      ),),
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
            child: new AgencyGridCard.fromAgencyData(state.data[index]),
            onTap: () {
              print("clicou");
              return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AgenciesPage(state.data[index])));
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
