// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'English';

  @override
  String get countryFlag => '🇬🇧/🇺🇸';

  @override
  String get welcomeToPleaseHireTolga => 'Welcome to Please Hire Tolga 🙌';

  @override
  String get tapOnScanQrCodeToLogin => 'Tap on the QR code to scan and login.';

  @override
  String get youWillBeAutomaticallyLoggedIn => 'You will be automatically logged in.';

  @override
  String get youNeedHelp => 'You need help?';

  @override
  String get clickHere => 'Click here';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get oopsSomethingWentWrongPleaseTryAgain => 'Oops 😅, something went wrong. Please try again';

  @override
  String get dontWantLoginViaQrCode => 'Don\'t want to login via QR code?';

  @override
  String get wantToLoginViaQrCode => 'Want to login via QR code?';

  @override
  String get enterYourLoginInformation => 'Please enter your login information that I sent you.';

  @override
  String get aboutMe => 'About me';

  @override
  String get cv => 'CV';

  @override
  String get coverLetter => 'Cover letter';

  @override
  String get inviteQuestion => 'Invite?';

  @override
  String get signOut => 'Sign out';

  @override
  String get cancel => 'Cancel';

  @override
  String get deleteAccount => 'Delete account?';

  @override
  String get signOutDialogTitle => 'Sign out';

  @override
  String get signOutDialogContent => 'You can either sign out or permanently delete your account.\n\nDeleting your account will erase all your data and you won’t be able to sign in again.\n\nIf you only sign out, your data will be kept and you can sign in again later.';

  @override
  String applicationToCompany(Object company) {
    return 'Application to $company';
  }

  @override
  String get changeLanguage => 'Change language';

  @override
  String get mySkills => 'My skills';

  @override
  String get contact => 'Contact';

  @override
  String get letsConnect => 'Let\'s connect';

  @override
  String get education => 'Ausbildung';

  @override
  String get jobExperience => 'Berufserfahrung';

  @override
  String get sideJobs => 'Side jobs';

  @override
  String get languates => 'Languages';

  @override
  String get personalData => 'Personal data';

  @override
  String get drivingLicenseClasses => 'Driving license classes';

  @override
  String get bornPlace => 'Place of birth';

  @override
  String get birthDate => 'Date of birth';

  @override
  String get present => 'present';

  @override
  String get noDegree => 'No degree';

  @override
  String get programmingLanguages => 'Programming languages';

  @override
  String get disability => 'Disability';

  @override
  String get showCopyOfDisabilityCard => 'Show copy of disability card';

  @override
  String get invite => 'Invite';

  @override
  String get refuse => 'Refuse';

  @override
  String get inviteDialogTitle => 'Thanks for the invite and the time!';

  @override
  String get inviteDialogContent => 'You have decided to have a conversation with me. I\'m very happy about that! Do you want to choose a date and time directly or do you want to send it to me separately by email? I will be informed about your decision. You can change your mind at any time.';

  @override
  String get refuseDialogTitle => 'Really a pity, but still thanks for your time!';

  @override
  String get refuseDialogContent => 'You have decided against a conversation with me. I will be informed about your decision. You can change your mind at any time.';

  @override
  String get inviteWithoutPickingDate => 'Invite without picking a date';

  @override
  String get pickDate => 'Pick date';

  @override
  String get close => 'Close';

  @override
  String get inviteIsSent => 'Invite is sent';

  @override
  String get inviteIsSentContent => 'The invite has been successfully sent:';

  @override
  String get mobileSwipeHeadline => 'Make your choice with a swipe';

  @override
  String get mobileSwipeInstruction => 'Swipe left to refuse or right to invite.';

  @override
  String get webButtonHeadline => 'Make your choice with a click';

  @override
  String get webButtonInstruction => 'Click the right button for invitation or refusal';

  @override
  String get noDataAvailable => 'No data available';

  @override
  String get pending => 'Pending';

  @override
  String get rejected => 'Rejected';

  @override
  String get invited => 'Invited';

  @override
  String get inviteExplanationHint => 'Add an optional message...';

  @override
  String get refuseExplanationHint => 'Reason for refusal (optional)...';

  @override
  String get reasonForRejection => 'Reason for rejection';

  @override
  String get message => 'Message';

  @override
  String get appointment => 'Appointment';

  @override
  String get duration => 'Duration';

  @override
  String get responseOfApplicant => 'Response of the applicant';

  @override
  String get applicantAccepted => 'Applicant accepted';

  @override
  String get applicantRefused => 'Applicant refused';

  @override
  String get applicantDidNotRespondYet => 'Applicant has not responded yet';

  @override
  String get revoke => 'Revoke';

  @override
  String get revokeDialogTitle => 'Revoke invitation?';

  @override
  String get revokeDialogContent => 'Do you really want to revoke your decision? The applicant will be informed about it.';

  @override
  String durationFormatted(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String durationFormattedMinutesOnly(Object minutes) {
    return '$minutes min';
  }

  @override
  String get noMessageWrittenToApplicant => 'No message written to applicant';

  @override
  String get responseStatusFromApplicant => 'Response to the invitation';

  @override
  String get proof => 'Proof';

  @override
  String copyright(Object year) {
    return '© $year Tolga Yıldırım – All rights reserved.';
  }

  @override
  String get imprint => 'Imprint';

  @override
  String get externalLinkDialogTitle => 'External Link';

  @override
  String get externalLinkDialogContent => 'You are about to open an external link. I am not responsible for the content of this external site. I have no control over it and expressly do not adopt its content as my own.';

  @override
  String get privacyPolicy => 'Privacy Policy';
}
