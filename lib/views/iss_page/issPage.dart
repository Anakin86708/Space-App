import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/apiIss/issBloc.dart';
import 'package:space_app/bloc/apiIss/issStates.dart';
import 'package:space_app/model/api/issData.dart';
import 'package:space_app/theme/themeData.dart';

class IssPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('International Space Station'),
      ),
      body: BlocBuilder<IssBloc, IssStates>(
        builder: (context, state) {
          try {
            return post(context, state);
          } catch (e) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget post(context, state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              banner(context, state),
              Container(
                child: Align(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                  ),
                  alignment: Alignment.topRight,
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _generateContentText(context, state),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Text _generateTitle(context, state) {
    return Text(
      state.data[0].name,
      style: AppTheme.postStyle["titleStyle"],
    );
  }

  Column _generateContentText(context, state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _generateTitle(context, state),
        SizedBox(height: 20),
        _generateFounded(context, state),
        _generateOrbit(context, state),
        SizedBox(height: 20),
        _generateDescription(context, state),
      ],
    );
  }

  Widget banner(context, state) {
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Container(
        constraints: BoxConstraints.expand(),
        child: generateImage(context, state),
      ),
    );
  }

  Image generateImage(context, state) {
    return Image.network(
      state.data[0].imageUrl,
      fit: BoxFit.fill,
    );
  }

  Widget _generateDescription(context, state) {
    return Text(
      state.data[0].description,
      style: AppTheme.postStyle["contentStyle"],
      textAlign: AppTheme.postStyle["contentJustify"],
    );
  }

  Widget _generateFounded(context, state) {
    var founded = state.data[0].founded;

    if (founded != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Founded: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Expanded(
            child: Text(
              founded,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }

  Widget _generateOrbit(context, state) {
    var orbit = state.data[0].orbit;

    if (orbit != '') {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Orbit: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Expanded(
            child: Text(
              orbit,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      );
    } else {
      return Text('');
    }
  }
}
