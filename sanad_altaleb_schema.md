# Sanad Al-Taleb (V4) Database Schema

The SQLite database (`sanad_altalebV4.db`) contains the local curriculum data and basic user profile information for the Sanad Al-Taleb application. Below is the complete schema definition and an explanation of the key tables.

## 1. User & Account Data

### `student`
This table stores the locally cached profile of the signed-in user.
```sql
CREATE TABLE student (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    father_name TEXT NOT NULL,
    school TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    password TEXT NOT NULL,
    type_id INTEGER NOT NULL,
    city INTEGER NOT NULL,
    FOREIGN KEY (type_id) REFERENCES certificates (id) ON DELETE CASCADE
);
```

### `certificates` & `subject_certificate`
These tables link the student's academic level (e.g., Baccalaureate) to the subjects they are studying.
```sql
CREATE TABLE certificates (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

CREATE TABLE subject_certificate (
    certificate_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    FOREIGN KEY (certificate_id) REFERENCES certificates (id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
);
```

---

## 2. Curriculum Header (Subjects & Lessons)

### `subjects` 
This is the core table defining all the subjects (e.g., Biology, Math). The `is_locked` and `expires_at` columns likely drive the "subscription required" UI logic.
```sql
CREATE TABLE subjects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    link TEXT,
    sync_at TEXT,
    is_locked INTEGER NOT NULL,            -- 0 = Unlocked, 1 = Locked (Subscription needed)
    number_of_lessons INTEGER NOT NULL,
    number_of_tags INTEGER NOT NULL,
    number_of_exams INTEGER NOT NULL,
    number_of_questions INTEGER NOT NULL,
    description TEXT NOT NULL,
    teacher TEXT,
    icon TEXT,
    icon_photo TEXT,
    downloaded_icon_photo BLOB,
    is_synced INTEGER DEFAULT 0,
    light_color_code TEXT,
    dark_color_code TEXT,
    expires_at TEXT,                       -- The expiration date for the subscription access
    display_order INTEGER
);
```

### `lessons`
Individual chapters or modules under a Subject.
```sql
CREATE TABLE lessons(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title TEXT,
    subject_id INTEGER NOT NULL,
    display_order INTEGER,
    FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
);
```

---

## 3. Question Bank Core

### `question_groups`
Groups questions together (often inside a single lesson or exam block). Also tracks progress (`answer_status`, `is_favorite`).
```sql
CREATE TABLE question_groups (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    lesson_id INTEGER NOT NULL,
    display_order INTEGER,
    is_favorite INTEGER,
    answer_status INTEGER,
    FOREIGN KEY (lesson_id) REFERENCES lessons(id) ON DELETE CASCADE
);
```

### `questions`
Contains the actual question data, multiple choices, and the correct answer index. It also tracks the user's progress for each individual question (`is_answered`, `user_answer`, `is_answered_correctly`).
```sql
CREATE TABLE questions (
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    question_text TEXT, 
    choices TEXT,                          -- Usually a JSON array of choices
    right_choice INTEGER,                  -- The index of the correct answer
    is_edited INTEGER, 
    hint TEXT, 
    hint_photo TEXT,
    uuid TEXT,
    question_group_id INTEGER NOT NULL,
    display_order INTEGER,
    type_id INTEGER NOT NULL,
    question_photo TEXT,
    note TEXT,
    is_answered INTEGER,
    user_answer INTEGER,                   -- What the user selected
    is_corrected INTEGER,
    is_answered_correctly INTEGER,         -- 1 = True, 0 = False
    downloaded_hint_photo BLOB,
    downloaded_question_photo BLOB,
    FOREIGN KEY (question_group_id) REFERENCES question_groups(id) ON DELETE CASCADE,
    FOREIGN KEY (type_id) REFERENCES types (id) ON DELETE CASCADE
);
```

### `types`
Defines what type of a question it is (e.g., Multiple Choice, True/False).
```sql
CREATE TABLE types (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    type TEXT NOT NULL
);
```

---

## 4. Tagging & Categorization

### `tag` & `question_tag`
Allows categorizing questions (e.g., "Hard", "Previous Exam Year").
```sql
CREATE TABLE tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    is_exam INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    display_order INTEGER,
    FOREIGN KEY (subject_id) REFERENCES subjects (id) ON DELETE CASCADE
);

CREATE TABLE question_tag (
    tag_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,
    FOREIGN KEY (tag_id) REFERENCES tag (id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES questions (id) ON DELETE CASCADE
);
```

---

## Potential Reason for "Subscription Required"
While we changed `is_locked = 0` in the `subjects` table, the `expires_at` column in that same table is currently completely empty (`NULL`) for all subjects. The Flutter application logic likely looks at the `expires_at` timestamp—if it has passed or is null, it overrides the `is_locked` variable and still demands a subscription renewal.
