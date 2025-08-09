import 'package:bac_project/features/tests/data/models/question_model.dart';
import 'package:bac_project/features/tests/data/models/option_model.dart';

/// Utility class for generating sample questions with Arabic lorem ipsum text
class SampleQuestionsGenerator {
  /// Generates a list of 10 sample questions with Arabic lorem ipsum text
  static List<QuestionModel> generateSampleQuestions(int lessonId) {
    return [
      _createQuestion(
        id: 1,
        text: "ما هو الجهاز المسؤول عن تنظيم درجة حرارة الجسم في الإنسان؟",
        correctAnswer: "الجهاز العصبي",
        wrongAnswers: ["الجهاز الهضمي", "الجهاز التنفسي", "الجهاز الدوري"],
        lessonId: lessonId,
      ),
      _createQuestion(
        id: 2,
        text: "أي من العناصر التالية يعتبر من الغازات النبيلة في الجدول الدوري؟",
        correctAnswer: "الأرجون",
        wrongAnswers: ["الأكسجين", "النيتروجين", "الهيدروجين"],
        lessonId: lessonId,
      ),
      _createQuestion(
        id: 3,
        text: "ما هي العملية التي تحول فيها النباتات ثاني أكسيد الكربون إلى أكسجين؟",
        correctAnswer: "البناء الضوئي",
        wrongAnswers: ["التنفس الخلوي", "التخمر", "الإنبات"],
        lessonId: lessonId,
      ),
      _createQuestion(
        id: 4,
        text: "أي من المعادلات التالية تمثل قانون نيوتن الثاني للحركة؟",
        correctAnswer: "القوة = الكتلة × التسارع",
        wrongAnswers: [
          "السرعة = المسافة ÷ الزمن",
          "الطاقة = الكتلة × مربع السرعة",
          "الضغط = القوة ÷ المساحة",
        ],
        lessonId: lessonId,
      ),
      _createQuestion(
        id: 5,
        text: "ما هو العضو المسؤول عن تصفية الدم في جسم الإنسان؟",
        correctAnswer: "الكلى",
        wrongAnswers: ["الكبد", "القلب", "الرئتين"],
        lessonId: lessonId,
      ),
    ];
  }

  /// Creates a single question with the given parameters
  static QuestionModel _createQuestion({
    required int id,
    required String text,
    required String correctAnswer,
    required List<String> wrongAnswers,
    int? lessonId,
  }) {
    // Create options list with correct answer and wrong answers
    final options = <OptionModel>[
      OptionModel(id: 0, text: correctAnswer, isCorrect: true),
      ...wrongAnswers.asMap().entries.map(
        (entry) => OptionModel(id: entry.key + 2, text: entry.value, isCorrect: false),
      ),
    ];
    return QuestionModel(
      id: id,
      text: text,
      options: options.map((option) => option.toEntity()).toList(),
      lessonId: lessonId,
    );
  }
}
