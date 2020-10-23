import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_impl/providres/newsProvider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(
      value: NewsProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void triggerProgressIndicator(context) {
    Provider.of<NewsProvider>(context, listen: false).getData().then((value) {
      print("hello");
    });
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NewsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          RaisedButton(
            child: Row(children: [Text("Refresh"), Icon(Icons.refresh_sharp)]),
            onPressed: () async {
              triggerProgressIndicator(context);
            },
          )
        ],
      ),
      body: provider.isLoading
          ? Center(child: CircularProgressIndicator())
          : CustomList(fun: triggerProgressIndicator),
    );
  }
}

class CustomList extends StatelessWidget {
  final Function fun;

  CustomList({Key key, this.fun}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final articles = context.watch<NewsProvider>().articles;
    print(articles.first.props);

    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Details(
                            articles[index].urlToImage,
                            articles[index].description,
                            articles[index].content)));
              },
              child: Container(
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          height: 250,
                          child: Image.network(articles[index].urlToImage,
                              fit: BoxFit.fitWidth)),
                      Expanded(child: Text(articles[index].title))
                    ],
                  )),
            ));
  }
}

class Details extends StatelessWidget {
  final String urlToImage;
  final String description;
  final String content;
  Details(this.urlToImage, this.description, this.content);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Image.network(urlToImage),
      SizedBox(height: 20),
      Text(description),
    ])));
  }
}
