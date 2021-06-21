import 'package:bloc/bloc.dart';
import 'package:space_app/api/apiProvider.dart';
import 'package:space_app/bloc/apiIss/issEvents.dart';
import 'package:space_app/bloc/apiIss/issStates.dart';
import 'package:space_app/model/api/issData.dart';

class IssBloc extends Bloc<IssEvents, IssStates> {
  IssBloc() : super(DataViewState([])) {
    add(RequestListData());
  }

  @override
  Stream<IssStates> mapEventToState(IssEvents event) async* {
    if (event is RequestListData) {
      List<IssData> data = await APIProvider.helper.getIss();
      yield DataViewState(data);
    }
  }
}
