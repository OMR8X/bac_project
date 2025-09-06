-- Table: options
CREATE TABLE public.options (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT false,
    question_id INTEGER NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    image_url TEXT,
    FOREIGN KEY (question_id) REFERENCES public.questions(id)
);
