CREATE OR REPLACE FUNCTION api.fn_api_results_get_result_leaderboard(p_result_id int)
RETURNS JSONB
SECURITY DEFINER
AS $$
BEGIN
  RETURN api.api_response(
    jsonb_build_object(
      'results',
      coalesce(json_agg(to_jsonb(r)), '[]'::json)
    ),
    true,
    api.get_message('results_get_result_leaderboard_retrieved')
  )
  FROM (
    SELECT *
    FROM results
    LIMIT 10
  ) r;
END;
$$ LANGUAGE plpgsql;

-- Messages for fn_api_results_get_result_leaderboard
INSERT INTO messages (key, message) VALUES
  ('results_get_result_leaderboard_retrieved', 'تم استرجاع لوحة الصدارة للنتائج بنجاح')
ON CONFLICT (key) DO UPDATE SET message = EXCLUDED.message;

