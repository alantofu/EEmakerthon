import 'package:flutter/material.dart';

class MalaysiaPanel extends StatelessWidget {
  final Map malaysiaData;

  const MalaysiaPanel({Key key, this.malaysiaData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2),
        children: <Widget>[
          StatusPanel(
            title: 'CONFIRMED',
            panelColor: Colors.red[100],
            textColor: Colors.red,
            count: malaysiaData['cases'].toString(),
          ),
          StatusPanel(
            title: 'ACTIVE',
            panelColor: Colors.blue[100],
            textColor: Colors.blue,
            count: malaysiaData['active'].toString(),
          ),
          StatusPanel(
            title: 'RECOVERED',
            panelColor: Colors.green[100],
            textColor: Colors.green,
            count: malaysiaData['recovered'].toString(),
          ),
          StatusPanel(
            title: 'DEATH',
            panelColor: Colors.grey[400],
            textColor: Colors.grey[800],
            count: malaysiaData['deaths'].toString(),
          ),
        ],
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {

  final String title;
  final String count;
  final Color panelColor;
  final Color textColor;

  const StatusPanel(
      {Key key, this.panelColor, this.textColor, this.title, this.count})
      : super(key: key); //initialization IMPORTANT!

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10.0),
      height: 80, width: width/2,
      color: panelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,
              style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.bold,color: textColor)),
          Text(count,
              style: TextStyle(
                  fontSize: 16.0, fontWeight: FontWeight.bold,color: textColor)
          )
        ],
      ),
    );
  }
}
