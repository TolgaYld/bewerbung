class FirestoreKeys {
  const FirestoreKeys._();

  static const String companies = 'companies';
  static const String employee = 'employee';
  static const String contentPipelineCollection = 'content_pipeline';

  static String company(String id) => '$companies/$id';
}
