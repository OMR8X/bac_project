-- Comprehensive seeder for notifications system
-- This includes notification types, topics, and sample notifications

-- Delete existing data first
DELETE FROM user_notifications;
DELETE FROM notifications;
DELETE FROM notification_topics;

-- Insert notification topics with explicit IDs
INSERT INTO notification_topics (id, title, description, firebase_topic, subscribable) VALUES
(1, 'تحديثات', 'تحديثات التطبيق والميزات الجديدة وإصدارات الإصدارات', 'updates', TRUE),
(2, 'محتوى', 'المحتوى الجديد والدروس والمواد التعليمية', 'content', TRUE),
(3, 'رؤى', 'التحليلات الشخصية ورؤى الأداء وتوصيات الدراسة', 'insights', TRUE),
(4, 'نظام', 'صيانة النظام وتحديثات الأمان والإعلانات المهمة', 'system', FALSE),
(5, 'إنجازات', 'الشارات والمعالم واحتفالات التقدم', 'achievements', TRUE),
(6, 'ملاحظات', 'استطلاعات الرأي وطلبات تعليقات المستخدمين واقتراحات التحسين', 'feedback', TRUE);

-- Insert sample notifications for testing with Arabic content (one per topic)
INSERT INTO notifications (id, topic_id, title, body, image_url, priority, created_at, expires_at) VALUES
-- Welcome notification (topic: updates)
(1, 1, 'مرحباً بك في مشروع البكالوريا!', 'مرحباً برحلتك التعليمية المخصصة. دعنا نبدأ في استكشاف الميزات الرائعة!', 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8c3R1ZHl8ZW58MHx8MHx8fDA%3D', 'high', CURRENT_TIMESTAMP, NULL),

-- New content available (topic: content)
(2, 2, 'محتوى جديد متاح', 'تم إضافة دروس جديدة في مادة الرياضيات. ابدأ التعلم الآن!', 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8c3R1ZHl8ZW58MHx8MHx8fDA%3D', 'normal', CURRENT_TIMESTAMP - INTERVAL '1 day', NULL),

-- Performance insights (topic: insights)
(3, 3, 'تحليل أدائك الأسبوعي', 'في هذا الأسبوع، أظهرت ضعفاً في أسئلة الجبر. ركز على مراجعة هذا الموضوع!', NULL, 'normal', CURRENT_TIMESTAMP - INTERVAL '2 days', NULL),

-- System maintenance (topic: system)
(4, 4, 'صيانة مجدولة للنظام', 'سيتم إجراء صيانة للنظام الليلة من الساعة 2 إلى 4 صباحاً. قد تواجه بعض التأخيرات.', NULL, 'high', CURRENT_TIMESTAMP - INTERVAL '6 hours', NULL),

-- Achievement unlocked (topic: achievements)
(5, 5, 'تهانينا! إنجاز جديد', 'لقد أكملت درسك الأول بنجاح! استمر في رحلتك التعليمية الممتازة.', 'https://example.com/images/achievement.png', 'normal', CURRENT_TIMESTAMP - INTERVAL '1 day', NULL),

-- Feedback request (topic: feedback)
(6, 6, 'شاركنا رأيك في التطبيق', 'نسعى دائماً لتحسين تجربتك. هل يمكنك تخصيص دقيقة لإكمال استطلاع الرأي؟', 'https://images.unsplash.com/photo-1471107191679-f26174d2d41e?q=80&w=1673&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'low', CURRENT_TIMESTAMP - INTERVAL '3 days', CURRENT_TIMESTAMP + INTERVAL '7 days');

-- Insert user notifications with the same user ID (one per topic)
INSERT INTO user_notifications (user_id, notification_id, delivered_at, read_at, dismissed_at, action_performed) VALUES
('25d773be-bb7c-4270-a94d-9767931ec085', 1, CURRENT_TIMESTAMP - INTERVAL '5 minutes', CURRENT_TIMESTAMP - INTERVAL '3 minutes', NULL, TRUE),  -- Welcome (updates) - Read and action performed
('25d773be-bb7c-4270-a94d-9767931ec085', 2, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '6 hours', NULL, FALSE),  -- New content (content) - Read but no action
('25d773be-bb7c-4270-a94d-9767931ec085', 3, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_TIMESTAMP - INTERVAL '1 day', NULL, FALSE),  -- Performance insights (insights) - Read but no action
('25d773be-bb7c-4270-a94d-9767931ec085', 4, CURRENT_TIMESTAMP - INTERVAL '6 hours', CURRENT_TIMESTAMP - INTERVAL '5 hours', NULL, TRUE),  -- System maintenance (system) - Read and action performed
('25d773be-bb7c-4270-a94d-9767931ec085', 5, CURRENT_TIMESTAMP - INTERVAL '1 day', CURRENT_TIMESTAMP - INTERVAL '12 hours', NULL, TRUE),  -- Achievement (achievements) - Read and action performed
('25d773be-bb7c-4270-a94d-9767931ec085', 6, CURRENT_TIMESTAMP - INTERVAL '3 days', NULL, NULL, FALSE);  -- Feedback request (feedback) - Delivered but not read