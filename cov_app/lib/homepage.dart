import 'dart:convert';

import 'package:cov_app/panels/malaysiapanel.dart';
import 'package:cov_app/panels/mostcasesbystates.dart';
import 'package:cov_app/panels/infopanel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cov_app/datasource.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map malaysiaData;

  fetchMalaysiaData() async {
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/all'));
    setState(() {
      malaysiaData = json.decode(response.body);
    });
  }

  List stateData;

  fetchStateData() async {
    http.Response response = await http.get(Uri.parse('https://corona.lmao.ninja/v3/covid-19/countries'));
    setState(() {
      stateData = json.decode(response.body);
    });
  }

  @override
  void initState(){
    fetchMalaysiaData();
    fetchStateData();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('COVID-19 TRACKER')
      ),
        body: SingleChildScrollView (child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              height: 50,
              color: Colors.orange[100],
              child: Text(DataSource.quote,style: TextStyle(color: Colors.orange[800], fontSize: 16.0, fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Malaysia', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
                  Container(
                      decoration: BoxDecoration(
                        color: primaryBlack,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Text('Regional', style: TextStyle(fontSize: 14.0, color: Colors.white, fontWeight: FontWeight.bold),)),

                ],
              ),
            ),
            malaysiaData==null?CircularProgressIndicator():MalaysiaPanel(malaysiaData: malaysiaData,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Text('Most affected states', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10.0,),
            stateData==null?Container():MostCasesPanel(stateData: stateData,),
            InfoPanel(),
            SizedBox(height: 20.0,),
            Center(child: Text('MR ZHONGLI ONCE SAID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0))),

          ],
        ),
        ),
    );
  }
}
