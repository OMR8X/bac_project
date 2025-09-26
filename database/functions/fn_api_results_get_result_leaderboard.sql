CREATE OR REPLACE FUNCTION api.fn_api_results_get_result_leaderboard(p_result_id int)
RETURNS JSON
SECURITY DEFINER
AS $$
DECLARE
  result_data json;
BEGIN
  result_data := (
    SELECT json_agg(to_jsonb(r))
    FROM (
      SELECT *
      FROM results
      LIMIT 10
    ) r
  );

  RETURN api.api_response(
    data := result_data,
    message := 'Result leaderboard retrieved successfully'
  );
END;
$$ LANGUAGE plpgsql;
