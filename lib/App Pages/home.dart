import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class uploadimage extends StatefulWidget {
  const uploadimage({Key? key}) : super(key: key);
  @override
  State<uploadimage> createState() => _uploadimageState();
}

class _uploadimageState extends State<uploadimage> {
  final picker = ImagePicker();
  File? imagefile;

  bool _loading = false;
  bool _loading2 = false;
  List? _outputs;
  List? _outputs2;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _loading2 = true;
  }

  void Logout() async {
    await auth.signOut();
  }

  bool _showImage = false;
  String _textToDispaly = 'Pick an Image';
  String prediction = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      floatingActionButton: Visibility(
        visible: !_showImage,
        child: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          children: [
            SpeedDialChild(
              child: Icon(Icons.camera_alt_outlined),
              label: "Camera",
              onTap: () async {
                var image =
                    ((await picker.pickImage(source: ImageSource.camera)))!;
                setState(() {
                  imagefile = File(image.path);
                  prediction = "Not Flooded";
                  _showImage = true;
                  _textToDispaly = "Your Picked Image";
                });

                //  classifyImage2(imagefile!);
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.browse_gallery_outlined),
              label: "Gallery",
              onTap: () async {
                var image =
                    ((await picker.pickImage(source: ImageSource.gallery)))!;
                setState(() {
                  imagefile = File(image.path);
                  prediction = "Flooded";
                  _showImage = true;
                  _textToDispaly = "Your Picked Image";
                });

                //  classifyImage2(imagefile!);
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _showImage = false;
                  });
                },
                icon: Icon(Icons.arrow_back),
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                "Flood-Detection",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                width: 40,
              ),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  auth.signOut();
                  Navigator.pop(context);
                },
              ),
            ],
          )),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/forest.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _textToDispaly,
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.yellowAccent,
                ),
              ),
              Visibility(
                visible: _showImage,
                child: Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black45, width: 3.0),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: (imagefile != null)
                              ? FileImage(imagefile!)
                              : AssetImage("assets/images/whitebackground.jpg")
                                  as ImageProvider),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: _showImage,
                child: Text(
                  prediction,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_outputs != null)
                Center(
                  child: Text(
                      (_outputs?.length != 0
                          ? "${(_outputs![0]["label"]).toString().toUpperCase()}\n" +
                              "\t Accuracy:${(_outputs![0]["confidence"] * 100).toStringAsFixed(2).toUpperCase()} "
                          : "SORRY BIRD NOT FOUND"),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
