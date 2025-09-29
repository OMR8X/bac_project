import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ar')];

  /// No description provided for @aiFeedbackLabel.
  ///
  /// In ar, this message translates to:
  /// **'ملاحظات التصحيح'**
  String get aiFeedbackLabel;

  /// No description provided for @answerEvaluationsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تصحيح الإجابات'**
  String get answerEvaluationsTitle;

  /// No description provided for @authEmail.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get authEmail;

  /// No description provided for @authPassword.
  ///
  /// In ar, this message translates to:
  /// **'الرمز السري'**
  String get authPassword;

  /// No description provided for @authSignIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get authSignIn;

  /// No description provided for @authSignUp.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء حساب'**
  String get authSignUp;

  /// No description provided for @buttonsClose.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق'**
  String get buttonsClose;

  /// No description provided for @buttonsConfirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get buttonsConfirm;

  /// No description provided for @buttonsCustomize.
  ///
  /// In ar, this message translates to:
  /// **'تخصيص'**
  String get buttonsCustomize;

  /// No description provided for @buttonsEditAnswer.
  ///
  /// In ar, this message translates to:
  /// **'تعديل الاجابة'**
  String get buttonsEditAnswer;

  /// No description provided for @buttonsFinish.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء'**
  String get buttonsFinish;

  /// No description provided for @buttonsManageNotificationTopics.
  ///
  /// In ar, this message translates to:
  /// **'ادارة الاشعارات'**
  String get buttonsManageNotificationTopics;

  /// No description provided for @buttonsNext.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get buttonsNext;

  /// No description provided for @buttonsPick.
  ///
  /// In ar, this message translates to:
  /// **'اختيار'**
  String get buttonsPick;

  /// No description provided for @buttonsPrevious.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get buttonsPrevious;

  /// No description provided for @buttonsResult.
  ///
  /// In ar, this message translates to:
  /// **'النتيجة'**
  String get buttonsResult;

  /// No description provided for @buttonsResultDetailsTab.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل النتيجة'**
  String get buttonsResultDetailsTab;

  /// No description provided for @buttonsResultLeaderboardTab.
  ///
  /// In ar, this message translates to:
  /// **'لوحة الصدارة'**
  String get buttonsResultLeaderboardTab;

  /// No description provided for @buttonsRetry.
  ///
  /// In ar, this message translates to:
  /// **'اعادة المحاولة'**
  String get buttonsRetry;

  /// No description provided for @buttonsRetryTest.
  ///
  /// In ar, this message translates to:
  /// **'اعادة الاختبار'**
  String get buttonsRetryTest;

  /// No description provided for @buttonsSave.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get buttonsSave;

  /// No description provided for @buttonsSignIn.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get buttonsSignIn;

  /// No description provided for @buttonsSignOut.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get buttonsSignOut;

  /// No description provided for @buttonsSignUp.
  ///
  /// In ar, this message translates to:
  /// **'انشاء حساب'**
  String get buttonsSignUp;

  /// No description provided for @buttonsSmartRetryTest.
  ///
  /// In ar, this message translates to:
  /// **'اعادة ذكية للأختبار'**
  String get buttonsSmartRetryTest;

  /// No description provided for @buttonsStartTest.
  ///
  /// In ar, this message translates to:
  /// **'بدء الأختبار'**
  String get buttonsStartTest;

  /// No description provided for @buttonsUpdateUserData.
  ///
  /// In ar, this message translates to:
  /// **'تحديث بياناتك'**
  String get buttonsUpdateUserData;

  /// No description provided for @closeQuizDialogBody.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من رغبتك في إغلاق الاختبار؟.'**
  String get closeQuizDialogBody;

  /// No description provided for @closeQuizDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'إغلاق الاختبار'**
  String get closeQuizDialogTitle;

  /// No description provided for @correctAnswerLabel.
  ///
  /// In ar, this message translates to:
  /// **'الإجابة الصحيحة'**
  String get correctAnswerLabel;

  /// No description provided for @correctionDetails.
  ///
  /// In ar, this message translates to:
  /// **'تفاصيل التصحيح'**
  String get correctionDetails;

  /// No description provided for @emptyStateSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'ستظهر العناصر هنا عند توفرها'**
  String get emptyStateSubtitle;

  /// No description provided for @emptyStateTitle.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد عناصر'**
  String get emptyStateTitle;

  /// No description provided for @enableSoundEffectsSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تشغيل مؤثرات صوتية عند الإجابة.'**
  String get enableSoundEffectsSubtitle;

  /// No description provided for @enableSoundEffectsTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الأصوات'**
  String get enableSoundEffectsTitle;

  /// No description provided for @errorAuth.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في المصادقة'**
  String get errorAuth;

  /// No description provided for @errorLoadingApp.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحميل التطبيق'**
  String get errorLoadingApp;

  /// No description provided for @errorLoadingResults.
  ///
  /// In ar, this message translates to:
  /// **'فشل في تحميل النتائج'**
  String get errorLoadingResults;

  /// No description provided for @exploreMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع التصفح'**
  String get exploreMode;

  /// No description provided for @exploreModeAdditionalFeaturesContent.
  ///
  /// In ar, this message translates to:
  /// **'• لا يتم تخزين النتيجة\n• مصمم للتدريب والتعلم دون ضغط\n'**
  String get exploreModeAdditionalFeaturesContent;

  /// No description provided for @exploreModeAdditionalFeaturesTitle.
  ///
  /// In ar, this message translates to:
  /// **'خصائص التدريب:'**
  String get exploreModeAdditionalFeaturesTitle;

  /// No description provided for @exploreModeDetailsContent.
  ///
  /// In ar, this message translates to:
  /// **'• تحكم كامل في إعدادات الاختبار (عدد الأسئلة، المواضيع)\n• حرية اختيار إظهار أو إخفاء الإجابات الصحيحة\n• لا يتم استخدام خوارزميات محددة في إنشاء الاختبار'**
  String get exploreModeDetailsContent;

  /// No description provided for @exploreModeDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلومات وضع التصفح'**
  String get exploreModeDetailsTitle;

  /// No description provided for @hintsTextualOptionHint.
  ///
  /// In ar, this message translates to:
  /// **'نص الاجابة'**
  String get hintsTextualOptionHint;

  /// No description provided for @homeCardExploreLessonsAction.
  ///
  /// In ar, this message translates to:
  /// **'استكشاف الدروس'**
  String get homeCardExploreLessonsAction;

  /// No description provided for @homeCardStartTestAction.
  ///
  /// In ar, this message translates to:
  /// **'بدء الاختبار الكامل'**
  String get homeCardStartTestAction;

  /// No description provided for @homeQuoteDailyQuote.
  ///
  /// In ar, this message translates to:
  /// **'اقتباس اليوم'**
  String get homeQuoteDailyQuote;

  /// No description provided for @homeQuoteExpandQuote.
  ///
  /// In ar, this message translates to:
  /// **'عرض الاقتباس مكبراً'**
  String get homeQuoteExpandQuote;

  /// No description provided for @homeTitle.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get homeTitle;

  /// No description provided for @labelsTextualOptionLabel.
  ///
  /// In ar, this message translates to:
  /// **'اجابتك'**
  String get labelsTextualOptionLabel;

  /// No description provided for @lessonsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الدروس'**
  String get lessonsTitle;

  /// No description provided for @navigationHome.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get navigationHome;

  /// No description provided for @navigationNotifications.
  ///
  /// In ar, this message translates to:
  /// **'الإشعارات'**
  String get navigationNotifications;

  /// No description provided for @navigationResults.
  ///
  /// In ar, this message translates to:
  /// **'نتائجي'**
  String get navigationResults;

  /// No description provided for @navigationSettings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get navigationSettings;

  /// No description provided for @notificationTopicsTitle.
  ///
  /// In ar, this message translates to:
  /// **'إدارة مواضيع الإشعارات'**
  String get notificationTopicsTitle;

  /// No description provided for @pickLessonsTitle.
  ///
  /// In ar, this message translates to:
  /// **'اختيار الدروس'**
  String get pickLessonsTitle;

  /// No description provided for @pickQuestionsCategoriesTitle.
  ///
  /// In ar, this message translates to:
  /// **'مواضيع الأسئلة'**
  String get pickQuestionsCategoriesTitle;

  /// No description provided for @pickQuestionsCountTitle.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأسئلة'**
  String get pickQuestionsCountTitle;

  /// No description provided for @resultCorrect.
  ///
  /// In ar, this message translates to:
  /// **'صحيح'**
  String get resultCorrect;

  /// No description provided for @resultRetryTestDialogBody.
  ///
  /// In ar, this message translates to:
  /// **'هل ترغب في إعادة الاختبار بنفس الأسئلة وخيارات الاختبار؟'**
  String get resultRetryTestDialogBody;

  /// No description provided for @resultRetryTestDialogTitle.
  ///
  /// In ar, this message translates to:
  /// **'إعادة الاختبار'**
  String get resultRetryTestDialogTitle;

  /// No description provided for @resultScore.
  ///
  /// In ar, this message translates to:
  /// **'الدرجة'**
  String get resultScore;

  /// No description provided for @resultsCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الاسئلة'**
  String get resultsCount;

  /// No description provided for @resultsTitle.
  ///
  /// In ar, this message translates to:
  /// **'نتائجي'**
  String get resultsTitle;

  /// No description provided for @resultTime.
  ///
  /// In ar, this message translates to:
  /// **'الوقت'**
  String get resultTime;

  /// No description provided for @resultTimeTaken.
  ///
  /// In ar, this message translates to:
  /// **'وقت الاختبار'**
  String get resultTimeTaken;

  /// No description provided for @resultTitle.
  ///
  /// In ar, this message translates to:
  /// **'نتيجتي'**
  String get resultTitle;

  /// No description provided for @resultUnanswered.
  ///
  /// In ar, this message translates to:
  /// **'بدون إجابة'**
  String get resultUnanswered;

  /// No description provided for @resultWrong.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get resultWrong;

  /// No description provided for @screenUpdateUserData.
  ///
  /// In ar, this message translates to:
  /// **'تحديث بيانات المتسخدم'**
  String get screenUpdateUserData;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'بحث...'**
  String get searchHint;

  /// No description provided for @searchNoResults.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد نتائج'**
  String get searchNoResults;

  /// No description provided for @searchTitle.
  ///
  /// In ar, this message translates to:
  /// **'البحث'**
  String get searchTitle;

  /// No description provided for @selectAll.
  ///
  /// In ar, this message translates to:
  /// **'تحديد الكل'**
  String get selectAll;

  /// No description provided for @settingsManageNotificationTopics.
  ///
  /// In ar, this message translates to:
  /// **'تحديث بياناتك'**
  String get settingsManageNotificationTopics;

  /// No description provided for @settingsTitle.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settingsTitle;

  /// No description provided for @showTrueAnswerSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'إظهار الإجابة الصحيحة بعد كل سؤال.'**
  String get showTrueAnswerSubtitle;

  /// No description provided for @showTrueAnswerTitle.
  ///
  /// In ar, this message translates to:
  /// **'عرض الإجابة الصحيحة'**
  String get showTrueAnswerTitle;

  /// No description provided for @testMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاختبار'**
  String get testMode;

  /// No description provided for @testModeAdditionalFeaturesContent.
  ///
  /// In ar, this message translates to:
  /// **'• إمكانية الوصول إلى لوحة الصدارة لمقارنة ترتيبك\n• استخدام نتائجك لاحقاً في ميزات التحليل الذكي والاختبارات المخصصة'**
  String get testModeAdditionalFeaturesContent;

  /// No description provided for @testModeAdditionalFeaturesTitle.
  ///
  /// In ar, this message translates to:
  /// **'المميزات الإضافية:'**
  String get testModeAdditionalFeaturesTitle;

  /// No description provided for @testModeDetailsContent.
  ///
  /// In ar, this message translates to:
  /// **'• اختبار مصمم تلقائياً بأسئلة منوعة ومختارة بعناية\n• لا يمكن تعديل إعدادات الاختبار (التصانيف، العدد، إلخ)\n• حفظ دائم للنتائج مع إمكانية إعادة نفس الاختبار'**
  String get testModeDetailsContent;

  /// No description provided for @testModeDetailsTitle.
  ///
  /// In ar, this message translates to:
  /// **'معلومات وضع الاختبار'**
  String get testModeDetailsTitle;

  /// No description provided for @testPropertiesModesCustomModeDescription.
  ///
  /// In ar, this message translates to:
  /// **'قم بتحديد اعدادات الاختبار وتخصيصها بالكامل'**
  String get testPropertiesModesCustomModeDescription;

  /// No description provided for @testPropertiesModesCustomModeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'تحكم بجميع الإعدادات'**
  String get testPropertiesModesCustomModeSubtitle;

  /// No description provided for @testPropertiesModesCustomModeTitle.
  ///
  /// In ar, this message translates to:
  /// **'وضع مخصص'**
  String get testPropertiesModesCustomModeTitle;

  /// No description provided for @testPropertiesModesExploreModeDescription.
  ///
  /// In ar, this message translates to:
  /// **'تدرب بدون ضغط الوقت. اطلع على الإجابات فوراً وتعلم من اخطائك.'**
  String get testPropertiesModesExploreModeDescription;

  /// No description provided for @testPropertiesModesExploreModeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'للتعلم والاستكشاف'**
  String get testPropertiesModesExploreModeSubtitle;

  /// No description provided for @testPropertiesModesExploreModeTitle.
  ///
  /// In ar, this message translates to:
  /// **'وضع التصفح'**
  String get testPropertiesModesExploreModeTitle;

  /// No description provided for @testPropertiesModesTestModeDescription.
  ///
  /// In ar, this message translates to:
  /// **'امتحان مؤقت مع تقييم ونتائج. مثالي لاختبار فهمك للموضوعات'**
  String get testPropertiesModesTestModeDescription;

  /// No description provided for @testPropertiesModesTestModeSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'اختبر نفسك'**
  String get testPropertiesModesTestModeSubtitle;

  /// No description provided for @testPropertiesModesTestModeTitle.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاختبار'**
  String get testPropertiesModesTestModeTitle;

  /// No description provided for @testPropertiesModeSwitcherExploreMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع التصفح'**
  String get testPropertiesModeSwitcherExploreMode;

  /// No description provided for @testPropertiesModeSwitcherTestMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع الاختبار'**
  String get testPropertiesModeSwitcherTestMode;

  /// No description provided for @testPropertiesModeSwitcherTitle.
  ///
  /// In ar, this message translates to:
  /// **'الوضع'**
  String get testPropertiesModeSwitcherTitle;

  /// No description provided for @testPropertiesQuestionsCategories.
  ///
  /// In ar, this message translates to:
  /// **'مواضيع الأسئلة'**
  String get testPropertiesQuestionsCategories;

  /// No description provided for @testPropertiesQuestionsCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الأسئلة'**
  String get testPropertiesQuestionsCount;

  /// No description provided for @testPropertiesTitle.
  ///
  /// In ar, this message translates to:
  /// **'اعدادات الاختبار'**
  String get testPropertiesTitle;

  /// No description provided for @unselectAll.
  ///
  /// In ar, this message translates to:
  /// **'الغاء التحديد'**
  String get unselectAll;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
