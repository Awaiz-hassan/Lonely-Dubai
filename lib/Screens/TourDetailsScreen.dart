import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:lonelydubai/Screens/BookTour.dart';

import '../Themes/AppTheme.dart';

class TourDetails extends StatefulWidget {
  AllTours tourDetails;

  TourDetails(this.tourDetails, {Key? key}) : super(key: key);

  @override
  _TourDetailsState createState() => _TourDetailsState();
}

class _TourDetailsState extends State<TourDetails> {
  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    _scrollViewController = ScrollController();
    _scrollViewController.addListener(() {
      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (!isScrollingDown) {
          isScrollingDown = true;
          _showAppbar = false;
          setState(() {});
        }
      }

      if (_scrollViewController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (_scrollViewController.position.atEdge) {
          bool _atTop = _scrollViewController.position.pixels == 0;
          if (isScrollingDown & _atTop) {
            isScrollingDown = false;
            _showAppbar = true;
            setState(() {});
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AnimatedContainer(
              height: _showAppbar ? 270.0 : 56.0,
              duration: const Duration(milliseconds: 200),
              child: _showAppbar
                  ? Container(
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: CachedNetworkImage(
                                imageUrl: widget.tourDetails.tourImage,
                                height: 270.0,
                                fit: BoxFit.cover,
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                                margin: const EdgeInsets.all(5.0),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          Expanded(
                            child: Text(
                              widget.tourDetails.postTitle,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 50,
                          )
                        ],
                      ),
                    ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: _scrollViewController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 8.0),
                    child: Text(
                      widget.tourDetails.postTitle,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding:
                                const EdgeInsets.only(left: 15.0, top: 8.0),
                            child: Text(
                              "from",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                            child: Text(
                              "AED " + widget.tourDetails.tourPrice[0],
                              style:
                                  TextStyle(fontSize: 18, color: AppTheme.pink),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 30,
                        margin: EdgeInsets.only(top: 20, right: 15),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  BookTour(widget.tourDetails)));
                          },
                          child: const Text("Book Now"),
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0),
                              primary: Colors.white,
                              backgroundColor: AppTheme.pink),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(top: 10.0, left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        tabItem("assets/icons/clock.svg",
                            widget.tourDetails.tourDays[0] + " Days"),
                        tabItem("assets/icons/address_card.svg",
                            "Age " + widget.tourDetails.tourMinAge[0] + "+"),
                        tabItem("assets/icons/person.svg",
                            widget.tourDetails.tourAvailability[0]),
                        tabItem("assets/icons/money.svg",
                            "AED " + widget.tourDetails.tourPrice[0])
                      ],
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, top: 0.0, bottom: 0.0),
                    child: Text(
                      "Details ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 5.0, right: 20.0, bottom: 10.0),
                    child: Text(
                      widget.tourDetails.postExcerpt,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0),
                    child: Text(
                      "Instructions",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Departure ",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              widget.tourDetails.tourDeparture[0],
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: BoxConstraints(minHeight: 50),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Departure Time",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 10.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Text(
                              widget.tourDetails.tourDepartureTime[0],
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Included",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                for (var i in widget.tourDetails.tourInclude[0])
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: AppTheme.pink,
                                        size: 18.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Text(
                                          i.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 8.0),
                    child: Container(
                      constraints: BoxConstraints(minHeight: 50),
                      child: Row(
                        children: [
                          Container(
                              width: 140,
                              margin: EdgeInsets.only(left: 15.0),
                              child: Text(
                                "Not Included",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.charcoal),
                              )),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                for (var i
                                    in widget.tourDetails.tourNotIncluded[0])
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.clear,
                                        color: AppTheme.charcoal,
                                        size: 18.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: Text(
                                          i.toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget tabItem(String iconPath, String text) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: (MediaQuery.of(context).size.width / 5) - 6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 15,
            width: 15,
          ),
          Container(
              margin: EdgeInsets.only(top: 12.0),
              height: 40,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: AppTheme.black),
                maxLines: 2,
              )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollViewController.removeListener(() {});
    _scrollViewController.dispose();

    super.dispose();
  }
}
