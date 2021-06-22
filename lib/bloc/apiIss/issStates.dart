import 'package:space_app/model/api/issData.dart';

abstract class IssStates {}

class DataViewState extends IssStates {
  final List<IssData> data;

  DataViewState(this.data);
}
