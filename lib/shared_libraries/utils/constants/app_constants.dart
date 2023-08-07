class AppConstants {
  const AppConstants();

  static App app = const App();
  static CachedKey cachedKey = const CachedKey();
  static AppApi appApi = const AppApi();
  static ErrorKey errorKey = const ErrorKey();
  static ErrorMessage errorMessage = const ErrorMessage();
}

class App {
  const App();

  double get defaultMargin => 16.0;
}

class CachedKey {
  const CachedKey();

  String get tokenKey => 'tokenKey';
}

class AppApi {
  const AppApi();
  String get baseUrlDevelopment => 'https://';
  String get baseUrlProduction => 'https://';

  String get login => 'login';
}

class ErrorKey {
  const ErrorKey();

  String get weakPassword => "weak-password";

  String get emailAlreadyInUse => "email-already-in-use";
}

class ErrorMessage {
  const ErrorMessage();

  String get failedGetToken => 'failed get token';

  String get weakPassword => 'The password provided is too weak.';

  String get emailAlreadyInUse => 'The account already exists for that email.';
}
