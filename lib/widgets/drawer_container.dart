import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class DrawerContainer extends StatelessWidget {
  const DrawerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200.h,
            width: double.infinity,
            padding: EdgeInsets.all(10.r),
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundColor: Colors.black,
                  child: const Icon(Icons.person),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "User",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
          Consumer<ThemeProvider>(
            builder: (BuildContext context, theme, Widget? child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.sunny,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  CupertinoSwitch(
                    value: theme.isDark,
                    onChanged: (bool value) {
                      theme.changeTheme(value);
                    },
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  const Icon(
                    Icons.dark_mode,
                    color: Colors.blueAccent,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
