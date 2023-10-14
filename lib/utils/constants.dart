class Constants {
  static const String appName = "Next big thing";
  static const String seen = "seen";

  static const String phoneProvider = "phone";
  static const String facebookProvider = "facebook.com";
  static const String googleProvider = "google.com";
  static const String users = "users";
  static const String profiles = "profiles";
  static const String restaurants = "restaurants";
  static const String notExists = "not-exists";
  static const String masterData = "masterData";
  static const String masterDataV1 = "masterDataV1";
}

class CloudFunctionApi {
  static const String prodPDF =
      'https://us-central1-leva-matrimonial---dev.cloudfunctions.net/pdfProfileExport';

  static const String testPDF =
      'https://us-central1-leva-matrimonial-test.cloudfunctions.net/pdfProfileExport';

  static const String prodExcel =
      'https://us-central1-leva-matrimonial---dev.cloudfunctions.net/excelExports';
  static const String textExcel =
      'https://us-central1-leva-matrimonial-test.cloudfunctions.net/excelExports';
}
