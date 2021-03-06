import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/data/dataEvents.dart';
import 'package:space_app/bloc/data/dataStates.dart';
import 'package:space_app/database/apiDatabase.dart';
import 'package:space_app/database/favoritesDatabase.dart';
import 'package:space_app/database/settingsDatabase.dart';
import 'package:space_app/model/api/eventData.dart';

class DataBloc extends Bloc<DataEvents, DataStates> {
  DataBloc() : super(DataViewState([])) {
    add(RequestListData());
  }

  @override
  Stream<DataStates> mapEventToState(DataEvents event) async* {
    if (event is RequestListData) {
      List<EventData> data = await _getEventsData();
      yield DataViewState(data);
    } else if (event is RequestListFavorite) {
      List<EventData> data = await _getEventsData();
      List<int> favoritesIDs = await FavoriteDatabase.helper.getFavorites();
      List<EventData> favoriteData = []..addAll(
          data.where((element) => favoritesIDs.contains(element.serverID)));

      yield DataViewState(favoriteData);
    }
  }

  Future<List<EventData>> _getEventsData() async {
    List<EventData> data;
    if (await APIProvider.needNewData()) {
      print('Getting data from API');
      data = await APIProvider.helper.getAllEvents();
      SettingsDatabaseLocalServer.helper.setLastUpdateDateNow();
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

  Future<List<EventData>> _getAndSaveDataFromAPI() async {
    List<EventData> data = await APIProvider.helper.getAllEvents();
    data.forEach((element) {
      APIDatabase.helper.insertEvent(element);
    });
    return data;
  }
}
