// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class L10nEs extends L10n {
  L10nEs([String locale = 'es']) : super(locale);

  @override
  String get language => 'Español';

  @override
  String get countryFlag => '🇪🇸';

  @override
  String get welcomeToPleaseHireTolga => 'Bienvenido a Please Hire Tolga 🙌';

  @override
  String get tapOnScanQrCodeToLogin => 'Toca el código QR para escanearlo e iniciar sesión.';

  @override
  String get youWillBeAutomaticallyLoggedIn => 'Después, iniciarás sesión automáticamente.';

  @override
  String get youNeedHelp => '¿Necesitas ayuda?';

  @override
  String get clickHere => 'Haz clic aquí';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get oopsSomethingWentWrongPleaseTryAgain => 'Ups 😅, algo salió mal. Por favor, inténtalo de nuevo';

  @override
  String get dontWantLoginViaQrCode => '¿No quieres iniciar sesión a través del código QR?';

  @override
  String get wantToLoginViaQrCode => '¿Quieres iniciar sesión a través del código QR?';

  @override
  String get enterYourLoginInformation => 'Por favor, ingresa tu información de inicio de sesión que te envié.';

  @override
  String get aboutMe => 'Sobre mí';

  @override
  String get cv => 'CV';

  @override
  String get coverLetter => 'Carta de presentación';

  @override
  String get inviteQuestion => '¿Invitación?';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get cancel => 'Cancelar';

  @override
  String get deleteAccount => '¿Eliminar cuenta?';

  @override
  String get signOutDialogTitle => 'Cerrar sesión';

  @override
  String get signOutDialogContent => 'Puedes cerrar sesión o eliminar tu cuenta de forma permanente.\n\nSi eliminas tu cuenta, se borrarán todos tus datos y no podrás volver a iniciar sesión.\n\nSi solo cierras sesión, tus datos se conservarán y podrás volver a iniciar sesión más adelante.';

  @override
  String applicationToCompany(Object company) {
    return 'Solicitud a $company';
  }

  @override
  String get changeLanguage => 'Cambiar idioma';

  @override
  String get mySkills => 'Mis habilidades';

  @override
  String get contact => 'Contacto';

  @override
  String get letsConnect => 'Conectemos';

  @override
  String get education => 'Educación';

  @override
  String get jobExperience => 'Experiencia laboral';

  @override
  String get sideJobs => 'Trabajos secundarios';

  @override
  String get languates => 'Idiomas';

  @override
  String get personalData => 'Datos personales';

  @override
  String get drivingLicenseClasses => 'Clases de licencia de conducir';

  @override
  String get bornPlace => 'Lugar de nacimiento';

  @override
  String get birthDate => 'Fecha de nacimiento';

  @override
  String get present => 'presente';

  @override
  String get noDegree => 'Sin título';

  @override
  String get programmingLanguages => 'Lenguajes de programación';

  @override
  String get disability => 'Discapacidad';

  @override
  String get showCopyOfDisabilityCard => 'Mostrar copia de la tarjeta de discapacidad';

  @override
  String get invite => 'Invitar';

  @override
  String get refuse => 'Rechazar';

  @override
  String get inviteDialogTitle => '¡Gracias por la invitación y el tiempo!';

  @override
  String get inviteDialogContent => 'Has decidido tener una conversación conmigo. ¡Estoy muy feliz por eso! ¿Quieres elegir una fecha y hora directamente o quieres enviármelo por separado por correo electrónico? Seré informado sobre tu decisión. Puedes cambiar de opinión en cualquier momento.';

  @override
  String get refuseDialogTitle => 'Realmente una pena, pero aún así gracias por tu tiempo!';

  @override
  String get refuseDialogContent => 'Has decidido no tener una conversación conmigo. Seré informado sobre tu decisión. Puedes cambiar de opinión en cualquier momento.';

  @override
  String get inviteWithoutPickingDate => 'Invitación sin elegir fecha';

  @override
  String get pickDate => 'Elegir fecha';

  @override
  String get close => 'Cerrar';

  @override
  String get inviteIsSent => 'La invitación ha sido enviada';

  @override
  String get inviteIsSentContent => 'La invitación ha sido enviada con éxito:';

  @override
  String get mobileSwipeHeadline => 'Toma tu decisión con un deslizamiento';

  @override
  String get mobileSwipeInstruction => 'Desliza hacia la izquierda para rechazar o hacia la derecha para invitar.';

  @override
  String get webButtonHeadline => 'Toma tu decisión con un clic';

  @override
  String get webButtonInstruction => 'Haz clic en el botón correcto para la invitación o el rechazo';

  @override
  String get noDataAvailable => 'No hay datos disponibles';

  @override
  String get pending => 'Pendiente';

  @override
  String get rejected => 'Rechazado';

  @override
  String get invited => 'Invitado';

  @override
  String get inviteExplanationHint => 'Agrega un mensaje opcional...';

  @override
  String get refuseExplanationHint => 'Razón del rechazo (opcional)...';

  @override
  String get reasonForRejection => 'Razón del rechazo';

  @override
  String get message => 'Mensaje';

  @override
  String get appointment => 'Cita';

  @override
  String get duration => 'Duración';

  @override
  String get responseOfApplicant => 'Respuesta del solicitante';

  @override
  String get applicantAccepted => 'El solicitante ha aceptado';

  @override
  String get applicantRefused => 'El solicitante ha rechazado';

  @override
  String get applicantDidNotRespondYet => 'El solicitante aún no ha respondido';

  @override
  String get revoke => 'Revocar';

  @override
  String get revokeDialogTitle => '¿Revocar invitación?';

  @override
  String get revokeDialogContent => '¿Realmente deseas revocar tu decisión? El solicitante será informado al respecto.';

  @override
  String durationFormatted(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String durationFormattedMinutesOnly(Object minutes) {
    return '$minutes min';
  }

  @override
  String get noMessageWrittenToApplicant => 'No se ha escrito ningún mensaje al solicitante';

  @override
  String get responseStatusFromApplicant => 'Respuesta a la invitación';

  @override
  String get proof => 'Prueba';
}
