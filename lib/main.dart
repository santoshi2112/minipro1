import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'pages/places_page.dart';

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
              child:Text('Copyrights \u00a9 santoshi meghana manisha')
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

class MyPicturePage extends StatefulWidget {
  @override
  _MyPicturePageState createState() => _MyPicturePageState();
}
class _MyPicturePageState extends State<MyPicturePage> {
   File _image;
  String base64Image;
 getData() async {
  Map data ={
  "requests": [{
    "image": {
      "content": base64Image
    },
    "features": [{
      "maxResults": 1,
      "type": "LANDMARK_DETECTION"
    }]
  }]
  };

    String body = json.encode(data);
    http.Response response = await http.post(
      'https://vision.googleapis.com/v1/images:annotate',
       headers: {"Content-Type": "application/json","Authorization": "Bearer ya29.c.Ko8B0AetyEPeJZVJm13h8p1ytFeiAjDlqy3X9SijDgN-5H4rRZKfoL41vneYM-0aS7OVVWnIqBre1mAZc0Kvhg0LjX2MLIcx-oyB3zWo7N530WWKlYIwX-aR1S1PI0hKup7TdXwaonUuBGv_8q34Z018dthsuBfHTmjb85XZ_iXLdj08ZTiLDoObWqzljd6kNWM"},
        body: body,
      );
      if(response.statusCode==200 && response.body!=null){
    print(response.body);
    var value=json.decode(response.body);
    var data1=value['responses'][0]['landmarkAnnotations'][0]['description'];
    print(data1);
      }
      else{
        print('No Landmark found take picture again');
      }
 }

 
  _openGallery(BuildContext context) async{
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = _image.readAsBytesSync();
    print(imageBytes);
    base64Image = base64Encode(imageBytes);
    print('string is');
    print(base64Image);
    print("You selected gallery image : " + _image.path);
    getData();
    setState(() {
    });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context)async{
    _image = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> imageBytes = _image.readAsBytesSync();
    print(imageBytes);
    base64Image = base64Encode(imageBytes);
    print('string is');
    print(base64Image);
    print("You selected gallery image : " + _image.path);
    getData();
    setState(() {
        });
    Navigator.of(context).pop();
  }
  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
      return AlertDialog(
        title: Text('Choose a Source'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              GestureDetector(
                child:Text("Gallery"),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              GestureDetector(
                child:Text("Camera"),
                onTap: (){
                  _openCamera(context);
                },
              )
            ]
          ),
        ),
      );
    });
  }
  Widget _isImage(){
    if(_image==null){
      return Text('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nNo Image Selected ! \n\n\n\n ');
    }
    else{

      return Image.file(_image,width: 400,height: 400);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Image Detector')
      ),
      body: Center(child: Column(children: <Widget>[Container(
        child:Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[ 
            _isImage(),
            RaisedButton(onPressed: (){
              _showChoiceDialog(context);
            },child: Text('Select Image !'),
            ),
          ],
        ),
        ),
      ),

      Container(
        child:RaisedButton(
          onPressed: () {},
          child: Text('Get to know more'),
        ),
      )],),)

    );
  }
}
