import 'package:blinews/pages/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(
              color: Colors.white,
            )),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orangeAccent,
              primary: const Color(0xffFF7F50),
              secondary: const Color(0xff3B3535),
              onBackground: Colors.white,
              onPrimaryContainer: const Color(0xffD9D9D9),
            ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}
