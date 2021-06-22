import 'package:space_app/model/api/astronautData.dart';

abstract class AstronautStates {}

class DataViewState extends AstronautStates {
  final List<AstronautData> data;

  DataViewState(this.data);
}
