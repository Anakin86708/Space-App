import 'package:space_app/model/api/eventData.dart';

abstract class InitialStates {}

class DataViewState extends InitialStates {
  final List<EventData> data;

  DataViewState(this.data);

}
