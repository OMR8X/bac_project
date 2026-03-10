BEGIN TRANSACTION;

-- 1. Create a dummy group for Lesson 2 (id = 92)
INSERT INTO question_groups (id, name, lesson_id, display_order, is_favorite, answer_status)
VALUES (999992, 'Deep Fake Group', 92, 1, 0, 0);

-- 2. Copy the first 5 questions from Lesson 1 into Lesson 2's new group
INSERT INTO questions (
    question_text, choices, right_choice, is_edited, hint, hint_photo, uuid, 
    question_group_id, display_order, type_id, question_photo, note, 
    is_answered, user_answer, is_corrected, is_answered_correctly
)
SELECT 
    question_text, choices, right_choice, is_edited, hint, hint_photo, uuid || '_clone2', 
    999992, display_order, type_id, question_photo, note, 
    is_answered, user_answer, is_corrected, is_answered_correctly
FROM questions
WHERE question_group_id IN (
    SELECT id FROM question_groups WHERE lesson_id = 91
) 
LIMIT 5;

-- 3. We also need to map these 5 new questions to the 'tag' table
-- Create a temporary table to map old question IDs to new question IDs
CREATE TEMP TABLE temp_id_map AS
SELECT 
    old.id as old_id, 
    new.id as new_id
FROM questions old
JOIN questions new ON new.uuid = old.uuid || '_clone2'
WHERE old.question_group_id IN (SELECT id FROM question_groups WHERE lesson_id = 91);

-- Insert into question_tag for our cloned questions
INSERT INTO question_tag (tag_id, question_id)
SELECT qt.tag_id, m.new_id
FROM question_tag qt
JOIN temp_id_map m ON qt.question_id = m.old_id;

-- 4. Update the "subjects" tables to pretend it was just synced.
UPDATE subjects SET is_synced = 1, sync_at = datetime('now') WHERE id = 3;

COMMIT;
