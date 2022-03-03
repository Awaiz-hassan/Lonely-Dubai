import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:http/http.dart' as http;
import 'package:lonelydubai/Screens/TourDetailsScreen.dart';
import 'package:lottie/lottie.dart';
import '../Themes/AppTheme.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textEditingController;
  List<AllTours> _searchRes = [];

  bool _validate = false;
  bool loading = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  searchTours(String location) async {
    var client = http.Client();

    setState(() {
      loading = true;
    });
    String url =
        "https://lonelydubai.com/wp-json/lonely/v2/search?search=$location&post_type=tour";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        setState(() {
          loading = false;
          _searchRes = allToursFromJson(jsonString);
          print(_searchRes);
        });
      }
    } on Exception {
      setState(() {
        loading = false;
        _searchRes = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.pink,
        ),
        backgroundColor: AppTheme.pink,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      body: Column(
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
              Image.asset(
                "assets/images/logo.png",
                color: Colors.black,
                height: 50,
              ),
              Container(
                height: 50,
                width: 50,
              )
            ],
          ),
          Card(
              margin: const EdgeInsets.only(
                  top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              color: Colors.white,
              elevation: 2.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: Colors.white, width: 1.5)),
              child: SizedBox(
                height: 50.0,
                child: SizedBox.expand(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 0.0, left: 10.0, right: 10.0),
                    child: TextField(
                      controller: _textEditingController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) {
                        setState(() {
                          if (_textEditingController.text.isEmpty) {
                            _validate = false;
                          } else {
                            _validate = true;
                          }
                        });

                        if (_validate) {
                          searchTours(
                              _textEditingController.text.toString().trim());
                        }
                      },
                      cursorColor: AppTheme.black,
                      decoration: const InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 3.0, right: 3.0),
                          border: InputBorder.none,
                          hintText: 'Where you want to go?',
                          hintStyle: TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
              )),
          Expanded(
              child: loading
                  ? Center(
                      child: Lottie.asset('assets/animations/loading.json',
                          height: 100.0))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _searchRes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
                          height: 350,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl: _searchRes[index].tourImage,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: double.infinity,
                                ),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              Flexible(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 5.0, top: 5.0),
                                child: Text(
                                  _searchRes[index].postTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, right: 5.0, top: 3.0),
                                child: Text(
                                  _searchRes[index].postExcerpt,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "AED    " +
                                          _searchRes[index].tourPrice[0],
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: AppTheme.pink),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    margin: EdgeInsets.only(top: 10),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>  TourDetails(_searchRes[index])));
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
                              )
                            ],
                          ),
                        );
                      },
                    )),
        ],
      ),
    );
  }
}
