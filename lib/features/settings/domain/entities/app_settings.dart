import 'package:bac_project/features/settings/domain/entities/section.dart';
import 'package:bac_project/features/settings/domain/entities/governorate.dart';
import 'package:bac_project/features/settings/domain/entities/version.dart';

class AppSettings {
  final List<Section> sections;
  final List<Governorate> governorates;
  final Version version;

  AppSettings({required this.sections, required this.governorates, required this.version});
}
