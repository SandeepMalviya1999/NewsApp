import 'package:flutter/material.dart';
import 'package:newsapp/animation/slide_animation_widget.dart';
import 'package:newsapp/constant/color.dart';
import 'package:newsapp/provider/news_article_provider.dart';
import 'package:newsapp/widget/loading.dart';
import 'package:newsapp/widget/news_item.dart';
import 'package:provider/provider.dart';

class NewsSearch extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: ColorRes.primary),
      textTheme:
          theme.textTheme.copyWith(headline6: const TextStyle(color: ColorRes.white, fontSize: 19)),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty ? buildSuggestions(context) : Query(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              FittedBox(fit: BoxFit.scaleDown, child: Icon(Icons.search, size: 70)),
              SizedBox(height: 10),
              FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text("Search your topic", style: TextStyle(fontSize: 24)))
            ]));
  }
}

class Query extends StatelessWidget {
  final String query;

  const Query({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<NewsArticleProvider>(context).fetchCustomSearchNews(query),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            if (dataSnapShot.error != null) {
              return const Center(child: Text("Error While Fetching Data\n Check Network Connection"));
            } else {
              return Consumer<NewsArticleProvider>(builder: (ctx, data, child) {
                return data.listNewsArticle.isEmpty
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Icon(Icons.error_outline, size: 70),
                              ),
                              const SizedBox(height: 10),
                              FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text("Nothing found related to \n'$query'",
                                      style: const TextStyle(fontSize: 24)))
                            ]))
                    : ListView.builder(
                        itemCount: data.listNewsArticle.length,
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (ctx, index) => SlideAnimationWidget(
                            index: index,
                            itemCount: data.listNewsArticle.length,
                            widgetToAnimate: NewsItem(newsArticle: data.listNewsArticle[index])));
              });
            }
          }
        });
  }
}
