import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pleasehiretolga/core/hooks/use_l10n.hook.dart';
import 'package:pleasehiretolga/core/localization/localizations.dart';
import 'package:pleasehiretolga/core/provider/locale.provider.dart';

class LanguageSwitcher extends HookConsumerWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = useL10n();
    final currentLocale = ref.watch(localeProvider);
    final localeNotifier = ref.read(localeProvider.notifier);
    final isMenuOpen = useState(false);

    return PopupMenuButton<String>(
      offset: const Offset(0, 60),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: 60,
        maxWidth: 80,
      ),
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentLocale == null ? '🌐' : getFlagForLocale(currentLocale),
            style: const TextStyle(fontSize: 22),
          ),
          Icon(Icons.arrow_drop_down, size: 18)
              .animate(
                target: isMenuOpen.value ? 1 : 0,
              )
              .rotate(
                end: 0.5,
                duration: Durations.short3,
                curve: Curves.easeInOut,
              ),
        ],
      ),
      tooltip: l10n.changeLanguage,
      onSelected: (String value) {
        if (value == 'system') {
          localeNotifier.useSystemLocale();
        } else {
          localeNotifier.changeLocale(Locale(value));
        }
        isMenuOpen.value = false;
      },
      onCanceled: () {
        isMenuOpen.value = false;
      },
      onOpened: () {
        isMenuOpen.value = true;
      },
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: 'system',
          padding: EdgeInsets.zero,
          child: Center(
            child: Text(
              '🌐',
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
        ...L10n.supportedLocales.map(
          (locale) => PopupMenuItem<String>(
            value: locale.languageCode,
            padding: EdgeInsets.zero,
            child: Center(
              child: Text(
                getFlagForLocale(locale),
                style: const TextStyle(fontSize: 22),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getFlagForLocale(Locale locale) => switch (locale.languageCode) {
        'en' => '🇬🇧',
        'de' => '🇩🇪',
        'es' => '🇪🇸',
        'fr' => '🇫🇷',
        'tr' => '🇹🇷',
        _ => '🌐'
      };
}
