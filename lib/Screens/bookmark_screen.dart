import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/models/Providers/bookmark_provider.dart';
import 'package:newsapp/widgets/news_widget.dart';
import 'package:provider/provider.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Consumer<BookMarkProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).primaryColor,
                centerTitle: true,
                title: Text(
                  "NewsShot",
                  style: TextStyle(fontSize: 40.sp, color: Colors.blueAccent),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: value.bookMarks.length, (context, index) {
                  return NewsContainer(newsModel: value.bookMarks[index]);
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
