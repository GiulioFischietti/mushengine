import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mushroom_finder/model/query_response.dart';
import 'package:mushroom_finder/model/result_query.dart';
import 'package:mushroom_finder/pages/fullscreenimage.dart';
import 'package:mushroom_finder/repository/upload_repository.dart';

class SearchResults extends StatefulWidget {
  String path_image;
  SearchResults({Key key, @required this.path_image, @required this.title})
      : super(key: key);

  final String title;

  @override
  State<SearchResults> createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  @override
  void initState() {
    super.initState();
    findKnn();
  }

  QueryResponse results;
  bool loading = true;

  findKnn() async {
    QueryResponse response = await uploadImage(File(widget.path_image));

    setState(() {
      results = response;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: loading
          ? Container(
              height: size.height,
              child: Center(child: CircularProgressIndicator()))
          : Center(
              child: ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                  InkWell(
                      onTap: () {
                        Navigator.of(context).pop(context);
                      },
                      child: Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left: 40, top: 40, bottom: 40, right: 20),
                              child: Icon(Icons.arrow_back_ios)),
                          Container(
                              child: Text(
                            "Back",
                            style: GoogleFonts.poppins(),
                          ))
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 40, bottom: 10, top: 30),
                      child: Text(
                          "Search query took ${results.query_time.toStringAsFixed(4)} seconds",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey[700]))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin:
                                          EdgeInsets.only(left: 20, top: 20),
                                      child: Text("Image Submitted",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 38,
                                              color: Colors.grey[700]))),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          bottom: 20,
                                          top: (defaultTargetPlatform ==
                                                      TargetPlatform.iOS ||
                                                  defaultTargetPlatform ==
                                                      TargetPlatform.android)
                                              ? 10
                                              : 0),
                                      child: Text(
                                          "The image that you have uploaded",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18,
                                              color: Colors.grey[400]))),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.all(20),
                                          alignment: Alignment.centerLeft,
                                          height: !(defaultTargetPlatform ==
                                                      TargetPlatform.iOS ||
                                                  defaultTargetPlatform ==
                                                      TargetPlatform.android)
                                              ? 220
                                              : size.width / 2 - 40,
                                          width: !(defaultTargetPlatform ==
                                                      TargetPlatform.iOS ||
                                                  defaultTargetPlatform ==
                                                      TargetPlatform.android)
                                              ? 220
                                              : size.width / 2 - 40,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: (defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .android ||
                                                          defaultTargetPlatform ==
                                                              TargetPlatform.iOS)
                                                      ? FileImage(File(widget.path_image))
                                                      : NetworkImage(widget.path_image),
                                                  fit: BoxFit.cover))),
                                    ],
                                  )
                                ],
                              )),
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 40, top: 20),
                      child: Text("Similar Images",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              color: Colors.grey[700]))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 40, bottom: 20),
                      child: Text("Top 20 similar images",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.grey[400]))),
                  Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: results.resultQuery
                            .map(
                              (ResultQuery item) => InkWell(
                                  onTap: () {
                                    // widget.body['keyword'] = item;
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (ctx) => SearchResults(
                                    //           body: widget.body,
                                    //         )));
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (ctx) => FullScreenImage(
                                                image: item.file_name)));
                                  },
                                  child: Container(
                                      height: (defaultTargetPlatform ==
                                                  TargetPlatform.iOS ||
                                              defaultTargetPlatform ==
                                                  TargetPlatform.android)
                                          ? size.width / 1.2
                                          : 300,
                                      width: (defaultTargetPlatform ==
                                                  TargetPlatform.iOS ||
                                              defaultTargetPlatform ==
                                                  TargetPlatform.android)
                                          ? size.width / 1.2
                                          : 300,
                                      margin: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image:
                                                  NetworkImage(item.file_name),
                                              fit: BoxFit.cover)),
                                      child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  item.file_class,
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.black),
                                                )),
                                            Expanded(child: Container()),
                                            Container(
                                                margin: EdgeInsets.all(10),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                    color: item.distance > 0.7
                                                        ? Colors.green[800]
                                                        : item.distance > 0.6
                                                            ? Colors.yellow[800]
                                                            : item.distance >
                                                                    0.4
                                                                ? Colors
                                                                    .red[600]
                                                                : Colors
                                                                    .grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Text(
                                                  item.distance
                                                      .toStringAsFixed(4),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white),
                                                ))
                                          ]))),
                            )
                            .toList()
                            .cast<Widget>(),
                      ))
                ])),
    );
  }
}
