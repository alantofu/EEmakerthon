import 'package:cov_app/panels/malaysiapanel.dart';
import 'package:flutter/material.dart';
import 'package:cov_app/datasource.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map malaysiaData;
  fetchMalysiaData() async {
    http.Response response = await http.get('https://corona.lmao.ninja/v3/covid-19/all');
    setState(() {
      malaysiaData = json.decode(response.body);
    });
  }

  @override
  void initState(){
    fetchMalysiaData();
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
              child: Text('Malaysia', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),
            ),
            malaysiaData==null?CircularProgressIndicator():MalaysiaPanel(malaysiaData: malaysiaData,),

          ],
        ),
        ),
    );
  }
}
