-- Table: device_tokens
CREATE TABLE public.user_device_tokens (
    id BIGSERIAL PRIMARY KEY,
	user_id uuid not null references auth.users(id) on delete cascade,
    device_brand TEXT NOT NULL,
    device_model TEXT NOT NULL,
    device_token TEXT NOT NULL,
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    created_at TIMESTAMPTZ DEFAULT NOW(),
    FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE,
	CONSTRAINT uq_user_device_token UNIQUE (user_id, device_token)
);

