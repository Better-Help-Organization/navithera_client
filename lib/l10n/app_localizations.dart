import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_en.dart';
import 'app_localizations_om.dart';
import 'app_localizations_so.dart';
import 'app_localizations_ti.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('en'),
    Locale('om'),
    Locale('so'),
    Locale('ti'),
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @manageAccount.
  ///
  /// In en, this message translates to:
  /// **'Manage Account'**
  String get manageAccount;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @updateProfile.
  ///
  /// In en, this message translates to:
  /// **'Update Profile'**
  String get updateProfile;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentId;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @identifyAs.
  ///
  /// In en, this message translates to:
  /// **'Identify As'**
  String get identifyAs;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @verifyStudentProfile.
  ///
  /// In en, this message translates to:
  /// **'Verify your student profile to gain access to special discounts on features and services'**
  String get verifyStudentProfile;

  /// No description provided for @youllEnjoyBenefits.
  ///
  /// In en, this message translates to:
  /// **'You\'ll enjoy benefits such as'**
  String get youllEnjoyBenefits;

  /// No description provided for @discountOffer.
  ///
  /// In en, this message translates to:
  /// **'Up to 50% discount on qualified sessions'**
  String get discountOffer;

  /// No description provided for @representationOpportunity.
  ///
  /// In en, this message translates to:
  /// **'An opportunity to represent Navithera in your chosen institutions'**
  String get representationOpportunity;

  /// No description provided for @applyNow.
  ///
  /// In en, this message translates to:
  /// **'Apply Now'**
  String get applyNow;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @diary.
  ///
  /// In en, this message translates to:
  /// **'Diary'**
  String get diary;

  /// No description provided for @breathExercise.
  ///
  /// In en, this message translates to:
  /// **'Breath Exercise'**
  String get breathExercise;

  /// No description provided for @meditate.
  ///
  /// In en, this message translates to:
  /// **'Meditate'**
  String get meditate;

  /// No description provided for @documentThoughts.
  ///
  /// In en, this message translates to:
  /// **'Document your thoughts securely'**
  String get documentThoughts;

  /// No description provided for @reduceAnxiety.
  ///
  /// In en, this message translates to:
  /// **'Reduce anxiety and panic attacks'**
  String get reduceAnxiety;

  /// No description provided for @guidedMeditation.
  ///
  /// In en, this message translates to:
  /// **'Guided meditation resources'**
  String get guidedMeditation;

  /// No description provided for @toolsResources.
  ///
  /// In en, this message translates to:
  /// **'Tools and resources'**
  String get toolsResources;

  /// No description provided for @noJournalEntries.
  ///
  /// In en, this message translates to:
  /// **'No journal entries yet'**
  String get noJournalEntries;

  /// No description provided for @addFirstEntry.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add your first entry'**
  String get addFirstEntry;

  /// No description provided for @myJournal.
  ///
  /// In en, this message translates to:
  /// **'My Journal'**
  String get myJournal;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter title'**
  String get enterTitle;

  /// No description provided for @letItPour.
  ///
  /// In en, this message translates to:
  /// **'Let it pour'**
  String get letItPour;

  /// No description provided for @todaysMusing.
  ///
  /// In en, this message translates to:
  /// **'Today\'s musing'**
  String get todaysMusing;

  /// No description provided for @saveNote.
  ///
  /// In en, this message translates to:
  /// **'Save note'**
  String get saveNote;

  /// No description provided for @guidedMeditationResources.
  ///
  /// In en, this message translates to:
  /// **'Guided meditation'**
  String get guidedMeditationResources;

  /// No description provided for @curatedSounds.
  ///
  /// In en, this message translates to:
  /// **'Select from our list of curated sounds for you'**
  String get curatedSounds;

  /// No description provided for @myClients.
  ///
  /// In en, this message translates to:
  /// **'My Clients'**
  String get myClients;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get goodEvening;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodNight.
  ///
  /// In en, this message translates to:
  /// **'Good Night'**
  String get goodNight;

  /// No description provided for @howAreYouFeeling.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today'**
  String get howAreYouFeeling;

  /// No description provided for @tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get tired;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @areYouSureLogout.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout'**
  String get areYouSureLogout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve missed you, kindly punch in your details'**
  String get welcomeMessage;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get you started with quality mental health support'**
  String get getStarted;

  /// No description provided for @termsAgreement.
  ///
  /// In en, this message translates to:
  /// **'By creating an account, you confirm you agree to the Navithera'**
  String get termsAgreement;

  /// No description provided for @termsAndPrivacy.
  ///
  /// In en, this message translates to:
  /// **' Terms of Use and Privacy Policy'**
  String get termsAndPrivacy;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAccount;

  /// No description provided for @youDeserveToFeelBetter.
  ///
  /// In en, this message translates to:
  /// **'You deserve to feel better'**
  String get youDeserveToFeelBetter;

  /// No description provided for @carrySomethingMessage.
  ///
  /// In en, this message translates to:
  /// **'Healing isn’t a luxury—it’s your right. You deserve support that helps you feel whole again.'**
  String get carrySomethingMessage;

  /// No description provided for @talkHealGrow.
  ///
  /// In en, this message translates to:
  /// **'Talk. Heal. Grow.'**
  String get talkHealGrow;

  /// No description provided for @guidedSessionsDescription.
  ///
  /// In en, this message translates to:
  /// **'In small, guided sessions, you’ll be heard, supported, and empowered to move forward.'**
  String get guidedSessionsDescription;

  /// No description provided for @yourJourneyStartsNow.
  ///
  /// In en, this message translates to:
  /// **'let\'s do this - for you'**
  String get yourJourneyStartsNow;

  /// No description provided for @healingJourneyDescription.
  ///
  /// In en, this message translates to:
  /// **'Whatever you’re carrying, you don’t have to carry it alone. This is where support begins.'**
  String get healingJourneyDescription;

  /// No description provided for @getStarted2.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get getStarted2;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @selfEsteemQuote.
  ///
  /// In en, this message translates to:
  /// **'Self-esteem is as important to our well-being as legs are to a table. It is essential for physical for happiness.'**
  String get selfEsteemQuote;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @callUs.
  ///
  /// In en, this message translates to:
  /// **'Call Us'**
  String get callUs;

  /// No description provided for @myCounslor.
  ///
  /// In en, this message translates to:
  /// **'My Therapist'**
  String get myCounslor;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @giftTherapy.
  ///
  /// In en, this message translates to:
  /// **'Gift Therapy'**
  String get giftTherapy;

  /// No description provided for @xnew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get xnew;

  /// No description provided for @livechatSupport.
  ///
  /// In en, this message translates to:
  /// **'Livechat Support'**
  String get livechatSupport;

  /// No description provided for @emailUs.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get emailUs;

  /// No description provided for @feedbackAndBugReports.
  ///
  /// In en, this message translates to:
  /// **'Feedback and Bug Reports'**
  String get feedbackAndBugReports;

  /// No description provided for @neutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutral;

  /// No description provided for @joinNavithera.
  ///
  /// In en, this message translates to:
  /// **'Join Navithera — Empower Change'**
  String get joinNavithera;

  /// No description provided for @connectWithClients.
  ///
  /// In en, this message translates to:
  /// **'Connect with clients seeking your expertise and make a real impact.'**
  String get connectWithClients;

  /// No description provided for @workSmarter.
  ///
  /// In en, this message translates to:
  /// **'Work Smarter, Not Harder'**
  String get workSmarter;

  /// No description provided for @setYourHours.
  ///
  /// In en, this message translates to:
  /// **'Set your own hours, connect easily with clients, and focus on what you do best.'**
  String get setYourHours;

  /// No description provided for @supportedByAI.
  ///
  /// In en, this message translates to:
  /// **'Supported by AI, Driven by You'**
  String get supportedByAI;

  /// No description provided for @leverageSmartTools.
  ///
  /// In en, this message translates to:
  /// **'Leverage smart tools to enhance therapy sessions and deliver personalized care.'**
  String get leverageSmartTools;

  /// No description provided for @yourTherapist.
  ///
  /// In en, this message translates to:
  /// **'Your Therapist  '**
  String get yourTherapist;
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
      <String>['am', 'en', 'om', 'so', 'ti'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'en':
      return AppLocalizationsEn();
    case 'om':
      return AppLocalizationsOm();
    case 'so':
      return AppLocalizationsSo();
    case 'ti':
      return AppLocalizationsTi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
