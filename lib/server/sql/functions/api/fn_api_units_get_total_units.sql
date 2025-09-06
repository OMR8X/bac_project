CREATE OR REPLACE FUNCTION api.fn_api_units_get_total_units()
 RETURNS json
 LANGUAGE sql
AS $function$
  SELECT json_build_object(
    'units', json_agg(unit_row )
  )
  FROM (
    SELECT
      u.id,
      u.title,
      u.subtitle,
      COUNT(l.id) AS lessons_count,
      u.icon,
      u.created_at
    FROM units u
    
    LEFT JOIN lessons l ON l.unit_id = u.id
    where u.is_visible = true
    GROUP BY u.id, u.title, u.subtitle, u.icon,u.created_at
    ORDER BY u.id ASC
  ) AS unit_row;
$function$;
