import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/initial/initialEvents.dart';
import 'package:space_app/bloc/initial/initialStates.dart';
import 'package:space_app/model/api/eventData.dart';

class InitialBloc extends Bloc<InitialEvents, InitialStates> {
  InitialBloc() : super(DataViewState([])) {
    add(RequestListData());
  }

  @override
  Stream<InitialStates> mapEventToState(InitialEvents event) async* {
    if (event is RequestListData) {
      List<EventData> data = await APIProvider.helper.getAllEvents();
      yield DataViewState(data);
    }
  }
}
