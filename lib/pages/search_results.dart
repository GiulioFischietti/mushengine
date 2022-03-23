import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
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
                                margin: EdgeInsets.only(left: 20, top: 20),
                                child: Text("Classification Results",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 38,
                                        color: Colors.grey[700]))),
                            Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20, bottom: 20),
                                child: Text(
                                    "Classification results obtained submitting the image",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 18,
                                        color: Colors.grey[400]))),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(20),
                                  alignment: Alignment.centerLeft,
                                  height: 220,
                                  width: 220,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: widget.path_image != null
                                              ? NetworkImage(widget.path_image)
                                              : NetworkImage(
                                                  "webcolours-unknown.png"))),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Text("Class",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey[700]))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 20),
                                            child: Text("Agaricus",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey[400]))),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Text("Confidence",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey[700]))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 20),
                                            child: Text("70%",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey[400]))),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 20, bottom: 20),
                                            child: Text("Lorem Ipsum",
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14,
                                                    color: Colors.grey[700]))),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 20),
                                            child: Text("Lorem Ipsum",
                                                style: GoogleFonts.poppins(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 14,
                                                    color: Colors.grey[400]))),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                )),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 40, top: 100),
                child: Text("Similar Images",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 38,
                        color: Colors.grey[700]))),
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 40, bottom: 20),
                child: Text("Top 10 similar images",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.grey[400]))),
            Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Wrap(
                  children: [
                    "Image1",
                    "Image2",
                    "Image3",
                    "Image4",
                    "Image5",
                    "Image6",
                    "Image7",
                    "Image8",
                    "Image9",
                    "Image10"
                  ]
                      .map(
                        (item) => InkWell(
                            onTap: () {
                              // widget.body['keyword'] = item;
                              // Navigator.of(context).push(MaterialPageRoute(
                              //     builder: (ctx) => SearchResults(
                              //           body: widget.body,
                              //         )));
                            },
                            child: Container(
                                height: 300,
                                width: 300,
                                margin: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[400]),
                                child: Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white),
                                    )))),
                      )
                      .toList()
                      .cast<Widget>(),
                ))
          ])),
    );
  }
}
