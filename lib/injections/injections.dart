import 'package:chat_app/domains/account/di/account_dependency.dart';
import 'package:chat_app/domains/auth/di/auth_dependency.dart';
import 'package:get_it/get_it.dart';

import '../shared_libraries/core/di/core_module.dart';
import '../shared_libraries/utils/di/utils_module.dart';

final sl = GetIt.instance;

class Injections {
  Future<void> initialize() async {
    await _registerSharedLibraries();
    _registerDomains();
  }

  Future<void> _registerSharedLibraries() async {
    await RegisterCoreModule().core();
    RegisterUtilsModule();
  }

  void _registerDomains() {
    AuthDependency();
    AccountDependency();
  }
}
