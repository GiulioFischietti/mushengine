import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mushroom_finder/pages/search_results.dart';
import 'package:flutter/foundation.dart';
import 'package:mushroom_finder/repository/upload_repository.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, @required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PickedFile _image;
  bool isLoading = false;

  _imgFromCamera() async {
    PickedFile image = (await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50));

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            SearchResults(title: "Results", path_image: image.path)));
  }

  _imgFromGallery() async {
    PickedFile image = (await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50));

    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) =>
            SearchResults(title: "Results", path_image: image.path)));
  }

  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text("Uploading image...",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.grey[800])))
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                          margin: EdgeInsets.only(left: 20, bottom: 20),
                          child: Text("MushEngine",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: defaultTargetPlatform ==
                                              TargetPlatform.iOS ||
                                          defaultTargetPlatform ==
                                              TargetPlatform.android
                                      ? 38
                                      : 64,
                                  color: Colors.grey[700]))),
                      Container(
                          margin: EdgeInsets.only(
                              left:
                                  defaultTargetPlatform == TargetPlatform.iOS ||
                                          defaultTargetPlatform ==
                                              TargetPlatform.android
                                      ? 10
                                      : 20,
                              bottom: 20),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(defaultTargetPlatform ==
                                              TargetPlatform.android ||
                                          defaultTargetPlatform ==
                                              TargetPlatform.iOS
                                      ? "https://cdn-icons-png.flaticon.com/512/263/263888.png"
                                      : './263888.png'))))
                    ]),

                    AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        margin: defaultTargetPlatform == TargetPlatform.iOS ||
                                defaultTargetPlatform == TargetPlatform.android
                            ? EdgeInsets.symmetric(horizontal: 40)
                            : EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey[400].withOpacity(0.8),
                                  spreadRadius: 4,
                                  blurRadius: 8)
                            ],
                            border:
                                Border.all(width: 0.5, color: Colors.grey[400]),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        width: defaultTargetPlatform == TargetPlatform.iOS ||
                                defaultTargetPlatform == TargetPlatform.android
                            ? size.width
                            : size.width / 2.5,
                        child: InkWell(
                            onTap: () {
                              !(defaultTargetPlatform == TargetPlatform.iOS ||
                                      defaultTargetPlatform ==
                                          TargetPlatform.android)
                                  ? _imgFromGallery()
                                  : showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext bc) {
                                        return SafeArea(
                                          child: Container(
                                            child: new Wrap(
                                              children: <Widget>[
                                                new ListTile(
                                                    leading: new Icon(
                                                        Icons.photo_library),
                                                    title: new Text('Galleria'),
                                                    onTap: () {
                                                      _imgFromGallery();
                                                      Navigator.of(context)
                                                          .pop();
                                                    }),
                                                new ListTile(
                                                  leading: new Icon(
                                                      Icons.photo_camera),
                                                  title: new Text('Fotocamera'),
                                                  onTap: () {
                                                    _imgFromCamera();
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                              ;
                            },
                            onHover: (bool is_hover) {
                              setState(() {
                                isHover = is_hover;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text(
                                            "Search by uploading a photo",
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey[600])))),
                                Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(Icons.camera_alt,
                                        color: Colors.grey[600]))
                              ],
                            ))),
                    // Container(
                    //     margin: EdgeInsets.all(20),
                    //     height: size.width / 4,
                    //     width: size.width / 4,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10),
                    //         image: DecorationImage(
                    //             image: _image != null
                    //                 ? NetworkImage(_image.path)
                    //                 : NetworkImage("webcolours-unknown.png"),
                    //             fit: BoxFit.cover)))
                  ],
                )),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
