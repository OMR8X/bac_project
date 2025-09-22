CREATE OR REPLACE FUNCTION api.fn_api_results_get_result_leaderboard(p_result_id int)
RETURNS JSON 
SECURITY DEFINER
AS $$
BEGIN
  RETURN (
    SELECT json_build_object(
      'data', json_agg(to_jsonb(r))
    )
    FROM (
      SELECT * 
      FROM results 
      LIMIT 10
    ) r
  );
END;
$$ LANGUAGE plpgsql;
