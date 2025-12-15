-- Table: notifications
CREATE TYPE notification_priority AS ENUM ('low', 'normal', 'high');
CREATE TABLE notifications (
    id BIGSERIAL PRIMARY KEY,
	topic_id BIGINT NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    image_url TEXT,
	payload JSONB,
    priority notification_priority DEFAULT 'normal',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    FOREIGN KEY (topic_id) REFERENCES public.notification_topics(id) ON DELETE CASCADE
);

-- Table: user_topic_subscriptions
CREATE TABLE user_topic_subscriptions (
    user_id uuid not null references auth.users(id) on delete cascade,
    topic_id BIGINT NOT NULL,
    PRIMARY KEY (user_id, topic_id),
    FOREIGN KEY (topic_id) REFERENCES public.notification_topics(id) ON DELETE CASCADE
);

-- Table: user_notifications
CREATE TABLE user_notifications (
    id BIGSERIAL PRIMARY KEY,
    user_id uuid not null references auth.users(id) on delete cascade,
    notification_id BIGINT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW(),
    readed_at TIMESTAMPTZ NULL,
	FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE,
    FOREIGN KEY (notification_id) REFERENCES public.notifications(id) ON DELETE CASCADE,
    UNIQUE (user_id, notification_id)
);

