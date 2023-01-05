import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/Screens/search_screen.dart';
import 'package:newsapp/utils/API%20helper/api_helper.dart';
import 'package:newsapp/utils/API%20helper/error_handler.dart';
import 'package:newsapp/widgets/drawer_container.dart';
import 'package:newsapp/widgets/news_widget.dart';
import '../models/news_model.dart';

class HeadlineScreen extends StatefulWidget {
  const HeadlineScreen({super.key});

  @override
  State<HeadlineScreen> createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        backgroundColor: Theme.of(context).primaryColor,
        drawer: const DrawerContainer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              pinned: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const SearchScreen();
                      }));
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                    )),
              ],
              title: Text(
                "NewsShot",
                style: TextStyle(fontSize: 40.sp, color: Colors.blueAccent),
              ),
              leading: IconButton(
                onPressed: () {
                  _scaffoldkey.currentState!.openDrawer();
                },
                icon: Icon(
                  Icons.menu,
                  color: Colors.blueAccent,
                  size: 40.r,
                ),
              ),
            ),
            FutureBuilder<List<NewsModel>>(
              future: APIHelper().fetchHeadlines(),
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
