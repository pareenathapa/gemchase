import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    Hive.registerAdapter(LoginHiveModelAdapter());
  }

  Future<void> saveUser(LoginHiveModel login) async {
    var box = await Hive.openBox<LoginHiveModel>(HiveTableConstant.loginBox);
    await box.put(0, login);
    await box.put(1, login);
  }

  Future<LoginHiveModel?> getUser() async {
    var box = await Hive.openBox<LoginHiveModel>(HiveTableConstant.loginBox);
    var login = box.get(0);
    box.close();
    return login;
  }

  Future<LoginHiveModel?> getFingerPrintUser() async {
    var box = await Hive.openBox<LoginHiveModel>(HiveTableConstant.loginBox);
    var login = box.get(0);
    box.close();
    return login;
  }

  // delete user
  Future<void> deleteUser() async {
    var box = await Hive.openBox<LoginHiveModel>(HiveTableConstant.loginBox);
    await box.delete(0);
    box.close();
  }
}
