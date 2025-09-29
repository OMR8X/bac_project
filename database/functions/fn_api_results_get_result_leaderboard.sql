CREATE OR REPLACE FUNCTION api.fn_api_results_get_result_leaderboard(p_result_id int)
RETURNS JSONB
SECURITY DEFINER
AS $$
BEGIN
  RETURN api.api_response(
    json_agg(to_jsonb(r))::jsonb,
    'success'::text,
    'Results leaderboard retrieved successfully'::text
  )
  FROM (
    SELECT *
    FROM results
    LIMIT 10
  ) r;
END;
$$ LANGUAGE plpgsql;
