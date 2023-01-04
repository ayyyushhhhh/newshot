import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/Providers/bookmark_provider.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:provider/provider.dart';

class NewsContainer extends StatelessWidget {
  final NewsModel newsModel;
  const NewsContainer({super.key, required this.newsModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r)),
            child: Image.network(
              newsModel.urlToImage.toString(),
            ),
          ),
          const SizedBox(),
          Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  newsModel.title.toString(),
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  newsModel.description.toString(),
                  style:
                      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat.yMMMEd().format(
                        DateTime.parse(
                          newsModel.publishedAt.toString(),
                        ),
                      ),
                      style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                    ),
                    Consumer<BookMarkProvider>(builder:
                        (BuildContext context, bookmarks, Widget? child) {
                      if (bookmarks.bookMarks.contains(newsModel)) {
                        return IconButton(
                            onPressed: () {
                              bookmarks.removeBookMark(newsModel);
                            },
                            icon: const Icon(
                              Icons.bookmark,
                              color: Colors.blueAccent,
                            ));
                      } else {
                        return IconButton(
                            onPressed: () {
                              bookmarks.addBookMark(newsModel);
                            },
                            icon: const Icon(Icons.bookmark));
                      }
                    }),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
