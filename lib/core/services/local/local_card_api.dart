import 'dart:convert';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart';
import 'package:bac_project/presentation/home/models/custom_navigation_card_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalActionCardApi {
  static Future<List<CustomCardData>> fetchCardsFromJson(
    String jsonfile,
  ) async {
    final jsonString = await rootBundle.loadString(jsonfile);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => CustomCardData.fromJson(item)).toList();
  }
}
//'assets/json/card_data.json'

class LocalNavigationCardApi {
  static Future<List<CustomNavigationCardData>> fetchCardsFromJson(
    String jsonsfile,
  ) async {
    final jsonString = await rootBundle.loadString(jsonsfile);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData
        .map((item) => CustomNavigationCardData.fromJson(item))
        .toList();
  }
}
//assets/json/navigation_card_data.json