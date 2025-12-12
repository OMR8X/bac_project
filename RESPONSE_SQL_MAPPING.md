# Response Classes and SQL Functions Mapping

This document lists all response classes and their corresponding SQL function files.

## Tests Feature

| Response Class | SQL Function File |
|----------------|-------------------|
| `GetTestOptionsResponse` | `fn_api_questions_get_test_options.sql` |
| `GetUnitsResponse` | `fn_api_units_get_total_units.sql` |
| `GetQuestionsResponse` | `fn_api_lessons_get_questions.sql` |
| `GetQuestionsResponse` | `fn_api_questions_get_questions_by_ids.sql` |
| `GetLessonsResponse` | `fn_api_lessons_get_total_lessons.sql` |

## Results Feature

| Response Class | SQL Function File |
|----------------|-------------------|
| `GetResultsResponse` | `fn_api_get_user_results.sql` |
| `GetResultResponse` | `fn_api_results_get_user_result_by_id.sql` |
| `GetResultQuestionsDetailsResponse` | `fn_api_results_get_result_questions_details.sql` |
| `GetResultLeaderboardResponse` | `fn_api_results_get_result_leaderboard.sql` |
| `GetAnswerEvaluationsResponse` | `fn_api_evaluations_get_answers_evaluations_by_ids.sql` |

## Notifications Feature

| Response Class | SQL Function File |
|----------------|-------------------|
| `GetNotificationsResponse` | `fn_api_notifications_get_user_notifications.sql` |
| `GetUserSubscribedTopicsResponse` | `fn_api_topics_get_user_subscribed_topics.sql` |
| `GetNotificationsTopicsResponse` | `fn_api_notifications_get_total_notifications_topics.sql` |
| `RemoteSubscribeResponse` | `fn_api_topics_subscribe_to_topic.sql` |
| `RemoteUnsubscribeResponse` | `fn_api_topics_unsubscribe_from_topic.sql` |

## Settings Feature

| Response Class | SQL Function File |
|----------------|-------------------|
| `GetAppSettingsResponse` | `fn_api_settings_get_app_settings.sql` |

---

## Summary

- **Total Response-SQL Function Pairs**: 16

