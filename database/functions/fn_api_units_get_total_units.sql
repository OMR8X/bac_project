CREATE OR REPLACE FUNCTION api.fn_api_units_get_total_units()
RETURNS JSONB
SECURITY DEFINER
LANGUAGE SQL
AS $$
  SELECT api.api_response(
    json_build_object(
      'units', json_agg(unit_row)
    )::jsonb,
    'ok'::text,
    'Units retrieved successfully'::text
  )
  FROM (
    SELECT
      u.id,
      u.title,
      u.subtitle,
      COUNT(l.id) AS lessons_count,
      u.icon_url,
      u.created_at
    FROM units u
    LEFT JOIN lessons l ON l.unit_id = u.id
    GROUP BY u.id, u.title, u.subtitle, u.icon_url,u.created_at
    ORDER BY u.id ASC
  ) AS unit_row;
$$;