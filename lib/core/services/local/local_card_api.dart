import 'dart:convert';
import 'package:bac_project/presentation/home/models/custom_card_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalCardApi {
  static Future<List<CustomCardData>> fetchCardsFromJson() async {
    final jsonString = await rootBundle.loadString(
      'assets/json/card_data.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => CustomCardData.fromJson(item)).toList();
  }
}
