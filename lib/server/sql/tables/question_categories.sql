-- Table: question_categories
CREATE TABLE public.question_categories (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    question_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    FOREIGN KEY (question_id) REFERENCES public.questions(id),
    FOREIGN KEY (category_id) REFERENCES public.categories(id)
);
