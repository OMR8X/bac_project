import 'package:mockito/annotations.dart';
// Note: We'll import to generate mocks for:
import 'package:neuro_app/features/results/data/datasources/results_remote_data_source.dart';
import 'package:neuro_app/features/results/domain/repositories/results_repository.dart';

/// Define the classes to generate Mockito mocks for, for the entire results feature.
/// Run `dart run build_runner build --delete-conflicting-outputs` to generate the `.mocks.dart` file.
@GenerateMocks([
  ResultsRemoteDataSource,
  ResultsRepository,
])
void main() {}
