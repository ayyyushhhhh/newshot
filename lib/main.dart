import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/Screens/headline_screen.dart';
import 'package:newsapp/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (BuildContext context) {
            return ThemeProvider();
          },
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return ScreenUtilInit(
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                title: 'News App',
                theme: value.appThemeData,
                home: child,
              );
            },
            child: const HeadlineScreen(),
          );
        },
      ),
    );
  }
}
