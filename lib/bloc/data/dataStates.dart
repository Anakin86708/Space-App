import 'package:space_app/model/api/eventData.dart';

abstract class DataStates {}

class DataViewState extends DataStates {
  final List<EventData> data;

  DataViewState(this.data);
}
