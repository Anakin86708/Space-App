import 'package:space_app/model/api/agencyData.dart';

abstract class AgencyStates {}

class DataViewState extends AgencyStates {
  final List<AgencyData> data;

  DataViewState(this.data);
}
