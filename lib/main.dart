
import 'package:covid19_tracker_flutter/app/repositories/data_repository.dart';
import 'package:covid19_tracker_flutter/app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/services/api.dart';
import 'app/ui/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
        apiService: APIService(NubentosAPI.sandbox()),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}

