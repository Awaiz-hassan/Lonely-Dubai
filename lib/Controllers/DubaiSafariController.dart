import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllTours.dart';

class DubaiSafariController extends GetxController{
  var dubaiSafariToursList = <AllTours>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    dubaiSafariTours();
    super.onInit();
  }

  void dubaiSafariTours() async {
    try {
      isLoading(true);
      var dubaiSafariTours = await HttpClient.getToursByDestination(294);
      dubaiSafariToursList.value = dubaiSafariTours;
    } finally {
      isLoading(false);
    }
  }
}