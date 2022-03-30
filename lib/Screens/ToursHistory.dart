

import 'package:flutter/material.dart';
import 'package:lonelydubai/Themes/AppTheme.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/BookedTour.dart';

class ToursHistory extends StatefulWidget {
  const ToursHistory({Key? key}) : super(key: key);

  @override
  State<ToursHistory> createState() => _ToursHistoryState();
}

class _ToursHistoryState extends State<ToursHistory> {
  bool loading = false;
  bool errorOccur = false;
  List<BookedTour> _bookedTours = [];

  @override
  void initState() {
    getBookedTours();
    super.initState();
  }

  getBookedTours() async {
    var client = http.Client();
    loading = true;
    setState(() {});
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('key');
    if (token == null) {
      return;
    }
    try {
      var response = await client.get(
        Uri.parse(
            "https://lonelydubai.com/booking/public/api/getUserBookingTours"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        var jsonString = response.body;
        setState(() {
          loading = false;
          errorOccur = false;
          _bookedTours = bookedTourFromJson(jsonString);
        });
      } else {
        setState(() {
          loading = false;
          errorOccur = true;
          _bookedTours = [];
        });
      }
    } on Exception {
      setState(() {
        loading = false;
        errorOccur = true;
        _bookedTours = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.all(5.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppTheme.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Flexible(
                    child: Text(
                  "Tours History",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.shortestSide < 550
                          ? 16
                          : 20),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                )),
                const SizedBox(
                  height: 50,
                  width: 50,
                )
              ],
            ),
            Expanded(
              child: loading
                  ? Center(
                      child: Lottie.asset('assets/animations/loading.json',
                          height: 80.0))
                  : errorOccur
                      ? Center(
                        child: SizedBox(
                            child: TextButton(
                              onPressed: () {
                                getBookedTours();
                              },
                              child: const Text(
                                "Retry",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              style: TextButton.styleFrom(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  primary: Colors.white,
                                  backgroundColor: AppTheme.pink),
                            ),
                          ),
                      )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: _bookedTours.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    elevation: 5.0,
                                    shadowColor: AppTheme.lightGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    margin: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 10,
                                        bottom: 10),
                                    child: SizedBox(
                                      height: 200,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 10.0,
                                                right: 10.0,
                                                bottom: 10.0),
                                            child: Text(
                                              _bookedTours[index].tours,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
            )
          ],
        ),
      ),
    );
  }
}
