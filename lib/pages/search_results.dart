import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mushroom_finder/model/query_response.dart';
import 'package:mushroom_finder/model/result_query.dart';
import 'package:mushroom_finder/pages/fullscreenimage.dart';
import 'package:mushroom_finder/widgets/similar_result_widget.dart';
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
                                      child: Text("Your Image",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 38,
                                              color: Colors.grey[700]))),
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 20,
                                          top: (defaultTargetPlatform ==
                                                      TargetPlatform.iOS ||
                                                  defaultTargetPlatform ==
                                                      TargetPlatform.android)
                                              ? 10
                                              : 0),
                                      child: Text(
                                          "Basic info regarding the mushroom",
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
                                              : size.width / 3,
                                          width: !(defaultTargetPlatform ==
                                                      TargetPlatform.iOS ||
                                                  defaultTargetPlatform ==
                                                      TargetPlatform.android)
                                              ? 220
                                              : size.width / 3,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[400],
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
                                      Flexible(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20,
                                                  top: (defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .iOS ||
                                                          defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .android)
                                                      ? 10
                                                      : 0),
                                              child: RichText(
                                                  text: TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Class:  ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700])),
                                                  TextSpan(
                                                      text: results
                                                          .classificationResult
                                                          .classname,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700])),
                                                ],
                                              ))),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 20,
                                                  top: (defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .iOS ||
                                                          defaultTargetPlatform ==
                                                              TargetPlatform
                                                                  .android)
                                                      ? 10
                                                      : 0),
                                              child: RichText(
                                                  text: TextSpan(
                                                // Note: Styles for TextSpans must be explicitly defined.
                                                // Child text spans will inherit styles from parent
                                                style: const TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Probability:  ',
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700])),
                                                  TextSpan(
                                                      text: (results
                                                                  .classificationResult
                                                                  .confidence *
                                                              100)
                                                          .toStringAsFixed(2),
                                                      style: GoogleFonts
                                                          .poppins(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .grey[700])),
                                                ],
                                              ))),
                                        ],
                                      ))
                                    ],
                                  )
                                ],
                              )),
                        ],
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 40, top: 40),
                      child: Text("Similar Images",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 38,
                              color: Colors.grey[700]))),
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 40, bottom: 20, right: 40),
                      child: Text(
                          "Top 20 similar images, with class name and score",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.normal,
                              fontSize: 18,
                              color: Colors.grey[400]))),
                  Container(
                      alignment: Alignment.centerRight,
                      margin: EdgeInsets.only(
                          left: 40, right: 40, bottom: 0, top: 0),
                      child: Text(
                          "Query took ${results.query_time.toStringAsFixed(4)}s",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.grey[700]))),
                  Container(
                      margin: EdgeInsets.only(left: 15, right: 15),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: results.resultQuery
                            .map((ResultQuery item) =>
                                SimilarResultWidget(result: item))
                            .toList()
                            .cast<Widget>(),
                      ))
                ])),
    );
  }
}
