import 'package:flutter/material.dart';

import '../../../l10n/app_localization.dart';
import '../../../l10n/lang_const/language_constant.dart';
import '../../feature/quizzly_app/screens/home_page.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => {setLocale(locale)});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      title: "Quizzly",
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: "DMSans",
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
