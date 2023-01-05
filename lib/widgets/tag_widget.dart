import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/models/Providers/filter_provider.dart';
import 'package:provider/provider.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget({super.key, required this.tag});

  Color _getColor(BuildContext context,
      {required String filterStr, required String buttonText}) {
    if (filterStr == buttonText) {
      return Colors.blueAccent;
    }
    return Theme.of(context).primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FilterProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return GestureDetector(
          onTap: () {
            value.changeFilter(tag);
          },
          child: Container(
            height: 40.h,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color:
                  _getColor(context, filterStr: value.filter, buttonText: tag),
              border: Border.all(
                color: Colors.blueAccent,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                tag.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
