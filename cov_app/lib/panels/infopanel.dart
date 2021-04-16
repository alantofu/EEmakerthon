import 'package:cov_app/datasource.dart';
import 'package:cov_app/pages/faqs.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class InfoPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('FAQS', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              launch('https://www.mercy.org.my/donate/covid19/');
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              color: primaryBlack,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('DONATE', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ),
            GestureDetector(
              onTap: (){
                launch('https://www.outbreak.my/map');
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                color: primaryBlack,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('LIVE LOCATION OUTBREAK', style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                    Icon(Icons.arrow_forward, color: Colors.white),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
