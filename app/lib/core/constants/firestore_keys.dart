class FirestoreKeys {
  const FirestoreKeys._();

  static const String companies = 'companies';
  static const String employee = 'employee';
  static const String imprint = 'imprint';
  static const String privacyPolicy = 'privacy';

  static String company(String id) => '$companies/$id';
}
