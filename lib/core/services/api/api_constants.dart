class ApiSettings {
  //
  static const receiveTimeout = 60;
  static const sendTimeout = 60 * 60;
  static const connectTimeout = 15;
  //
  static const baseUrl = 'https://yyckcezjjzfxktiannbm.supabase.co';
  //
}

class ApiHeaders {
  ///
  /// [Keys]
  ///
  static const headerAuthorizationKey = 'Authorization'; // capitalize 'A'
  static const headerContentTypeKey = 'Content-Type';
  static const headerAcceptKey = 'Accept';
  static const headerApiKey = 'apikey'; // match supabase required header name

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
  static const addUserResultFunctionEndpoint = "fn_api_add_user_result";

  ///
  static String rpc(String functionName) => '/rest/v1/rpc/$functionName';
}
