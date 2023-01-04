import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/utils/dio_helper.dart';
import 'package:newsapp/widgets/drawer_container.dart';
import 'package:newsapp/widgets/news_widget.dart';
import '../models/news_model.dart';

class HeadlineScreen extends StatefulWidget {
  const HeadlineScreen({super.key});

  @override
  State<HeadlineScreen> createState() => _HeadlineScreenState();
}

class _HeadlineScreenState extends State<HeadlineScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              future: DioHelper().fetchHeadlines(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    List<NewsModel> newsData = snapshot.data as List<NewsModel>;
                    return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                      return NewsContainer(newsModel: newsData[index]);
                    }));
                  }
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  );
                }

                return const SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Internet Connection!"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
