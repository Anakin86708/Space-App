import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/bloc/initial/initialBloc.dart';
import 'package:space_app/bloc/initial/initialEvents.dart';
import 'package:space_app/bloc/initial/initialStates.dart';
import 'package:space_app/model/postData.dart';
import 'package:space_app/views/interfacePage.dart';
import 'package:space_app/views/initial_page/postCard.dart';

class InitialPage extends StatefulWidget implements InterfacePage {
  final Icon _pageIcon = Icon(Icons.article);
  final String _pageName = 'News';

  @override
  _InitialPageState createState() => _InitialPageState();

  @override
  Icon get pageIcon => _pageIcon;

  @override
  String get pageName => _pageName;
}

class _InitialPageState extends State<InitialPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<InitialBloc>(context).add(RequestListData());
    return BlocBuilder<InitialBloc, InitialStates>(
        builder: (context, state) => _build(context, state));
  }
}

_build(BuildContext context, state) {
  const padding = 16.0;
  return Container(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(padding, 0, padding, 0),
      child: genereteList(context, state),
    ),
  );
}

Widget genereteList(context, state) {
  try {
    if (state.data.length <= 0) {
      throw RangeError('');
    }
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) => new PostCard(
        data: PostData.fromEventData(state.data[index]),
      ),
    );
  } on RangeError catch (e) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
