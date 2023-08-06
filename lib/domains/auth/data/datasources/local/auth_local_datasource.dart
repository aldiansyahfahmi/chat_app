import 'package:chat_app/injections/injections.dart';
import 'package:chat_app/shared_libraries/utils/constants/app_constants.dart';
import 'package:chat_app/shared_libraries/utils/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<bool> cachedUserData({required String token});

  Future<bool> cachedToken({required String token});

  Future<String> getToken();

  Future<bool> removeUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences = sl();

  @override
  Future<bool> cachedToken({required String token}) async {
    return sharedPreferences.setString(AppConstants.cachedKey.tokenKey, token);
  }

  @override
  Future<bool> cachedUserData({required String token}) async {
    return sharedPreferences.setString(AppConstants.cachedKey.tokenKey, token);
  }

  @override
  Future<String> getToken() async {
    try {
      return sharedPreferences.getString(AppConstants.cachedKey.tokenKey) ?? '';
    } catch (_) {
      throw DatabaseException(AppConstants.errorMessage.failedGetToken);
    }
  }

  @override
  Future<bool> removeUserData() async {
    return await sharedPreferences.remove(
      AppConstants.cachedKey.tokenKey,
    );
  }
}
