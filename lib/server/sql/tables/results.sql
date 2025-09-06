-- Table: results
CREATE TABLE public.results (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id UUID DEFAULT auth.uid(),
    lesson_id INTEGER,
    questions_ids INTEGER[],
    total_questions INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    score NUMERIC NOT NULL,
    duration_seconds INTEGER NOT NULL,
    answers JSONB NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    is_visible BOOLEAN DEFAULT true,
    skipped_answers INTEGER DEFAULT 0,
    FOREIGN KEY (lesson_id) REFERENCES public.lessons(id),
    FOREIGN KEY (user_id) REFERENCES auth.users(id)
);
