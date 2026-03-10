import 'package:equatable/equatable.dart';
import 'package:neuro_app/features/auth/domain/entites/user_data.dart';
import 'package:neuro_app/features/settings/domain/entities/motivational_quote.dart';
import 'package:neuro_app/features/settings/domain/entities/section.dart';
import 'package:neuro_app/features/settings/domain/entities/governorate.dart';
import 'package:neuro_app/features/settings/domain/entities/version.dart';
import 'package:neuro_app/features/tests/domain/entities/question_category.dart';

class AppSettings extends Equatable {
  final UserData? userData;
  final MotivationalQuote? motivationalQuote;
  final List<Section> sections;
  final List<Governorate> governorates;
  final Version version;
  final List<QuestionCategory> categories;

  const AppSettings({
    required this.userData,
    required this.motivationalQuote,
    required this.sections,
    required this.governorates,
    required this.version,
    required this.categories,
  });

  @override
  List<Object?> get props => [
    userData,
    motivationalQuote,
    sections,
    governorates,
    version,
    categories,
  ];
}
