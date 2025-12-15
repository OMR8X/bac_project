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
    api.get_message('results_leaderboard_retrieved')
  )
  FROM (
    SELECT *
    FROM results
    LIMIT 10
  ) r;
END;
$$ LANGUAGE plpgsql;
