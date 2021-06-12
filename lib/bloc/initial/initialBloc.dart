import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/initial/initialEvents.dart';
import 'package:space_app/bloc/initial/initialStates.dart';
import 'package:space_app/database/apiDatabase.dart';
import 'package:space_app/model/api/eventData.dart';

class InitialBloc extends Bloc<InitialEvents, InitialStates> {
  InitialBloc() : super(DataViewState([])) {
    add(RequestListData());
  }

  @override
  Stream<InitialStates> mapEventToState(InitialEvents event) async* {
    if (event is RequestListData) {
      List<EventData> data = await _getEventsData();
      yield DataViewState(data);
    }
  }

  Future<List<EventData>> _getEventsData() async {
    List<EventData> data;
    if (_needNewData()) {
      print('Getting data from API');
      data = await APIProvider.helper.getAllEvents();
    } else {
      // Get data from db
      print('Getting data from DB');
      data = await APIDatabase.helper.getAllEvents();
      if (data == null || data.length <= 0) {
        print('Failed... Getting data from API');
        data = await _getAndSaveDataFromAPI();
      }
    }
    return data;
  }

  bool _needNewData() {
    return false; // TODO: implementar o tempo para atualizar dados
  }

  Future<List<EventData>> _getAndSaveDataFromAPI() async {
    List<EventData> data = await APIProvider.helper.getAllEvents();
    data.forEach((element) {
      APIDatabase.helper.insertEvent(element);
    });
    return data;
  }
}
