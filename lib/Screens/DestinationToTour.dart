import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:lonelydubai/Screens/TourDetailsScreen.dart';
import 'package:lottie/lottie.dart';
import '../Themes/AppTheme.dart';
import 'SearchScreen.dart';

class DestinationToTour extends StatefulWidget {
  int destinationId;
  String destinationName;
  String imageUrl;

  DestinationToTour(this.destinationId, this.destinationName, this.imageUrl);

  @override
  _DestinationToTourState createState() => _DestinationToTourState();
}

class _DestinationToTourState extends State<DestinationToTour> {
  late Future<List<AllTours>> _destinationTours;

  late ScrollController _scrollViewController;
  bool _showAppbar = true;
  bool isScrollingDown = false;

  @override
  void initState() {
    _destinationTours =
        HttpClient.getToursByDestination( widget.destinationId);
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
              height: _showAppbar ? 300.0 : 56.0,
              duration: const Duration(milliseconds: 200),
              child: _showAppbar
                  ? Container(
                      child: Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: CachedNetworkImage(
                                imageUrl: widget.imageUrl,
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
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: 80, left: 30, right: 30),
                                child: Text(
                                  widget.destinationName,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 25),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SearchScreen()));
                                },
                                child: Card(
                                    color: Colors.white,
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        side: const BorderSide(
                                            color: Colors.white, width: 1.5)),
                                    child: const SizedBox(
                                      height: 40.0,
                                      child: SizedBox.expand(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top: 10.0, left: 10.0, right: 10.0),
                                          child: Text(
                                            "Where you want to go?",
                                            style: TextStyle(
                                                fontSize: 15, color: Colors.grey),
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
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
                        Text(widget.destinationName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis,),
                        Container(height: 50,width: 50,)
                      ],),
                    ),
            ),
            Expanded(
              child: Container(
                margin:const EdgeInsets.only(left: 10.0,right: 10.0),
                child: FutureBuilder(
                    future: _destinationTours,
                    builder: (BuildContext ctx,
                            AsyncSnapshot<List<AllTours>> snapshot) =>
                        snapshot.hasData
                            ? GridView.builder(
                                controller: _scrollViewController,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisExtent: 250, crossAxisCount: 2),
                                itemCount: snapshot.data?.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Container(
                                      margin: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            child: CachedNetworkImage(
                                              imageUrl: snapshot
                                                  .data![index].tourImage,
                                              fit: BoxFit.fill,
                                              width: double.infinity,
                                              height: 150,
                                            ),
                                          ),
                                          SizedBox(
                                              height: 35,
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5.0,
                                                          left: 5.0,
                                                          right: 5.0),
                                                  child: Text(
                                                    snapshot
                                                        .data![index].postTitle,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ))),
                                          Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                            Flexible(
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    "AED " +
                                                        snapshot.data![index]
                                                            .tourPrice[0],
                                                    style:  TextStyle(
                                                        color: AppTheme.pink,
                                                        fontSize: 12.0,
                                                        fontWeight: FontWeight.bold),
                                                    overflow: TextOverflow.ellipsis,

                                                  ),

                                                )),
                                              Container(
                                                height: 25,
                                                width:80,
                                                margin: EdgeInsets.only(top: 10),
                                                child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) => TourDetails(snapshot.data![index])));
                                                  },
                                                  child: const Text("Book Now",maxLines: 1,overflow: TextOverflow.ellipsis,),
                                                  style: TextButton.styleFrom(
                                                      padding: const EdgeInsets.only(
                                                          left: 5.0, right: 5.0),
                                                      primary: Colors.white,
                                                      backgroundColor: AppTheme.pink),
                                                ),
                                              )
                                          ],)
                                        ],
                                      ));
                                })
                            : Center(
                                child: Center(
                                    child: Lottie.asset(
                                        'assets/animations/loading.json',
                                        height: 100.0)),
                              )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}