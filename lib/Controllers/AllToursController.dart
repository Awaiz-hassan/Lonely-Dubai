import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllTours.dart';

class AllToursController extends GetxController{
  var allToursList = <AllTours>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    allDestinations();
    super.onInit();
  }

  void allDestinations() async {
    try {
      isLoading(true);
      var allTours = await HttpClient.getAllTours(1, 100);
      allToursList.value = allTours;
    } finally {
      isLoading(false);
    }
  }
}