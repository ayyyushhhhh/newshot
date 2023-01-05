import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/API%20helper/api_helper.dart';
import 'package:newsapp/utils/API%20helper/error_handler.dart';
import 'package:newsapp/widgets/news_widget.dart';

class FilterNewsFutureBuilder extends StatelessWidget {
  final String filter;
  const FilterNewsFutureBuilder({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: APIHelper().fetchQueryNews(query: filter),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            final error = snapshot.error as DioError;
            APIErrorHandler.fromDioError(error);
            SnackBar(
              content: Text(APIErrorHandler.message.toString()),
            );
            return const SliverToBoxAdapter(
              child: Center(
                child: Text("Something Went Wrong"),
              ),
            );
          }
          if (snapshot.hasData) {
            List<NewsModel> newsData = snapshot.data as List<NewsModel>;
            return SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: newsData.length, (context, index) {
              return NewsContainer(newsModel: newsData[index]);
            }));
          }
          return const SliverToBoxAdapter(
            child: Center(
              child: Text("No Internet Connection!"),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: Center(
            child: Text("No Data"),
          ),
        );
      },
    );
  }
}
