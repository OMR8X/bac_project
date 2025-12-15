-- Table: units
CREATE TABLE public.units (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    icon_url TEXT,
    sort_order INTEGER DEFAULT 0, 
	created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    CONSTRAINT unique_unit_title UNIQUE (title)
);

