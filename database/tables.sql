-- Table: sections
CREATE TABLE public.sections (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL,
	created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: governorates
CREATE TABLE public.governorates (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL,
	created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table: question_categories
CREATE TABLE public.question_categories (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title TEXT NOT NULL UNIQUE,
    sort_order INTEGER DEFAULT 0,
	
	is_orderable BOOLEAN NOT NULL DEFAULT FALSE,
	is_typeable BOOLEAN NOT NULL DEFAULT FALSE,
	is_mcq BOOLEAN NOT NULL DEFAULT FALSE,
	is_single_answer BOOLEAN NOT NULL DEFAULT FALSE,
	
	created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW()
);


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

-- Table: questions
CREATE TABLE public.questions (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    content TEXT NOT NULL,
    image_url TEXT DEFAULT NULL,
    lesson_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (lesson_id) REFERENCES public.lessons(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES public.question_categories(id) ON DELETE CASCADE
);

-- Table: question_options
CREATE TABLE public.question_options (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    content TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT false,
    sort_order INTEGER NULL,
    question_id INTEGER NOT NULL,
    image_url TEXT,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE
);


-- Table: results
CREATE TABLE public.results (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id UUID NOT NULL,
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

-- Table: question_answers
CREATE TABLE public.question_answers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    result_id BIGINT NOT NULL,
    question_id INTEGER NOT NULL,
    option_id INTEGER NULL,          
    answer_text TEXT NULL,           
    answer_position INTEGER NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (result_id) REFERENCES public.results(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE RESTRICT,
    FOREIGN KEY (option_id) REFERENCES public.question_options(id) ON DELETE SET NULL
);

drop table question_answers;
drop table results;
drop table question_options;
drop table questions;
drop table lessons;
drop table units;
drop table sections;
drop table governorates;
drop table question_categories;
