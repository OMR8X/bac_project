-- Table: notification_topics
CREATE TABLE notification_topics (
    id BIGSERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL UNIQUE, -- display title in Arabic (e.g., 'تحديثات', 'محتوى', 'رؤى')
    description TEXT,                  -- optional description (in Arabic)
    firebase_topic VARCHAR(50) UNIQUE, -- English identifier for Firebase topic subscription (e.g., 'updates', 'content', 'insights')
    subscribable BOOLEAN NOT NULL DEFAULT TRUE  -- whether users can subscribe/unsubscribe to this topic
);

