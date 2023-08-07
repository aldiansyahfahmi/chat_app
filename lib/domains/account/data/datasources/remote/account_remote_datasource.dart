import 'package:firebase_auth/firebase_auth.dart';

abstract class AccountRemoteDataSource {
  Future<User> getUser();
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final _user = FirebaseAuth.instance;

  @override
  Future<User> getUser() async {
    try {
      final result = _user.currentUser!;
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
