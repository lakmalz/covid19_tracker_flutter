import 'package:covid19_tracker_flutter/app/services/api.dart';
import 'package:covid19_tracker_flutter/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class DataRepository {
  DataRepository({@required this.apiService});
  final APIService apiService;

  String _accessToken;

  Future<int> getEndpointData(EndPoint endPoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }

      return await apiService.getEndpointData(
          accessToken: _accessToken, endPoint: endPoint);
    } on Response catch (response) {
      // token expired
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();

        return await apiService.getEndpointData(
            accessToken: _accessToken, endPoint: endPoint);
      }
      rethrow;
    }
  }
}
