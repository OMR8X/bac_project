-- Table: lessons
CREATE TABLE public.lessons (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL,
    unit_id INTEGER NOT NULL,
    icon TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    is_visible BOOLEAN DEFAULT true,
    FOREIGN KEY (unit_id) REFERENCES public.units(id)
);
