CREATE OR REPLACE FUNCTION api.fn_api_settings_get_app_settings()
 RETURNS json
 LANGUAGE sql
 SECURITY DEFINER
AS $function$
    SELECT json_build_object(
        'data', json_build_object(
            'user_data', (
              SELECT json_build_object(
                'uuid', u.id,
                'email', u.email,
                'name', u.raw_user_meta_data->>'name',
                'sectionId', u.raw_user_meta_data->>'section_id',
                'governorateId', u.raw_user_meta_data->>'governorate_id'
              )
              FROM auth.users u
              WHERE u.id = auth.uid()
            ),
            'motivational_quote',(
                json_build_object(
                    'quote','احيانا يجب ان تعرف من وقت لوقت ان عمر عمك',
                    'author','عمك',
                    'date','2025-08-28'
                )
            ),
            'sections', (
                SELECT json_agg(
                    json_build_object(
                        'id', id,
                        'name', name
                    )
                ) FROM sections where is_visible = true
            ),
            'governorates', (
                SELECT json_agg(
                    json_build_object(
                        'id', id,
                        'name', name
                    )
                ) FROM governorates where is_visible = true
            ),
            'categories', (
                SELECT json_agg(
                    json_build_object(
                        'id',id,
                        'name',name,
                        'created_at',created_at,
                        'updated_at',updated_at
                    )
                ) FROM categories where is_visible = true
            ),
            'version', json_build_object(
               'id', '1',
               'current_version', '2.0.0',
               'minimum_version', '1.5.0',
               'update_link', 'https://example.com/update',
               'app_version', '2.0.0'
            )
        )
    );
$function$;
