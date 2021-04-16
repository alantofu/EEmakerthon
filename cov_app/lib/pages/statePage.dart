import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  List stateData;

  fetchStateData() async {
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries'));
    setState(() {
      stateData = json.decode(response.body);
    });
  }

  @override

  void initState(){
    fetchStateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('State Stats'),),

        body: stateData==null?Center(child: CircularProgressIndicator(),):ListView.builder(itemBuilder: (context, index){
          return Container(
            height: 130,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(color: Colors.white, 
                boxShadow: BoxShadow(color: Colors.grey[100],
                  blurRadius: 10,
                  offset: Offset(0,10),),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(stateData[index]['country'], style: TextStyle(fontWeight: FontWeight.bold),),
                      Image.network(stateData[index]['countryInfo']['flag'],
                      height: 50.0,
                      width: 60.0,),
                    ],
                  ),
                ),
                Expanded(child: Container())
              ],
            ),
          );
    },
      itemCount: stateData==null?0:stateData.length,

    ),
   );
 }
}
