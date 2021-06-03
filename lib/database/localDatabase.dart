import 'dart:async';

import 'package:dio/dio.dart';
import 'package:space_app/model/settingsData.dart';

class DatabaseLocalServer {
  /* 
    Criando singleton
  */
  static DatabaseLocalServer helper = DatabaseLocalServer._createInstance();
  DatabaseLocalServer._createInstance();

  String databaseUrl = "http://192.168.15.26:5000/data";

  Dio _dio = Dio();

  String _colEventNotificationState = 'eventNotificationsState';
  String _colOnlyFavoriteState = 'onlyFavoriteState';
  String _colUpdateFrequencyState = 'updateFrequencyValue';
  int _id = 1;

  Future<SettingsData> getSettingsData() async {
    Response response = await _dio.request(this.databaseUrl,
        options: Options(method: "GET", headers: {
          "Accept": "application/json",
        }));

    SettingsData data = new SettingsData();
    data.eventNotificationsState =
        response.data['1'][_colEventNotificationState];
    data.onlyFavoriteState = response.data['1'][_colOnlyFavoriteState];
    data.updateFrequencyValue = response.data['1'][_colUpdateFrequencyState];

    return data;
  }

  Future<int> updateNote(SettingsData data) async {
    _dio.put(databaseUrl + '/$_id',
        data: data.toMap(),
        options: Options(method: "PUT", headers: {
          "Accept": "application/json",
        }));
    print('Atualizado DB');
    notify();
    return 1;
  }

  notify() async {
    if (_controller != null) {
      var response = await getSettingsData();
      print(response);
      _controller.sink.add(response);
    }
  }

  Stream get stream {
    if (_controller == null) {
      _controller = StreamController();
    }
    return _controller.stream.asBroadcastStream();
  }

  dispose() {
    if (!_controller.hasListener) {
      _controller.close();
      _controller = null;
    }
  }

  static StreamController _controller;
}
