import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/Providers/query_provider.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/utils/API%20helper/api_helper.dart';
import 'package:newsapp/widgets/query_news_container.dart';
import 'package:provider/provider.dart';

import '../utils/API helper/error_handler.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController queryController = TextEditingController();
  late QueryProvider queryProvider;

  @override
  void initState() {
    super.initState();
    queryProvider = Provider.of<QueryProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    queryProvider.sendQuery("");
    queryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.blueAccent,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Card(
            child: TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  fillColor: Theme.of(context).primaryColor,
                  filled: true,
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                  ),
                  hintText: 'Search...'),
              onChanged: (val) {
                queryProvider.sendQuery(val);
              },
            ),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            Consumer<QueryProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return FutureBuilder<List<NewsModel>>(
                  future: APIHelper().fetchQueryNews(query: value.query),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                      }
                      if (snapshot.hasData) {
                        List<NewsModel> newsData =
                            snapshot.data as List<NewsModel>;
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            childCount: newsData.length,
                            (context, index) {
                              return QueryNewsContainer(
                                  newsModel: newsData[index]);
                            },
                          ),
                        );
                      }
                      return const SliverToBoxAdapter(
                        child: Center(
                          child: Text("Search!..."),
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
              },
            ),
          ],
        ));
  }
}
