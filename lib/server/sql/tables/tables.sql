-- Start of Selection
CREATE TABLE public.categories (
    id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	title TEXT NOT NULL,

    sort_order INTEGER DEFAULT 0,
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

-- Table: governorates
CREATE TABLE public.governorates (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	title TEXT NOT NULL,

	sort_order INTEGER DEFAULT 0,
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

-- Table: sections
CREATE TABLE public.sections (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	title TEXT NOT NULL,

	sort_order INTEGER DEFAULT 0,
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

-- Table: units
CREATE TABLE public.units (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	title TEXT NOT NULL,
    subtitle TEXT NOT NULL,
    icon TEXT,

	sort_order INTEGER DEFAULT 0, 
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now()
);

-- Table: lessons
CREATE TABLE public.lessons (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	title TEXT NOT NULL,
    unit_id INTEGER NOT NULL,
    icon TEXT,
	
	sort_order INTEGER DEFAULT 0,
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    
	FOREIGN KEY (unit_id) REFERENCES public.units(id)
);

-- Table: questions
CREATE TABLE public.questions (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	text TEXT NOT NULL,
    lesson_id INTEGER NOT NULL,
    explain TEXT DEFAULT '',
    is_mcq BOOLEAN NOT NULL DEFAULT false,
    h_url TEXT,
    q_url TEXT,
	
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    
	FOREIGN KEY (lesson_id) REFERENCES public.lessons(id)
);

-- Table: options
CREATE TABLE public.options (
    
	id INTEGER PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    
	text TEXT NOT NULL,
    is_correct BOOLEAN DEFAULT false,
    question_id INTEGER NOT NULL,
	image_url TEXT,
    
    is_visible BOOLEAN DEFAULT true,
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
	
    FOREIGN KEY (question_id) REFERENCES public.questions(id)
);

-- Table: question_categories
CREATE TABLE public.question_categories (

    question_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
	
    is_visible BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
	
    PRIMARY KEY (question_id, category_id),
    FOREIGN KEY (question_id) REFERENCES public.questions(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE
);


-- Table: results
CREATE TABLE public.results (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,

    user_id UUID DEFAULT auth.uid(),
    lesson_id INTEGER NOT NULL,

    total_questions INTEGER NOT NULL,
    correct_answers INTEGER NOT NULL,
    wrong_answers INTEGER NOT NULL,
    score NUMERIC(5,2) NOT NULL,
    duration_seconds INTEGER NOT NULL,
		
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    
    FOREIGN KEY (lesson_id) REFERENCES public.lessons(id),
    FOREIGN KEY (user_id) REFERENCES auth.users(id)
);

CREATE TABLE public.result_question_answer (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
	
	result_id BIGINT NOT NULL,
	question_id INTEGER NOT NULL,
	option_id INTEGER NOT NULL,
	
	created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
    updated_at TIMESTAMP WITHOUT TIME ZONE DEFAULT now(),
	
    FOREIGN KEY (result_id) REFERENCES public.results(id) ON DELETE CASCADE,
    FOREIGN KEY (question_id) REFERENCES public.questions(id),
    FOREIGN KEY (option_id)   REFERENCES public.options(id),
    UNIQUE (result_id, question_id)
)
