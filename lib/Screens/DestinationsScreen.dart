import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:lonelydubai/Controllers/AllDestinationsController.dart';
import 'package:lonelydubai/Screens/DestinationToTour.dart';
import 'package:lonelydubai/Screens/SearchScreen.dart';
import 'package:lonelydubai/Themes/AppTheme.dart';
import 'package:lottie/lottie.dart';

class DestinationsScreen extends StatefulWidget {
  const DestinationsScreen({Key? key}) : super(key: key);

  @override
  _DestinationsScreenState createState() => _DestinationsScreenState();
}

class _DestinationsScreenState extends State<DestinationsScreen>
    with AutomaticKeepAliveClientMixin {
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
  }

  final AllDestinationsController _allDestinationsController =
      Get.put(AllDestinationsController());

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppTheme.pink,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        toolbarHeight: 56.0,
        centerTitle: true,
        title: const Text(
          'Destinations',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
              child: Card(
                  margin: EdgeInsets.only(left: 20, right: 20.0, bottom: 20.0),
                  color: Colors.white,
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: const BorderSide(color: Colors.white, width: 1.5)),
                  child: SizedBox(
                    height: 40.0,
                    child: SizedBox.expand(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 10.0, right: 10.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search_rounded,
                              color: Colors.grey,
                            ),
                            Text(
                              "   Where you want to go?",
                              style: TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
            Obx(() => _allDestinationsController.isLoading.value
                ? Expanded(
                    child: Center(
                        child: Lottie.asset('assets/animations/loading.json',
                            height: 100.0)),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          _allDestinationsController.allDestinationsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DestinationToTour(
                                        _allDestinationsController
                                            .allDestinationsList[index].id,
                                        _allDestinationsController
                                            .allDestinationsList[index]
                                            .postTitle,_allDestinationsController.allDestinationsList[index].destinationImage)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, right: 20.0, left: 20.0),
                            height: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: 200,
                                    width: double.infinity,
                                    imageUrl: _allDestinationsController
                                        .allDestinationsList[index]
                                        .destinationImage,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                Flexible(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, top: 5.0),
                                  child: Text(
                                    _allDestinationsController
                                        .allDestinationsList[index].postTitle,
                                    style: TextStyle(
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
                                    _allDestinationsController
                                        .allDestinationsList[index].postExcerpt,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
