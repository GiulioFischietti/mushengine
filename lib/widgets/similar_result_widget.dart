import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mushroom_finder/model/result_query.dart';
import 'package:mushroom_finder/pages/fullscreenimage.dart';

class SimilarResultWidget extends StatefulWidget {
  ResultQuery result;
  SimilarResultWidget({Key key, this.result}) : super(key: key);

  @override
  State<SimilarResultWidget> createState() => _SimilarResultWidgetState();
}

class _SimilarResultWidgetState extends State<SimilarResultWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: () {
          // widget.body['keyword'] = item;
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (ctx) => SearchResults(
          //           body: widget.body,
          //         )));
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) =>
                  FullScreenImage(image: widget.result.file_name)));
        },
        child: Container(
            height: (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android)
                ? size.width / 1.2
                : 300,
            width: (defaultTargetPlatform == TargetPlatform.iOS ||
                    defaultTargetPlatform == TargetPlatform.android)
                ? size.width / 1.2
                : 300,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(widget.result.file_name),
                    fit: BoxFit.cover)),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    widget.result.file_class,
                    style: GoogleFonts.poppins(color: Colors.black),
                  )),
              Expanded(child: Container()),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: widget.result.distance > 0.7
                          ? Colors.green[800]
                          : widget.result.distance > 0.6
                              ? Colors.yellow[800]
                              : widget.result.distance > 0.4
                                  ? Colors.red[600]
                                  : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    widget.result.distance.toStringAsFixed(4),
                    style: GoogleFonts.poppins(color: Colors.white),
                  ))
            ])));
  }
}
