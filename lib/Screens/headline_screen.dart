import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/Screens/search_screen.dart';
import 'package:newsapp/models/Providers/filter_provider.dart';
import 'package:newsapp/widgets/bottom_modal.dart';
import 'package:newsapp/widgets/drawer_container.dart';
import 'package:newsapp/widgets/all_news_future_widget.dart';
import 'package:newsapp/widgets/fiter_news_future_builder.dart';
import 'package:provider/provider.dart';

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
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const BottomModal();
                        });
                  },
                  icon: Icon(
                    Icons.filter_alt,
                    color: Colors.blueAccent,
                    size: 40.r,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const SearchScreen();
                    }));
                  },
                  icon: Icon(
                    Icons.search,
                    color: Colors.blueAccent,
                    size: 40.r,
                  ),
                ),
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
            Consumer<FilterProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return CupertinoSliverRefreshControl(
                  onRefresh: () async {
                    value.changeFilter(value.filter);
                  },
                );
              },
            ),
            Consumer<FilterProvider>(
              builder: (BuildContext context, value, Widget? child) {
                if (value.filter == "") {
                  return const AllNewsFutureBuilder();
                }
                return FilterNewsFutureBuilder(filter: value.filter);
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
