import 'package:get/get.dart';
import 'package:lonelydubai/HttpClient/HttpClient.dart';
import 'package:lonelydubai/Model/AllTours.dart';

class DhowCruiseController extends GetxController{
  var dhowCruiseList = <AllTours>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    dubaiSafariTours();
    super.onInit();
  }

  void dubaiSafariTours() async {
    try {
      isLoading(true);
      var dhowCruiseTours = await HttpClient.
      getToursByDestination(293);
      dhowCruiseList.value = dhowCruiseTours;
    } finally {
      isLoading(false);
    }
  }
}