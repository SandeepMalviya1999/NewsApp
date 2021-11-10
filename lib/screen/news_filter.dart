import 'package:flutter/material.dart';
import 'package:newsapp/constant/color.dart';
import 'package:newsapp/model/source_model.dart';
import 'package:newsapp/provider/news_article_provider.dart';
import 'package:newsapp/widget/loading.dart';
import 'package:provider/provider.dart';

class NewsFilter extends StatefulWidget {
  const NewsFilter({Key? key}) : super(key: key);

  @override
  _NewsFilterState createState() => _NewsFilterState();
}

class _NewsFilterState extends State<NewsFilter> {
  List<Sources> _listSource = [];
  final List<Sources> _filter = [];

  late Future futureSource;

  String listSource = '';

  @override
  void initState() {
    super.initState();
    futureSource = Provider.of<NewsArticleProvider>(context, listen: false).fetchSource();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Filter News')),
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
            child: FutureBuilder(
                future: futureSource,
                builder: (context, dataSnapShot) {
                  if (dataSnapShot.connectionState == ConnectionState.waiting) {
                    return const LoadingWidget();
                  } else {
                    if (dataSnapShot.error != null) {
                      return const Center(
                          child: Text("Error While Fetching Data\n Check Network Connection"));
                    } else {
                      return Consumer<NewsArticleProvider>(builder: (_, data, child) {
                        _listSource = data.listSource;
                        return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Column(children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: sourceChip.toList()))),
                              InkWell(
                                  onTap: () {
                                    listSource = '';
                                    for (int i = 0; i < _filter.length; i++) {
                                      if (i == 0) {
                                        listSource = listSource + _filter[i].id;
                                      } else {
                                        listSource = listSource + ',' + _filter[i].id;
                                      }
                                    }
                                    print('Source : ' + listSource);
                                    Navigator.pop(context, listSource);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(7.5),
                                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                      color: ColorRes.primary,
                                      child: const Center(
                                          child: Text('Apply Filter',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: ColorRes.white, fontSize: 17)))))
                            ]));
                      });
                    }
                  }
                })),
      ],
    )));
  }

  Iterable<Widget> get sourceChip sync* {
    for (Sources source in _listSource) {
      yield Padding(
          padding: const EdgeInsets.all(6.0),
          child: FilterChip(
              backgroundColor: ColorRes.darkGrey,
              label: Text(source.name),
              selected: _filter.contains(source),
              selectedColor: ColorRes.primary,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    _filter.add(source);
                  } else {
                    _filter.remove(source);
                  }

                  if(_filter.isEmpty) {
                    listSource = '';
                  }
                });
              }));
    }
  }
}
