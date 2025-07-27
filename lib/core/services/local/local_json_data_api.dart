import 'dart:convert';
import 'package:bac_project/presentation/home/models/custom_action_card_model.dart';
import 'package:bac_project/presentation/home/models/custom_navigation_card_model.dart';
import 'package:bac_project/presentation/result/models/custom_result_card_model.dart';
import 'package:bac_project/features/tests/data/models/unit_model.dart';
import 'package:bac_project/features/tests/data/models/lesson_model.dart';
import 'package:bac_project/features/tests/data/models/test_options_model.dart';
import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:flutter/services.dart' show rootBundle;

class LocalJsonDataApi {
  static Future<List<CustomCardData>> fetchFoo(String jsonfile) async {
    final jsonString = await rootBundle.loadString(jsonfile);
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => CustomCardData.fromJson(item)).toList();
  }

  static Future<List<UnitModel>> fetchUnits() async {
    final jsonString = await rootBundle.loadString('assets/json/units_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => UnitModel.fromJson(item)).toList();
  }

  static Future<List<LessonModel>> fetchLessons() async {
    final jsonString = await rootBundle.loadString('assets/json/lessons_data.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => LessonModel.fromJson(item)).toList();
  }

  static Future<TestOptionsModel> fetchTestOptions() async {
    final jsonString = await rootBundle.loadString('assets/json/test_options_data.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString);
    return TestOptionsModel.fromJson(jsonData);
  }

  static Future<List<QuestionModel>> fetchQuestions() async {
    final jsonString = await rootBundle.loadString('assets/json/questions.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    return jsonData.map((item) => QuestionModel.fromJson(item)).toList();
  }
}
