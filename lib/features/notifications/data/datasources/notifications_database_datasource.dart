import 'package:dartz/dartz.dart';
import 'package:bac_project/core/services/api/api_constants.dart';
import 'package:bac_project/core/services/api/api_manager.dart';
import 'package:bac_project/core/services/api/responses/api_response.dart';
import '../../domain/requests/get_notifications_request.dart';
import '../../domain/requests/register_device_token_request.dart';
import '../../domain/requests/mark_notifications_as_read_request.dart';
import '../../domain/requests/subscribe_to_topic_request.dart';
import '../../domain/requests/unsubscribe_from_topic_request.dart';
import '../responses/get_notifications_response.dart';
import '../responses/get_notifications_topics_response.dart';
import '../responses/get_user_subscribed_topics_response.dart';

abstract class NotificationsDatabaseDatasource {
  ///
  Future<Unit> registerDeviceToken(RegisterDeviceTokenRequest request);
  Future<GetNotificationsResponse> getNotifications(GetNotificationsRequest request);

  ///
  Future<Unit> markNotificationsAsRead(MarkNotificationsAsReadRequest request);

  ///
  Future<Unit> subscribeToTopicInDatabase(SubscribeToTopicRequest request);
  Future<Unit> unsubscribeFromTopicInDatabase(UnsubscribeFromTopicRequest request);
  Future<GetUserSubscribedTopicsResponse> getUserSubscribedTopics();
  Future<GetNotificationsTopicsResponse> getNotificationsTopics();
}

class NotificationsDatabaseDatasourceImplements implements NotificationsDatabaseDatasource {
  final ApiManager apiManager;

  NotificationsDatabaseDatasourceImplements({required this.apiManager});

  @override
  Future<Unit> registerDeviceToken(RegisterDeviceTokenRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.registerDeviceTokenFunction),
      body: request.toJsonBody(),
    );
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return unit;
  }

  @override
  Future<GetNotificationsResponse> getNotifications(GetNotificationsRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getUserNotificationsFunction),
      body: request.toJsonBody(),
    );
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return GetNotificationsResponse.fromJson(apiResponse.data);
  }

  @override
  Future<Unit> markNotificationsAsRead(MarkNotificationsAsReadRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.markNotificationsAsReadFunction),
      body: request.toJsonBody(),
    );
    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return unit;
  }

  @override
  Future<Unit> subscribeToTopicInDatabase(SubscribeToTopicRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.subscribeToTopicFunction),
      body: request.toJsonBody(),
    );

    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return unit;
  }

  @override
  Future<Unit> unsubscribeFromTopicInDatabase(UnsubscribeFromTopicRequest request) async {
    final response = await apiManager().post(
      SupabaseEndpoints.rpc(SupabaseEndpoints.unsubscribeFromTopicFunction),
      body: request.toJsonBody(),
    );

    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return unit;
  }

  @override
  Future<GetUserSubscribedTopicsResponse> getUserSubscribedTopics() async {
    final response = await apiManager().get(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getUserSubscribedTopicsFunction),
    );

    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return GetUserSubscribedTopicsResponse.fromJson(apiResponse.data);
  }

  @override
  Future<GetNotificationsTopicsResponse> getNotificationsTopics() async {
    final response = await apiManager().get(
      SupabaseEndpoints.rpc(SupabaseEndpoints.getTotalNotificationsTopicsFunction),
    );

    final ApiResponse apiResponse = ApiResponse.fromDioResponse(response);
    apiResponse.throwErrorIfExists();

    return GetNotificationsTopicsResponse.fromJson(apiResponse.data);
  }
}
