import 'package:bac_project/core/resources/errors/failures.dart';
import 'package:bac_project/features/notifications/domain/entities/notifications_topic.dart';
import 'package:bac_project/features/notifications/domain/requests/subscribe_to_topic_request.dart';
import 'package:bac_project/features/notifications/domain/requests/unsubscribe_from_topic_request.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_notifications_topics_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/get_user_subscribed_topics_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/subscribe_to_topic_usecase.dart';
import 'package:bac_project/features/notifications/domain/usecases/unsubscribe_to_topic_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/services/logs/logger.dart';
part 'notifications_topics_event.dart';
part 'notifications_topics_state.dart';

class NotificationsTopicsBloc extends Bloc<NotificationsTopicsEvent, NotificationsTopicsState> {
  final GetNotificationsTopicsUsecase _getNotificationsTopicsUsecase;
  final GetUserSubscribedTopicsUsecase _getUserSubscribedTopicsUsecase;
  final SubscribeToTopicUsecase _subscribeToTopicUsecase;
  final UnsubscribeToTopicUsecase _unsubscribeToTopicUsecase;
  NotificationsTopicsBloc(
    this._getNotificationsTopicsUsecase,
    this._getUserSubscribedTopicsUsecase,
    this._subscribeToTopicUsecase,
    this._unsubscribeToTopicUsecase,
  ) : super(const NotificationsTopicsState()) {
    on<LoadTopicsEvent>(_onLoadTopicsEvent);
    on<SubscribeToTopicEvent>(_onSubscribeToTopicEvent);
    on<UnsubscribeFromTopicEvent>(_onUnsubscribeFromTopicEvent);
  }

  Future<void> _onLoadTopicsEvent(
    LoadTopicsEvent event,
    Emitter<NotificationsTopicsState> emit,
  ) async {
    emit(state.copyWith(status: NotificationsTopicsStatus.loading));

    // Load all available topics
    final topicsResultResponse = await _getNotificationsTopicsUsecase.call();

    // Load user's subscribed topics
    final subscribedTopicsResultResponse = await _getUserSubscribedTopicsUsecase.call();

    final topicsList = topicsResultResponse.fold(
      (l) => throw Exception(l.message),
      (r) => r.topics,
    );
    final subscribedTopicsList = subscribedTopicsResultResponse.fold(
      (l) => throw Exception(l.message),
      (r) => r.topics,
    );

    emit(
      state.copyWith(
        status: NotificationsTopicsStatus.loaded,
        topics: topicsList.where((NotificationsTopic topic) => topic.subscribable).toList(),
        subscribedTopicIds: subscribedTopicsList.map((topic) => topic.id).toList(),
        failure: null,
      ),
    );
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    Logger.error(error.toString());
    super.onError(error, stackTrace);
  }

  Future<void> _onSubscribeToTopicEvent(
    SubscribeToTopicEvent event,
    Emitter<NotificationsTopicsState> emit,
  ) async {
    // Optimistically update UI immediately
    final updatedSubscribedTopicIds = [...state.subscribedTopicIds, event.topic.id];
    emit(state.copyWith(subscribedTopicIds: updatedSubscribedTopicIds));

    // Perform API call in background
    final request = SubscribeToTopicRequest(
      topicId: event.topic.id,
      firebaseTopicName: event.topic.firebaseTopic,
    );

    final result = await _subscribeToTopicUsecase.call(request);

    result.fold(
      (failure) {
        Logger.error(failure.message, stackTrace: StackTrace.current);
        final topicsIds = state.subscribedTopicIds.where((id) => id != event.topic.id).toList();
        emit(state.copyWith(subscribedTopicIds: topicsIds));
        throw Exception(failure.message);
      },
      (_) {},
    );
  }

  Future<void> _onUnsubscribeFromTopicEvent(
    UnsubscribeFromTopicEvent event,
    Emitter<NotificationsTopicsState> emit,
  ) async {
    Logger.message('Unsubscribing from topic: ${event.topic.id}');
    // Optimistically update UI immediately
    final updatedSubscribedTopicIds =
        state.subscribedTopicIds.where((id) => id != event.topic.id).toList();
    emit(state.copyWith(subscribedTopicIds: updatedSubscribedTopicIds));

    // Perform API call in background
    final request = UnsubscribeFromTopicRequest(
      topicId: event.topic.id,
      firebaseTopicName: event.topic.firebaseTopic,
    );

    final result = await _unsubscribeToTopicUsecase.call(request);

    result.fold(
      (failure) {
        Logger.error(failure.message, stackTrace: StackTrace.current);
        // Revert optimistic update on failure
        final revertedSubscribedTopicIds = [...state.subscribedTopicIds, event.topic.id];
        emit(state.copyWith(subscribedTopicIds: revertedSubscribedTopicIds, failure: failure));
      },
      (_) {},
    );
  }
}
