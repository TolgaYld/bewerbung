import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/design/theme.dart';
import 'package:pleasehiretolga/core/features/theme/dynamic_theme.provider.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';
import 'package:pleasehiretolga/core/routing/router.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(navigationManagerProvider);
    final locale = ref.watch(localeProvider);
    final customTheme = ref.watch(dynamicThemeProvider);
    return MaterialApp.router(
      title: 'Please Hire Tolga',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: locale,
      theme: customTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
