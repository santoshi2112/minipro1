import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MyPicturePage extends StatefulWidget {
  @override
  _MyPicturePageState createState() => _MyPicturePageState();
}
class _MyPicturePageState extends State<MyPicturePage> {
   File _image;
   String name="";
   String n2="";
  String base64Image;
  final TextStyle textStyleGreen=TextStyle(
  
  color: Colors.blueGrey,
  fontWeight: FontWeight.bold,
  fontSize: 42,
  fontStyle: FontStyle.italic,
);
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
       headers: {"Content-Type": "application/json","Authorization": "Bearer ya29.c.Ko8B0AcPbRlyW4SmKPaJvjI3RBThvtBk7VIDibcsV0_W8_NhK7bUiraytrJpMR-IafGguArgaeitg04YB3eHI5KPbwNpGG5Cxw7VHj2ipJpvUOZX06xT5GcQQdR4qyS4zpfYmfYjUww3aQ-IAcKm3pJBWTkdbIYqPXiL6kktPyhysFUqIKvwZgheKS8pZxwrvB8"},
        body: body
      );
    var value=json.decode(response.body);
    if(response.statusCode==200){
    print(response.body);
    var data1=value['responses'][0]['landmarkAnnotations'][0]['description'];
    print(data1);
    setState(() {
      name=data1.toString();
    });
   }
      else{
        print('No Landmark found take picture again');
        setState(() {
          name='No Landmark found take picture again';
        });
      }
 }

 
  _openGallery(BuildContext context) async{
    setState(() {
      name="";
    });
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
    setState(() {
      name="";
    });
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


  _urlLaunch() async {
    String val=name;
    String url = 'https://en.wikipedia.org/wiki/$val';
    if (await canLaunch(url)) {
    await launch(url);
  } else {
    n2='Could not launch $url';
    throw 'Could not launch $url';
  }
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

      return Image.file(_image,width: 400,height: 350);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Image Detector')
      ),
      body: Center(child: Column(children: <Widget>[Container(
        margin: const EdgeInsets.all(8.0),
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
        margin: const EdgeInsets.all(5.0),
        child: Text('$name',style:textStyleGreen),
      ),


      Container(
        margin: const EdgeInsets.all(5.0),
        child:RaisedButton(
          onPressed: () {
            _urlLaunch();
          },
          child: Text('Get to know more'),
        ),
      ),
      Container(
          child: Text('$n2'),
      ),
      ],)
      ,)

    );
  }
}
