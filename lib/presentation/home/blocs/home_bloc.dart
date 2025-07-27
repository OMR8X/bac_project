import 'package:bac_project/presentation/home/models/custom_action_card_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bac_project/features/tests/domain/usecases/get_units_use_case.dart';
import 'package:bac_project/features/tests/domain/requests/get_units_request.dart';
import 'package:bac_project/features/tests/domain/entities/unit.dart';
import 'package:bac_project/core/injector/app_injection.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUnitsUseCase _getUnitsUseCase;

  HomeBloc({GetUnitsUseCase? getUnitsUseCase})
    : _getUnitsUseCase = getUnitsUseCase ?? sl<GetUnitsUseCase>(),
      super(HomeInitial()) {
    on<HomeEventInitialize>(_onInitialize);
    on<HomeEventRefresh>(_onRefresh);
  }

  Future<void> _onInitialize(
    HomeEventInitialize event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());
    try {
      // Use the use case to get units
      final result = await _getUnitsUseCase.call(
        const GetUnitsRequest(),
      );

      result.fold((failure) => emit(HomeError(failure.message)), (response) {
        // Convert units to action cards
        final cards =
            response.units
                .map(
                  (unit) => CustomCardData(
                    title: unit.title,
                    subtitle: unit.subtitle,
                    firstButtonText: 'ابدأ الدراسة',
                    secondButtonText: 'معاينة',
                  ),
                )
                .toList();
        emit(HomeLoaded(cards, response.units));
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void _onRefresh(HomeEventRefresh event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      // Use the use case to get units
      final result = await _getUnitsUseCase.call(
        const GetUnitsRequest(),
      );

      result.fold((failure) => emit(HomeError(failure.message)), (response) {
        // Convert units to action cards
        final cards =
            response.units
                .map(
                  (unit) => CustomCardData(
                    title: unit.title,
                    subtitle: unit.subtitle,
                    firstButtonText: 'ابدأ الدراسة',
                    secondButtonText: 'معاينة',
                  ),
                )
                .toList();
        emit(HomeLoaded(cards, response.units));
      });
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
