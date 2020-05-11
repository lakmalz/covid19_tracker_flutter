import 'package:covid19_tracker_flutter/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum EndPoint { cases, casesSuspected, casesConfirmed, deaths, recovered }

abstract class API {
  String get apiKey;
  Uri tokenUri();
  Uri endpointUri(EndPoint endpoint);
}

class NubentosAPI implements API {
  NubentosAPI({@required this.apiKey});
  final String apiKey;

  factory NubentosAPI.sandbox() => NubentosAPI(apiKey: APIKeys.adminSandboxKey);

  static final String host = 'apigw.nubentos.com';
  static final int port = 443;

  static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        port: port,
        path: 'token',
        queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(EndPoint endPoint) => Uri(
      scheme: 'https',
      host: host,
      port: port,
      path: '$basePath/${_paths[endPoint]}');

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'cases/suspected',
    EndPoint.casesConfirmed: 'cases/confirmed',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered'
  };
}

class AdminAPI implements API {
  AdminAPI({@required this.apiKey});
  final String apiKey;

  factory AdminAPI.sandbox() => AdminAPI(apiKey: APIKeys.adminSandboxKey);

  static final String host = 'ncov2019-admin.firebaseapp.com';

  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        path: 'token',
      );

  Uri endpointUri(EndPoint endpoint) => Uri(
        scheme: 'https',
        host: host,
        path: '${_paths[endpoint]}',
      );

  static Map<EndPoint, String> _paths = {
    EndPoint.cases: 'cases',
    EndPoint.casesSuspected: 'casesSuspected',
    EndPoint.casesConfirmed: 'casesConfirmed',
    EndPoint.deaths: 'deaths',
    EndPoint.recovered: 'recovered',
  };
}
