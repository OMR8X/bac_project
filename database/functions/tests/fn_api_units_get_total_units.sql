CREATE OR REPLACE FUNCTION api.fn_api_units_get_total_units()
RETURNS JSONB
SECURITY DEFINER
LANGUAGE SQL
AS $$
  SELECT api.api_response(
    json_build_object(
      'units', json_agg(unit_row)
    )::jsonb,
    true,
    api.get_message('units_get_total_units_retrieved')
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

-- Messages for fn_api_units_get_total_units
INSERT INTO messages (key, message) VALUES
  ('units_get_total_units_retrieved', 'تم استرجاع الوحدات بنجاح')
ON CONFLICT (key) DO UPDATE SET message = EXCLUDED.message;