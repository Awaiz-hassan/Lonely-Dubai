import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/TopDestination.dart';

class TopDestinationsController extends GetxController{
  var topDestinationList = <TopDestination>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTopDestinations();
    super.onInit();
  }

  void fetchTopDestinations() async {
    try {
      isLoading(true);
      var topDestinations = await HttpClient.getTopDestination();
      topDestinationList.value = topDestinations;
    } finally {
      isLoading(false);
    }
  }
}