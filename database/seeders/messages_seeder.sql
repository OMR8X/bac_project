-- Messages seeder for API response messages
-- This seeder populates the messages table with all API response messages

-- Delete existing data first
DELETE FROM messages;

-- Insert success messages
INSERT INTO messages (key, message) VALUES
('device_token_registered', 'تم تسجيل رمز الجهاز بنجاح'),
('notifications_marked_read', 'تم تعليم الإشعارات كمقروءة بنجاح'),
('topic_subscribed', 'تم الاشتراك في الموضوع بنجاح'),
('topic_unsubscribed', 'تم إلغاء الاشتراك من الموضوع بنجاح'),
('motivational_notification_sent', 'تم إرسال الإشعار التحفيزي بنجاح'),
('user_notifications_retrieved', 'تم استرجاع إشعارات المستخدم بنجاح'),
('units_retrieved', 'تم استرجاع الوحدات بنجاح'),
('answer_evaluations_retrieved', 'تم استرجاع تقييمات الإجابات بنجاح'),
('app_settings_retrieved', 'تم استرجاع إعدادات التطبيق بنجاح'),
('questions_retrieved', 'تم استرجاع الأسئلة بنجاح'),
('user_subscribed_topics_retrieved', 'تم استرجاع مواضيع اشتراك المستخدم بنجاح'),
('notification_topics_retrieved', 'تم استرجاع مواضيع الإشعارات بنجاح'),
('test_options_retrieved', 'تم استرجاع خيارات الاختبار بنجاح'),
('lessons_retrieved', 'تم استرجاع الدروس بنجاح'),
('user_results_retrieved', 'تم استرجاع نتائج المستخدم بنجاح'),
('results_leaderboard_retrieved', 'تم استرجاع لوحة الصدارة للنتائج بنجاح'),
('result_fetched', 'تم استرجاع النتيجة بنجاح'),
('result_questions_details_retrieved', 'تم استرجاع تفاصيل أسئلة النتيجة بنجاح'),
('notification_links_created', 'تم إنشاء روابط الإشعار بنجاح'),

-- Insert error messages
('invalid_parameters', 'المعاملات المقدمة غير صالحة'),
('unauthorized_access', 'وصول غير مصرح به'),
('record_not_found', 'السجل غير موجود'),
('notification_not_found', 'الإشعار غير موجود'),
('topic_not_found', 'الموضوع غير موجود'),
('cannot_provide_both_user_ids_and_topic_id', 'لا يمكن تقديم كل من user_ids و topic_id. اختر طريقة واحدة.'),
('must_provide_user_ids_or_topic_id', 'يجب تقديم إما user_ids أو topic_id'),
('some_user_ids_do_not_exist', 'بعض معرفات المستخدمين المقدمة غير موجودة'),
('failed_to_send_motivational_notification', 'فشل في إرسال الإشعار التحفيزي'),
('exception_sending_motivational_notification', 'حدث استثناء أثناء إرسال الإشعار التحفيزي');
