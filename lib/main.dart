//import 'dart:convert';
//import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:http/http.dart' as http;
import 'pages/places_page.dart';
import 'pics/pics_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new App());
  }

}

final TextStyle textStyleGreen=TextStyle(
  
  color: Colors.blueGrey,
  fontWeight: FontWeight.bold,
  fontSize: 42,
  fontStyle: FontStyle.italic,
);
class App extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      theme:ThemeData(
        primarySwatch:Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
        ),
        body: Center(
          
          child: Center(child: Column(children: <Widget>[
           
            Container(
                child: Text('\n\n\n\nWELCOME\n       TO\n  VIRTUAL\n  TOURIST\n    GUIDE !\n\n\n\n',style: textStyleGreen),alignment: Alignment.center,)
                ,
            Container(
              child: FloatingActionButton(
                child: Text('click to explore'),
                
                onPressed:(){
                 Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyHomePage()),
  );
              },),alignment: Alignment.bottomRight,
            ),
            Container(
              child:Text('Copyrights \u00a9 C0B3B4')
            )
                
          ])
            
          ),
        ),
      ),
    
    );
  }
 
   }

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Virtual Tourist Guide'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(75),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  MyPicturePage()),
  );},
                  child: Text('TAKE PICTURE'),
                  highlightElevation: 20.0,
                  highlightColor: Colors.pink[200],
                  padding: EdgeInsets.all(75),
                  color: Colors.lightBlue[100],
                  textColor: Colors.black,
                )),
                Container(
                margin: EdgeInsets.all(40),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  PlacesPage()),
                    );
                  },
                  child: Text('GET NEAR-BY \n LOCATIONS'),
                  highlightElevation: 20.0,
                  highlightColor: Colors.pink[200],
                  padding: EdgeInsets.all(75),
                  color: Colors.lightBlue[100],
                  textColor: Colors.black,
                  
                )),
          ])),
        ));
  }
}