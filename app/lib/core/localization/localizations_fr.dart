// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class L10nFr extends L10n {
  L10nFr([String locale = 'fr']) : super(locale);

  @override
  String get language => 'Français';

  @override
  String get countryFlag => '🇫🇷';

  @override
  String get welcomeToPleaseHireTolga => 'Bienvenue sur Please Hire Tolga 🙌';

  @override
  String get tapOnScanQrCodeToLogin => 'Appuyez sur le code QR pour le scanner et vous connecter.';

  @override
  String get youWillBeAutomaticallyLoggedIn => 'Vous serez automatiquement connecté.';

  @override
  String get youNeedHelp => 'Vous avez besoin d\'aide ?';

  @override
  String get clickHere => 'Cliquez ici';

  @override
  String get login => 'Connexion';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get oopsSomethingWentWrongPleaseTryAgain => 'Oups 😅, quelque chose s\'est mal passé. Veuillez réessayer';

  @override
  String get dontWantLoginViaQrCode => 'Vous ne voulez pas vous connecter via le code QR ?';

  @override
  String get wantToLoginViaQrCode => 'Vous voulez vous connecter via le code QR ?';

  @override
  String get enterYourLoginInformation => 'Veuillez entrer vos informations de connexion que je vous ai envoyées.';

  @override
  String get aboutMe => 'À propos de moi';

  @override
  String get cv => 'CV';

  @override
  String get coverLetter => 'Lettre de motivation';

  @override
  String get inviteQuestion => 'Invitation ?';

  @override
  String get signOut => 'Déconnexion';

  @override
  String get cancel => 'Annuler';

  @override
  String get deleteAccount => 'Supprimer le compte ?';

  @override
  String get signOutDialogTitle => 'Déconnexion';

  @override
  String get signOutDialogContent => 'Vous pouvez vous déconnecter et supprimer votre compte ou simplement vous déconnecter. \n\nSi vous supprimez votre compte, toutes vos données seront supprimées et vous ne pourrez plus vous connecter. \n\nSi vous vous déconnectez simplement, vos données seront conservées et vous pourrez vous reconnecter plus tard.';

  @override
  String applicationToCompany(Object company) {
    return 'Candidature à $company';
  }

  @override
  String get changeLanguage => 'Changer de langue';

  @override
  String get mySkills => 'Mes compétences';

  @override
  String get contact => 'Contact';

  @override
  String get letsConnect => 'Connectons-nous';

  @override
  String get education => 'Éducation';

  @override
  String get jobExperience => 'Expérience professionnelle';

  @override
  String get sideJobs => 'Emplois secondaires';

  @override
  String get languates => 'Langues';

  @override
  String get personalData => 'Données personnelles';

  @override
  String get drivingLicenseClasses => 'Catégories de permis de conduire';

  @override
  String get bornPlace => 'Lieu de naissance';

  @override
  String get birthDate => 'Date de naissance';

  @override
  String get present => 'présent';

  @override
  String get noDegree => 'Pas de diplôme';

  @override
  String get programmingLanguages => 'Langages de programmation';

  @override
  String get disability => 'Handicap';

  @override
  String get showCopyOfDisabilityCard => 'Afficher la copie de la carte de handicap';

  @override
  String get invite => 'Inviter';

  @override
  String get refuse => 'Refuser';

  @override
  String get inviteDialogTitle => 'Merci pour l\'invitation et le temps !';

  @override
  String get inviteDialogContent => 'Vous avez décidé d\'avoir une conversation avec moi. Je suis très heureux de cela ! Voulez-vous choisir une date et une heure directement ou voulez-vous me l\'envoyer séparément par e-mail ? Je serai informé de votre décision. Vous pouvez changer d\'avis à tout moment.';

  @override
  String get refuseDialogTitle => 'Vraiment dommage, mais merci quand même pour votre temps !';

  @override
  String get refuseDialogContent => 'Vous avez décidé de ne pas avoir de conversation avec moi. Je serai informé de votre décision. Vous pouvez changer d\'avis à tout moment.';

  @override
  String get inviteWithoutPickingDate => 'Invitation sans choisir de date';

  @override
  String get pickDate => 'Choisir une date';

  @override
  String get close => 'Fermer';

  @override
  String get inviteIsSent => 'L\'invitation a été envoyée';

  @override
  String get inviteIsSentContent => 'L\'invitation a été envoyée avec succès :';

  @override
  String get mobileSwipeHeadline => 'Prenez votre décision avec un glissement';

  @override
  String get mobileSwipeInstruction => 'Glissez vers la gauche pour refuser ou vers la droite pour inviter.';

  @override
  String get webButtonHeadline => 'Prenez votre décision avec un clic';

  @override
  String get webButtonInstruction => 'Cliquez sur le bon bouton pour l\'invitation ou le refus';

  @override
  String get noDataAvailable => 'Aucune donnée disponible';

  @override
  String get pending => 'En attente';

  @override
  String get rejected => 'Rejeté';

  @override
  String get invited => 'Invité';

  @override
  String get inviteExplanationHint => 'Ajoutez éventuellement un message...';

  @override
  String get refuseExplanationHint => 'Raison du refus (facultatif)...';

  @override
  String get reasonForRejection => 'Raison du refus';

  @override
  String get message => 'Message';

  @override
  String get appointment => 'Rendez-vous';

  @override
  String get duration => 'Durée';

  @override
  String get responseOfApplicant => 'Réponse du candidat';

  @override
  String get applicantAccepted => 'Le candidat a accepté';

  @override
  String get applicantRefused => 'Le candidat a refusé';

  @override
  String get applicantDidNotRespondYet => 'Le candidat n\'a pas encore répondu';

  @override
  String get revoke => 'Révoquer';

  @override
  String get revokeDialogTitle => 'Révoquer l\'invitation ?';

  @override
  String get revokeDialogContent => 'Voulez-vous vraiment révoquer votre décision ? Le candidat en sera informé.';

  @override
  String durationFormatted(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String durationFormattedMinutesOnly(Object minutes) {
    return '$minutes min';
  }

  @override
  String get noMessageWrittenToApplicant => 'Aucun message écrit au candidat';

  @override
  String get responseStatusFromApplicant => 'Réponse à l\'invitation';

  @override
  String get proof => 'Preuve';
}
