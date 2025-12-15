DO $$
DECLARE
    lesson RECORD;
    q_id INTEGER;
BEGIN
    -- Loop through all lessons
    FOR lesson IN 
        SELECT id, title 
        FROM public.lessons
    LOOP

        -------------------------------------------
        -- Category 1: "اختر الإجابة الصحيحة"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('اختر الإجابة الصحيحة', lesson.id, 1)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
        ('خيار صحيح', true, q_id),
		('خيار خاطئ', false, q_id),
		('خيار خاطئ', false, q_id),
		('خيار خاطئ', false, q_id);

        -------------------------------------------
        -- Category 2: "أعطِ تفسيراً علمياً"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('فسّر تعد القطعة الأولية من المحوار مكان لانطلاق كمونات العمل؟ \n يعود ذلك لاحتوائها على كثافة عالية من قنوات التبويب الفولطية', lesson.id, 2)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
            ('يعود ذلك لاحتوائها على كثافة عالية من قنوات التبويب الفولطية', true, q_id);

        -------------------------------------------
        -- Category 3: "ماذا ينتج عن"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('ماذا ينتج عن وجود الثلمين الأمامي والخلفي في النخاع الشوكي؟ \n تبدو المادة البيضاء مقسومة إلى قسمين متناظرين', lesson.id, 3)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
            ('تبدو المادة البيضاء مقسومة إلى قسمين متناظرين', true, q_id);

        -------------------------------------------
        -- Category 4: "اذكر وظيفة"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('اذكر وظيفة خلايا C في الغدة الدرقية. \n تفرز هرمون الكالسيتونين (CT).', lesson.id, 4)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
            ('تفرز هرمون الكالسيتونين (CT).', true, q_id);

        -------------------------------------------
        -- Category 5: "حدّد موقع"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('حدّد موقع قنوات التبويب الفولطية في الألياف المغمدة بالنخاعين \n في اختناقات رانفييه', lesson.id, 5)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
            ('في اختناقات رانفييه', true, q_id);

        -------------------------------------------
        -- Category 6: "تعاريف"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('عرّف الطفرة \n تغير مفاجئ في بعض صفات الفرد مرتبط بالتبدل الوراثي', lesson.id, 6)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id) VALUES
            ('تغير مفاجئ في بعض صفات الفرد مرتبط بالتبدل الوراثي', true, q_id);

        -------------------------------------------
        -- Category 7: "رسمات"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id,image_url)
        VALUES 
		('1 لويحة عصبية , 2 طية عصبية , 3 وريقة جنينية خارجية , 4 وريقة جنينة وسطى , 5 وريقة جنينة داخلية , 6 معي بدائي', lesson.id, 7, 'images/naming-numbers.png')
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id,sort_order) VALUES
            ('1 - لويحة عصبية', true, q_id,1),
			('2 - طية عصبية', true, q_id,2),
			('3 - وريقة جنينية خارجية', true, q_id,3),
			('4 - وريقة جنينة وسطى', true, q_id,4),
			('5 - وريقة جنينة داخلية', true, q_id,5),
			('6 - معي بدائي', true, q_id,6);
			

        -------------------------------------------
        -- Category 8: "رتّب بدقة"
        -------------------------------------------
        INSERT INTO questions (content, lesson_id, category_id)
        VALUES ('رتّب بدقة', lesson.id, 8)
        RETURNING id INTO q_id;

        INSERT INTO question_options (content, is_correct, question_id,sort_order) VALUES
            ('1 - مرحلة اولى', true, q_id,0),
			('2 - مرحلة ثانية', true, q_id,1),
			('3 - مرحلة ثالثة', true, q_id,2),
			('4 - مرحلة رابعة', true, q_id,3);

    END LOOP;
END;
$$;





delete from question_options;
delete from question_answers;
delete from questions;









