import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/apiAgency/agencyEvents.dart';
import 'package:space_app/bloc/apiAgency/agencyStates.dart';
import 'package:space_app/database/apiDatabase.dart';
import 'package:space_app/model/api/agencyData.dart';

class AgencyBloc extends Bloc<AgencyEvents, AgencyStates> {
  AgencyBloc() : super(DataViewState([]));

  @override
  Stream<AgencyStates> mapEventToState(AgencyEvents event) async* {
    if (event is RequestListData) {
      List<AgencyData> data = await _getAgencyData();
      yield DataViewState(data);
    }
  }

  Future<List<AgencyData>> _getAgencyData() async {
    List<AgencyData> data;

    if (_needNewData()) {
      print('Getting data from API');
      data = await APIProvider.helper.getAllAgencies();
    } else {
      // data from db
      print('Getting data from DB');
      data = await APIDatabase.helper.getAllAgencies();
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

  Future<List<AgencyData>> _getAndSaveDataFromAPI() async {
    List<AgencyData> data = await APIProvider.helper.getAllAgencies();
    data.forEach((element) {
      APIDatabase.helper.insertAgency(element);
    });
    return data;
  }
}
