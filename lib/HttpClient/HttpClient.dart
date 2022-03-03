import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:lonelydubai/Model/AllDestinations.dart';
import 'package:lonelydubai/Model/AllTours.dart';
import 'package:lonelydubai/Model/Search.dart';

import 'package:lonelydubai/Model/TopTour.dart';
import '../Model/TopDestination.dart';

class HttpClient {
  static var client = http.Client();

  static Future<List<TopDestination>> getTopDestination() async {
    List<TopDestination> topDestination = [];
    String url = "https://lonelydubai.com/wp-json/lonely/v2/top_destination";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        topDestination = topDestinationFromJson(jsonString);
      }
    } on Exception {
      return topDestination;
    }
    return topDestination;
  }

  static Future<List<AllTours>> getTopTours() async {
    List<AllTours> topTours = [];
    String url = "https://lonelydubai.com/wp-json/lonely/v2/top_tours";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        topTours = allToursFromJson(jsonString);
      }
    } on Exception {
      return topTours;
    }
    return topTours;
  }











  static Future<List<AllDestinations>> getAllDestinations(
       int page_no, int number_of_posts) async {
    List<AllDestinations> allDestinations = [];
    String url = "https://lonelydubai.com/wp-json/lonely/v2/get_all_dest?page_no=$page_no&number_of_posts=$number_of_posts";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        allDestinations = allDestinationsFromJson(jsonString);
      }
    } on Exception {
      return allDestinations;
    }
    return allDestinations;
  }


  static Future<List<AllTours>> getAllTours(
      int page_no, int number_of_posts) async {
    List<AllTours> allTours = [];
    String url = "https://lonelydubai.com/wp-json/lonely/v2/get_all_tours?page_no=$page_no&number_of_posts=$number_of_posts";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        allTours = allToursFromJson(jsonString);
      }
    } on Exception {
      return allTours;
    }
    return allTours;
  }



  static Future<List<AllTours>> getToursByDestination(
      int destination_id) async {
    List<AllTours> allTours = [];
    String url = "https://lonelydubai.com/wp-json/lonely/v2/get_dest_tours?dest_id=$destination_id";
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        allTours = allToursFromJson(jsonString);
      }
    } on Exception {
      return allTours;
    }
    return allTours;
  }
}
