-- Table: lessons
CREATE TABLE public.lessons (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL,
    unit_id INTEGER NOT NULL,
    icon_url TEXT,
    sort_order INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (unit_id) REFERENCES public.units(id) ON DELETE CASCADE,
    UNIQUE (unit_id, title)
);

