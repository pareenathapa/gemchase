import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ! DO NOT MODIFY THIS FILE

final settingsHiveServiceProvider = Provider((ref) => SettingsHiveService());

class SettingsHiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(
      AppSettingsHiveModelAdapter(),
    );
    // Register Adapters
    Hive.registerAdapter(LoginHiveModelAdapter());
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  // ------------------ All Settings Queries ------------------ //

  Future<void> addSettings(AppSettingsHiveModel settings) async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );

    await box.put(0, settings);
  }

  Future<AppSettingsHiveModel> getSettings() async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
    final data = box.values;
    if (data.isEmpty) {
      addSettings(
        AppSettingsHiveModel.empty(),
      );
      return AppSettingsHiveModel.empty();
    } else {
      return data.first;
    }
  }

  Future<void> updateSettings(AppSettingsHiveModel settings) async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
    await box.putAt(0, settings);
  }

  Future<void> clearSettings() async {
    var box = await Hive.openBox<AppSettingsHiveModel>(
      HiveTableConstant.appSettingsBox,
    );
    await box.clear();
  }
}
