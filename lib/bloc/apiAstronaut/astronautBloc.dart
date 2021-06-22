import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/apiAstronaut/astronautEvents.dart';
import 'package:space_app/bloc/apiAstronaut/astronautStates.dart';
import 'package:space_app/database/apiDatabase.dart';
import 'package:space_app/model/api/astronautData.dart';

class AstronautBloc extends Bloc<AstronautEvents, AstronautStates> {
  AstronautBloc() : super(DataViewState([]));

  @override
  Stream<AstronautStates> mapEventToState(AstronautEvents event) async* {
    if (event is RequestListData) {
      List<AstronautData> data = await _getAstronautsData();
      yield DataViewState(data);
    }
  }

  Future<List<AstronautData>> _getAstronautsData() async {
    List<AstronautData> data;
    if (await APIProvider.needNewData()) {
      print('Getting data from API');
      data = await APIProvider.helper.getAllAstronauts();
    } else {
      print('Getting data from DB');
      data = await APIDatabase.helper.getAllAstronauts();
      if (data == null || data.length <= 0) {
        print('Failed... Getting data from API');
        data = await _getAndSaveDataFromAPI();
      }
    }
    return data;
  }

  Future<List<AstronautData>> _getAndSaveDataFromAPI() async {
    List<AstronautData> data = await APIProvider.helper.getAllAstronauts();
    data.forEach((element) {
      APIDatabase.helper.insertAstronaut(element);
    });
    return data;
  }
}
