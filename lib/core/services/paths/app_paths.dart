import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AppPaths {
  late final Directory _appDocumentsDir;
  late final String _appPrivatePdfFilesPath;

  Directory get appDocumentsDir => _appDocumentsDir;
  String get appPrivatePdfFilesPath => _appPrivatePdfFilesPath;

  Future<void> init() async {
    //
    _appDocumentsDir = Platform.isIOS ? (await getDownloadsDirectory() ?? await getApplicationDocumentsDirectory()) : (await getApplicationDocumentsDirectory());
    //
    _appPrivatePdfFilesPath = '${_appDocumentsDir.path}/pdf_files';
    // Ensure the directory exists
    final pdfFilesDir = Directory(_appPrivatePdfFilesPath);
    if (!await pdfFilesDir.exists()) {
      await pdfFilesDir.create(recursive: true);
    }
  }
}
