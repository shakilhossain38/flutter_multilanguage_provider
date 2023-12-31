import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_lang/l10n/l10n.dart';
import 'package:multi_lang/local.dart';

import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _appLanguage = LocaleProvider();
  await _appLanguage.fetchLocale();
  runApp(
    MyApp(
      appLanguage: _appLanguage,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appLanguage});

  final LocaleProvider appLanguage;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
      ],
      child: ChangeNotifierProvider<LocaleProvider>(
        create: (_) => appLanguage,
        child: Consumer<LocaleProvider>(
          builder: (context, provider, snapshot) {
            return MaterialApp(
              locale: provider.locale,
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              home: const DummyPage(),
            );
          },
        ),
      ),
    );
  }
}

class DummyPage extends StatelessWidget {
  const DummyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.homeTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const FlutterLocalizationDemo();
                    },
                  ),
                );
              },
              child: Text(context.l10n.buttonName),
            ),
          ),
        ],
      ),
    );
  }
}

class FlutterLocalizationDemo extends StatelessWidget {
  const FlutterLocalizationDemo({super.key});

  @override
  Widget build(BuildContext context) {
    Text title(String val) {
      switch (val) {
        case 'en':
          return const Text(
            'English',
            style: TextStyle(fontSize: 16),
          );
        case 'bn':
          return const Text(
            'বাংলা',
            style: TextStyle(fontSize: 16),
          );

        case 'hi':
          return const Text(
            'हिंदी',
            style: TextStyle(fontSize: 16),
          );
        case 'ru':
          return const Text(
            'Русский',
            style: TextStyle(fontSize: 16),
          );
        case 'es':
          return const Text(
            'Español',
            style: TextStyle(fontSize: 16),
          );
        case 'pt':
          return const Text(
            'Portuguesa',
            style: TextStyle(fontSize: 16),
          );

        case 'fr':
          return const Text(
            'Française',
            style: TextStyle(fontSize: 16),
          );

        default:
          return const Text(
            'English',
            style: TextStyle(fontSize: 16),
          );
      }
    }

    return Consumer<LocaleProvider>(
      builder: (context, provider, snapshot) {
        final lang = provider.locale ?? Localizations.localeOf(context);
        final l10n = context.l10n;

        final list = [
          const Locale('en'),
          const Locale('bn'),
          const Locale('hi'),
          const Locale('ru'),
          const Locale('pt'),
          const Locale('fr'),
          const Locale('es'),
        ];
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appBar),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.languageName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 85),
                DropdownButton(
                  value: lang,
                  onChanged: (Locale? val) {
                    provider.setLocale(val!);
                  },
                  items: list
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: title(e.languageCode),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
