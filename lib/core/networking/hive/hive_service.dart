import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemchase_clean_arch/core/common/hive/hive_service/setting_hive_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

final hiveServiceProvider = Provider((ref) => HiveService());

class HiveService {
  Future<void> init() async {
    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    }

    await SettingsHiveService().init();
  }

  Future<void> hiveOpen(String boxName) async {
    await Hive.openBox(boxName).onError(
      (error, stackTrace) async {
        await Hive.openBox(boxName);
        throw 'Failed to open $boxName Box\nError: $error';
      },
    );
  }

  Future<void> deleteHive() async {
    await Hive.deleteFromDisk();
  }
}
