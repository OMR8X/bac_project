-- Table: results
CREATE TABLE public.results (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id uuid not null references auth.users(id) on delete cascade,
    lesson_id INTEGER NULL,
    total_questions INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    score NUMERIC(5,2) NOT NULL,
    duration_seconds INTEGER NOT NULL,
    is_test_mode BOOLEAN NOT NULL DEFAULT false,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE
);

