import 'package:dio/dio.dart';
import 'package:space_app/database/settingsDatabase.dart';
import 'package:space_app/model/api/agencyData.dart';
import 'package:space_app/model/api/astronautData.dart';
import 'package:space_app/model/api/eventData.dart';
import 'package:space_app/model/settingsData.dart';
import 'package:space_app/model/api/issData.dart';

class APIProvider {
  static APIProvider helper = APIProvider._createInstance();
  APIProvider._createInstance();
  Dio _dio = Dio();

  static const String _apiURL =
      'https://lldev.thespacedevs.com/2.2.0/'; // DEVELOPER API
  static const String _eventsEndpoint = 'event/';
  static const String _astronautsEndpoint = 'astronaut/';
  static const String _agenciesEndpoint = 'agencies/';
  static const String _issEndpoint =
      'spacestation/?name=International Space Station';

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

  Future<List<AgencyData>> getAllAgencies() async {
    List<AgencyData> list = [];

    String requestUrl = _apiURL + _agenciesEndpoint;
    Response response;
    try {
      response = await _dio.request(requestUrl + '?limit=100',
          options:
              Options(method: 'GET', headers: {"Accept": "application/json"}));
    } on Exception catch (e) {
      print('Error while getting API data\n' + e.toString());
      return [];
    }

    List results = response.data['results'];

    results.forEach((element) {
      list.add(AgencyData.fromMapAPI(element));
    });
    requestUrl = response.data['next'];

    return list;
  }

  static Future<bool> needNewData() async {    
    DateTime now = DateTime.now();
    print('Now: $now');
    String updateInterval =
        await SettingsDatabaseLocalServer.helper.getUpdateFrequency();
    SettingsDatabaseLocalServer.helper
        .getSettingsData()
        .then((value) => updateInterval = value.updateFrequencyValue);
    DateTime lastUpdateDate =
        await SettingsDatabaseLocalServer.helper.getLastUpdateDate();
    print('Last update: $lastUpdateDate');

    double intervalInHours = _getUpdateIntervalFromSettings(updateInterval);
    var diference = now.difference(lastUpdateDate);

    print('Diference: $diference');
    print('Result: ${diference.inDays > intervalInHours}');
    return diference.inDays > intervalInHours;
  }

  static double _getUpdateIntervalFromSettings(String updateInterval) {
    if (updateInterval == SettingsData.availableUpdatesFrequency[0]) {
      return 0.5;
    } else if (updateInterval == SettingsData.availableUpdatesFrequency[1]) {
      return 1;
    } else if (updateInterval == SettingsData.availableUpdatesFrequency[2]) {
      return 2;
    } else if (updateInterval == SettingsData.availableUpdatesFrequency[3]) {
      return 6;
    } else if (updateInterval == SettingsData.availableUpdatesFrequency[4]) {
      return 12;
    } else if (updateInterval == SettingsData.availableUpdatesFrequency[5]) {
      return 24;
    }
    return 0;
  }

  Future<List<IssData>> getIss() async {
    List<IssData> list = [];

    String requestUrl = _apiURL + _issEndpoint;
    Response response;
    try {
      response = await _dio.request(requestUrl,
          options:
              Options(method: 'GET', headers: {"Accept": "application/json"}));
    } on Exception catch (e) {
      print('Error while getting API data\n' + e.toString());
      return [];
    }

    List results = response.data['results'];

    results.forEach((element) {
      list.add(IssData.fromMapAPI(element));
    });
    requestUrl = response.data['next'];

    return list;
  }
}
