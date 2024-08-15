import 'package:gemchase_clean_arch/core/common/exports.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti/khalti.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Khalti.init(
    publicKey: 'test_public_key_dc74e0fd57cb46cd93832aee0a507256',
    enabledDebugging: false,
  );
  await HiveService().init();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
