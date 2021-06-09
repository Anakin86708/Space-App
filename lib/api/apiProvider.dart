import 'package:dio/dio.dart';
import 'package:space_app/model/api/eventData.dart';

class APIProvider {
  static APIProvider helper = APIProvider._createInstance();
  APIProvider._createInstance();
  Dio _dio = Dio();

  static const String _apiURL = 'https://lldev.thespacedevs.com/2.2.0/'; // DEVELOPER API
  static const String _eventsEndpoint = 'event/';

  Future<List<EventData>> getAllEvents() async {
    List<EventData> list = [];

    String requestUrl = _apiURL + _eventsEndpoint;
    Response response;
    // do {
    try {
      response = await _dio.request(
        requestUrl + '?limit=100',
        options: Options(
          method: 'GET',
          headers: {"Accept": "application/json"},
        ),
      );
    } on Exception catch (e) {
      print('Error while getting API data\n' + e.toString());
      return [];
    }

    List results = response.data['results'];

    results.forEach((element) {
      list.add(EventData.fromMapAPI(element));
    });
    requestUrl = response.data['next'];
    // } while (_hasNext(response));

    return list;
  }

  bool _hasNext(Response response) {
    return response.data['next'] != null;
  }
}
