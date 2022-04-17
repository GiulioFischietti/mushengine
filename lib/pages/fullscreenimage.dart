import 'package:flutter/material.dart';

class FullScreenImage extends StatefulWidget {
  String image;
  FullScreenImage({Key key, this.image}) : super(key: key);

  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveViewer(
          child: Container(
              height: size.height,
              width: size.width,
              child: Image(
                image: NetworkImage(widget.image),
                fit: BoxFit.contain,
              ))),
    );
  }
}
