import 'package:flutter/material.dart';

class MostCasesPanel extends StatelessWidget {

  final List stateData;
  const MostCasesPanel({Key key, this.stateData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0, vertical:10.0),
          child: Row(
            children: <Widget>[
              Image.network(stateData[index]['countryInfo']['flag'],height: 25.0,),
              SizedBox(width: 10.0,),
              Text(stateData[index]['country'], style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 10.0,),
              Text('Deaths:' + stateData[index]['deaths'].toString(), style: TextStyle(color: Colors.red)),
            ],
          ),
        );
    },
      itemCount: 5,),
    );
  }
}
