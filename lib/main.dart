import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/Screens/main_screen.dart';
import 'package:newsapp/models/Providers/bookmark_provider.dart';
import 'package:newsapp/utils/shared_prefrences_handler.dart';
import 'package:newsapp/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefencesHandler.init();
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
        ChangeNotifierProvider<BookMarkProvider>(
          create: (BuildContext context) {
            return BookMarkProvider();
          },
        )
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
            child: const MainScreen(),
          );
        },
      ),
    );
  }
}
