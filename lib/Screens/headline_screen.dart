import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/utils/dio_helper.dart';
import 'package:newsapp/widgets/news_widget.dart';
import '../models/news_model.dart';

class HeadlineScreen extends StatefulWidget {
  const HeadlineScreen({super.key});

  @override
  State<HeadlineScreen> createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen> {
  @override
  void initState() {
    super.initState();
    DioHelper().fetchHeadlines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: Text(
          "NewsShot",
          style: TextStyle(fontSize: 24.sp, color: Colors.greenAccent),
        ),
        iconTheme: const IconThemeData(color: Colors.greenAccent),
        centerTitle: true,
      ),
      drawer: Container(),
      body: FutureBuilder<List<NewsModel>>(
        future: DioHelper().fetchHeadlines(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<NewsModel> newsData = snapshot.data as List<NewsModel>;
            return ListView.builder(
              itemCount: newsData.length,
              itemBuilder: (BuildContext context, int index) {
                return NewsContainer(newsModel: newsData[index]);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
