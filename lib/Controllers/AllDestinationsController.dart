
import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllDestinations.dart';

class AllDestinationsController extends GetxController{
  var allDestinationsList = <AllDestinations>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    allDestinations();
    super.onInit();
  }

  void allDestinations() async {
    try {
      isLoading(true);
      var allDestinations = await HttpClient.getAllDestinations(1, 20);
      allDestinationsList.value = allDestinations;
    } finally {
      isLoading(false);
    }
  }
}