import 'package:flutter/material.dart';
import 'package:newsapp/constant/color.dart';
import 'package:newsapp/model/source_model.dart';
import 'package:newsapp/provider/news_article_provider.dart';
import 'package:newsapp/screen/news_filter.dart';
import 'package:newsapp/widget/loading.dart';
import 'package:newsapp/widget/news_list.dart';
import 'package:newsapp/widget/snackbar.dart';
import 'package:provider/provider.dart';

import 'news_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageNumber = 1;
  String source = '';

  List<Sources> _listSource = [];
  final List<Sources> _filter = [];

  late Future futureSource;

  @override
  void initState() {
    super.initState();
    futureSource = Provider.of<NewsArticleProvider>(context, listen: false).fetchSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('News App'), actions: [
          source != '' ? IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () async {
                setState(() {
                  pageNumber = 1;
                  source = '';
                });
                await Provider.of<NewsArticleProvider>(context, listen: false)
                    .fetchTopHeadlines(pageNumber, source);
                showSnackBar(context: context, message: 'News Updated');
              }) : SizedBox.shrink(),
          IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const NewsFilter()))
                    .then((value) async {
                  setState(() {
                    pageNumber = 1;
                    source = value;
                  });
                  await Provider.of<NewsArticleProvider>(context, listen: false)
                      .fetchTopHeadlines(pageNumber, source);
                  showSnackBar(context: context, message: 'News Updated');
                });
              }),
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: NewsSearch());
              }),
        ]),
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                pageNumber = 1;
                source = '';
              });
              await Provider.of<NewsArticleProvider>(context, listen: false)
                  .fetchTopHeadlines(pageNumber, source);
              showSnackBar(context: context, message: 'News Updated');
            },
            child: SafeArea(
                child: FutureBuilder(
                    future: Provider.of<NewsArticleProvider>(context, listen: false)
                        .fetchTopHeadlines(pageNumber, source),
                    builder: (context, dataSnapShot) {
                      if (dataSnapShot.connectionState == ConnectionState.waiting) {
                        return const LoadingWidget();
                      } else {
                        if (dataSnapShot.error != null) {
                          return const Center(
                              child: Text("Error While Fetching Data\n Check Network Connection"));
                        } else {
                          return Consumer<NewsArticleProvider>(builder: (_, data, child) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: NewsListWidget(
                                        data: data, headings: const ["Trending News", "Top News"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        pagination(1),
                                        pagination(2),
                                        pagination(3),
                                        pagination(4),
                                        pagination(5)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                        }
                      }
                    }))));
  }

  Widget pagination(count) {
    return Expanded(
        child: InkWell(
      onTap: () async {
        setState(() {
          pageNumber = count;
        });

        await Provider.of<NewsArticleProvider>(context, listen: false)
            .fetchTopHeadlines(pageNumber, source);
        showSnackBar(context: context, message: 'News Updated');
      },
      child: Container(
          padding: const EdgeInsets.all(7.5),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(color: count == pageNumber ? ColorRes.primary : ColorRes.secondary),
          child: Center(
              child: Text(
            '$count',
            textAlign: TextAlign.center,
            style: const TextStyle(color: ColorRes.white, fontSize: 18),
          ))),
    ));
  }
}
