import 'package:bac_project/core/services/api/supabase/supabase_settings.dart';

class ApiSettings {
  //
  static const receiveTimeout = 60;
  static const sendTimeout = 60 * 60;
  static const connectTimeout = 15;
  //
  static const baseUrl = SupabaseSettings.url;
  //
}

class ApiHeaders {
  ///
  /// [Keys]
  ///
  static const headerAuthorizationKey = 'Authorization'; // capitalize 'A'
  static const headerContentTypeKey = 'Content-Type';
  static const headerAcceptKey = 'Accept';
  static const headerApiKey = 'apikey';

  ///
  /// [Values]
  ///
  static const headerAuthorizationBearer = 'Bearer'; // fix typo 'barer' -> 'Bearer'
  static const headerContentTypeJson = 'application/json';
}

class SupabaseEndpoints {
  ///
  static const getTotalUnitsFunctionEndpoint = "fn_api_units_get_total_units";
  static const getTotalLessonsFunctionEndpoint = "fn_api_lessons_get_total_lessons";
  static const getLessonsQuestionsFunctionEndpoint = "fn_api_lessons_get_questions";
  static const getAppSettingsFunctionEndpoint = "fn_api_settings_get_app_settings";
  static const getUserResultsFunctionEndpoint = "fn_api_get_user_results";
  static const getUserResultByIdFunctionEndpoint = "fn_api_results_get_user_result_by_id";
  static const getResultLeaderboardFunctionEndpoint = "fn_api_results_get_result_leaderboard";
  static const getTestOptionsFunctionEndpoint = "fn_api_questions_get_test_options";
  static const getQuestionsByIdsFunctionEndpoint = "fn_api_questions_get_questions_by_ids";
  static const getAnswersEvaluationsByIdsFunctionEndpoint =
      "fn_api_evaluations_get_answers_evaluations_by_ids";
  static const getResultQuestionsWithAnswersFunctionEndpoint =
      "fn_api_results_get_result_questions_with_answers";
  static const getResultQuestionsDetailsFunctionEndpoint =
      "fn_api_results_get_result_questions_details";
  static const addUserResultEdgeFunctionEndpoint = "add_user_result";
  // Device Token Management
  static const registerDeviceTokenFunction = "fn_api_device_tokens_register_device_token";

  // Notification Retrieval & Management
  static const getUserNotificationsFunction = "fn_api_notifications_get_user_notifications";
  static const markNotificationsAsReadFunction = "fn_api_notifications_mark_notifications_as_read";
  static const sendBulkNotificationEdgeFunctionEndpoint = "send_bulk_notification";

  // Topic Subscription Management
  static const subscribeToTopicFunction = "fn_api_topics_subscribe_to_topic";
  static const unsubscribeFromTopicFunction = "fn_api_topics_unsubscribe_from_topic";
  static const getUserSubscribedTopicsFunction = "fn_api_topics_get_user_subscribed_topics";
  static const getTotalNotificationsTopicsFunction =
      "fn_api_notifications_get_total_notifications_topics";

  ///
  static String rpc(String functionName) => '/rest/v1/rpc/$functionName';
  static String edge(String functionName) => '/functions/v1/$functionName';
}
