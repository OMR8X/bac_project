CREATE OR REPLACE FUNCTION api.fn_api_settings_get_app_settings () RETURNS JSONB 
SECURITY DEFINER
LANGUAGE SQL as $$
    SELECT api.api_response(
        json_build_object(
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
                        'title', title
                    )
                ) FROM sections 
            ),
            'governorates', (
                SELECT json_agg(
                    json_build_object(
                        'id', id,
                        'title', title
                    )
                ) FROM governorates  
            ),
            'categories', (
                SELECT json_agg(
                    json_build_object(
                        'id',id,
                        'title',title,
                        'created_at',created_at,
						'is_typeable',is_typeable,
						'is_orderable',is_orderable,
						'is_mcq',is_mcq,
						'is_single_answer',is_single_answer,
                        'updated_at',updated_at
                    )
                ) FROM question_categories
            ),
            'version', json_build_object(
               'id', '1',
               'current_version', '2.0.0',
               'minimum_version', '1.5.0',
               'update_link', 'https://example.com/update',
               'app_version', '2.0.0'
            )
        )::jsonb,
        'ok'::text,
        'App settings retrieved successfully'::text
    );
$$;