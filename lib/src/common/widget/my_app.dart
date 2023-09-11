import 'package:flutter/material.dart';

import '../../feature/quizzly_app/screens/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Quizzly",
      theme: ThemeData(
        fontFamily: "DMSans",

      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
