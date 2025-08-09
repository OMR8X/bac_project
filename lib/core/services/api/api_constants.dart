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

  ///
  static String rpc(String functionName) => '/rest/v1/rpc/$functionName';
}
