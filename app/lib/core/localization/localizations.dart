import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_de.dart';
import 'localizations_en.dart';
import 'localizations_es.dart';
import 'localizations_fr.dart';
import 'localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L10n
/// returned by `L10n.of(context)`.
///
/// Applications need to include `L10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L10n.localizationsDelegates,
///   supportedLocales: L10n.supportedLocales,
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
/// be consistent with the languages listed in the L10n.supportedLocales
/// property.
abstract class L10n {
  L10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L10n of(BuildContext context) {
    return Localizations.of<L10n>(context, L10n)!;
  }

  static const LocalizationsDelegate<L10n> delegate = _L10nDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('tr')
  ];

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language;

  /// No description provided for @countryFlag.
  ///
  /// In en, this message translates to:
  /// **'🇬🇧/🇺🇸'**
  String get countryFlag;

  /// No description provided for @welcomeToPleaseHireTolga.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Please Hire Tolga 🙌'**
  String get welcomeToPleaseHireTolga;

  /// No description provided for @tapOnScanQrCodeToLogin.
  ///
  /// In en, this message translates to:
  /// **'Tap on the QR code to scan and login.'**
  String get tapOnScanQrCodeToLogin;

  /// No description provided for @youWillBeAutomaticallyLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You will be automatically logged in.'**
  String get youWillBeAutomaticallyLoggedIn;

  /// No description provided for @youNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'You need help?'**
  String get youNeedHelp;

  /// No description provided for @clickHere.
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get clickHere;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @oopsSomethingWentWrongPleaseTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Oops 😅, something went wrong. Please try again'**
  String get oopsSomethingWentWrongPleaseTryAgain;

  /// No description provided for @dontWantLoginViaQrCode.
  ///
  /// In en, this message translates to:
  /// **'Don\'t want to login via QR code?'**
  String get dontWantLoginViaQrCode;

  /// No description provided for @wantToLoginViaQrCode.
  ///
  /// In en, this message translates to:
  /// **'Want to login via QR code?'**
  String get wantToLoginViaQrCode;

  /// No description provided for @enterYourLoginInformation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your login information that I sent you.'**
  String get enterYourLoginInformation;

  /// No description provided for @aboutMe.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get aboutMe;

  /// No description provided for @cv.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get cv;

  /// No description provided for @coverLetter.
  ///
  /// In en, this message translates to:
  /// **'Cover letter'**
  String get coverLetter;

  /// No description provided for @inviteQuestion.
  ///
  /// In en, this message translates to:
  /// **'Invite?'**
  String get inviteQuestion;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get deleteAccount;

  /// No description provided for @signOutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutDialogTitle;

  /// No description provided for @signOutDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You can sign out and delete your account or just sign out.\n\nIf you delete your account, all your data will be deleted and you won\'t be able to log in again. \n\nIf you just sign out, your data will be kept and you can log in again later.'**
  String get signOutDialogContent;

  /// No description provided for @applicationToCompany.
  ///
  /// In en, this message translates to:
  /// **'Application to {company}'**
  String applicationToCompany(Object company);

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get changeLanguage;

  /// No description provided for @mySkills.
  ///
  /// In en, this message translates to:
  /// **'My skills'**
  String get mySkills;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @letsConnect.
  ///
  /// In en, this message translates to:
  /// **'Let\'s connect'**
  String get letsConnect;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Ausbildung'**
  String get education;

  /// No description provided for @jobExperience.
  ///
  /// In en, this message translates to:
  /// **'Berufserfahrung'**
  String get jobExperience;

  /// No description provided for @sideJobs.
  ///
  /// In en, this message translates to:
  /// **'Side jobs'**
  String get sideJobs;

  /// No description provided for @languates.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languates;

  /// No description provided for @personalData.
  ///
  /// In en, this message translates to:
  /// **'Personal data'**
  String get personalData;

  /// No description provided for @drivingLicenseClasses.
  ///
  /// In en, this message translates to:
  /// **'Driving license classes'**
  String get drivingLicenseClasses;

  /// No description provided for @bornPlace.
  ///
  /// In en, this message translates to:
  /// **'Place of birth'**
  String get bornPlace;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birthDate;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'present'**
  String get present;

  /// No description provided for @noDegree.
  ///
  /// In en, this message translates to:
  /// **'No degree'**
  String get noDegree;

  /// No description provided for @programmingLanguages.
  ///
  /// In en, this message translates to:
  /// **'Programming languages'**
  String get programmingLanguages;

  /// No description provided for @disability.
  ///
  /// In en, this message translates to:
  /// **'Disability'**
  String get disability;

  /// No description provided for @showCopyOfDisabilityCard.
  ///
  /// In en, this message translates to:
  /// **'Show copy of disability card'**
  String get showCopyOfDisabilityCard;

  /// No description provided for @invite.
  ///
  /// In en, this message translates to:
  /// **'Invite'**
  String get invite;

  /// No description provided for @refuse.
  ///
  /// In en, this message translates to:
  /// **'Refuse'**
  String get refuse;

  /// No description provided for @inviteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Thanks for the invite and the time!'**
  String get inviteDialogTitle;

  /// No description provided for @inviteDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You have decided to have a conversation with me. I\'m very happy about that! Do you want to choose a date and time directly or do you want to send it to me separately by email? I will be informed about your decision. You can change your mind at any time.'**
  String get inviteDialogContent;

  /// No description provided for @refuseDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Really a pity, but still thanks for your time!'**
  String get refuseDialogTitle;

  /// No description provided for @refuseDialogContent.
  ///
  /// In en, this message translates to:
  /// **'You have decided against a conversation with me. I will be informed about your decision. You can change your mind at any time.'**
  String get refuseDialogContent;

  /// No description provided for @inviteWithoutPickingDate.
  ///
  /// In en, this message translates to:
  /// **'Invite without picking a date'**
  String get inviteWithoutPickingDate;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick date'**
  String get pickDate;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @inviteIsSent.
  ///
  /// In en, this message translates to:
  /// **'Invite is sent'**
  String get inviteIsSent;

  /// No description provided for @inviteIsSentContent.
  ///
  /// In en, this message translates to:
  /// **'The invite has been successfully sent:'**
  String get inviteIsSentContent;

  /// No description provided for @mobileSwipeHeadline.
  ///
  /// In en, this message translates to:
  /// **'Make your choice with a swipe'**
  String get mobileSwipeHeadline;

  /// No description provided for @mobileSwipeInstruction.
  ///
  /// In en, this message translates to:
  /// **'Swipe left to refuse or right to invite.'**
  String get mobileSwipeInstruction;

  /// No description provided for @webButtonHeadline.
  ///
  /// In en, this message translates to:
  /// **'Make your choice with a click'**
  String get webButtonHeadline;

  /// No description provided for @webButtonInstruction.
  ///
  /// In en, this message translates to:
  /// **'Click the right button for invitation or refusal'**
  String get webButtonInstruction;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @invited.
  ///
  /// In en, this message translates to:
  /// **'Invited'**
  String get invited;

  /// No description provided for @inviteExplanationHint.
  ///
  /// In en, this message translates to:
  /// **'Add an optional message...'**
  String get inviteExplanationHint;

  /// No description provided for @refuseExplanationHint.
  ///
  /// In en, this message translates to:
  /// **'Reason for refusal (optional)...'**
  String get refuseExplanationHint;

  /// No description provided for @reasonForRejection.
  ///
  /// In en, this message translates to:
  /// **'Reason for rejection'**
  String get reasonForRejection;

  /// No description provided for @message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get message;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get appointment;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @responseOfApplicant.
  ///
  /// In en, this message translates to:
  /// **'Response of the applicant'**
  String get responseOfApplicant;

  /// No description provided for @applicantAccepted.
  ///
  /// In en, this message translates to:
  /// **'Applicant accepted'**
  String get applicantAccepted;

  /// No description provided for @applicantRefused.
  ///
  /// In en, this message translates to:
  /// **'Applicant refused'**
  String get applicantRefused;

  /// No description provided for @applicantDidNotRespondYet.
  ///
  /// In en, this message translates to:
  /// **'Applicant has not responded yet'**
  String get applicantDidNotRespondYet;

  /// No description provided for @revoke.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get revoke;

  /// No description provided for @revokeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Revoke invitation?'**
  String get revokeDialogTitle;

  /// No description provided for @revokeDialogContent.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to revoke your decision? The applicant will be informed about it.'**
  String get revokeDialogContent;

  /// No description provided for @durationFormatted.
  ///
  /// In en, this message translates to:
  /// **'{hours} h {minutes} min'**
  String durationFormatted(int hours, int minutes);

  /// No description provided for @durationFormattedMinutesOnly.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String durationFormattedMinutesOnly(Object minutes);
}

class _L10nDelegate extends LocalizationsDelegate<L10n> {
  const _L10nDelegate();

  @override
  Future<L10n> load(Locale locale) {
    return SynchronousFuture<L10n>(lookupL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['de', 'en', 'es', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_L10nDelegate old) => false;
}

L10n lookupL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de': return L10nDe();
    case 'en': return L10nEn();
    case 'es': return L10nEs();
    case 'fr': return L10nFr();
    case 'tr': return L10nTr();
  }

  throw FlutterError(
    'L10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
