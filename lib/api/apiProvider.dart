import 'package:dio/dio.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/model/api/eventData.dart';

class APIProvider {
  static APIProvider helper = APIProvider._createInstance();
  APIProvider._createInstance();
  Dio _dio = Dio();

  static const String _apiURL =
      'https://lldev.thespacedevs.com/2.2.0/'; // DEVELOPER API
  static const String _eventsEndpoint = 'event/';
  static const String _astronautsEndpoint = 'astronaut/';

  Future<List<EventData>> getAllEvents() async {
    List<EventData> list = [];

    String requestUrl = _apiURL + _eventsEndpoint;
    Response response;
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

    return list;
  }

  Future<List<AstronautData>> getAllAstronauts() async {
    List<AstronautData> list = [];

    String requestUrl = _apiURL + _astronautsEndpoint;
    Response response;
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
      list.add(AstronautData.fromMapAPI(element));
    });
    requestUrl = response.data['next'];

    return list;
  }
}
