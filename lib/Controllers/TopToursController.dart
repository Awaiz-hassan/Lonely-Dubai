import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:lonelydubai/Model/TopTour.dart';

class TopToursController extends GetxController{
  var topToursList = <AllTours>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTopTours();
    super.onInit();
  }

  void fetchTopTours() async {
    try {
      isLoading(true);
      var topTours = await HttpClient.getTopTours();
      topToursList.value = topTours;
    } finally {
      isLoading(false);
    }
  }
}