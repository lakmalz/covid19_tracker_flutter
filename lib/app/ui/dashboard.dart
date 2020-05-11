import 'package:covid19_tracker_flutter/app/services/api.dart';
import 'package:covid19_tracker_flutter/app/repositories/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'endpoint_card.dart';

class Dashboard extends StatefulWidget{

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>{
  int _cases;

  @override
  void initState(){
    super.initState();
    _updateData();
  }

  Future<void> _updateData() async{
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(EndPoint.cases);
    setState(() => _cases = cases);
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Coronavirus'),
     ),
     body: ListView(
       children: <Widget>[
          EndpointCard(
            endpoint: EndPoint.cases,
            value: _cases,
          ),
       ],
     ),
   );
  }
 
}