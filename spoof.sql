BEGIN TRANSACTION;
INSERT INTO question_groups (id, name, lesson_id, display_order, is_favorite, answer_status) 
VALUES (999991, 'Spoofed Group for Lesson 2', 92, 1, 0, 0);

INSERT INTO questions (question_text, choices, right_choice, is_edited, hint, hint_photo, uuid, question_group_id, display_order, type_id, question_photo, note, is_answered, user_answer, is_corrected, is_answered_correctly)
SELECT question_text, choices, right_choice, is_edited, hint, hint_photo, uuid || '_clone', 999991, display_order, type_id, question_photo, note, 0, NULL, 0, 0
FROM questions
WHERE question_group_id = (SELECT id FROM question_groups WHERE lesson_id=91 LIMIT 1);
COMMIT;
