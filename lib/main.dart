import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplashtest/data.dart';
import 'package:unsplashtest/unsplash_provider.dart';
import 'package:unsplashtest/unsplashimage.dart';
import 'package:transparent_image/transparent_image.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<MyData> future;

  @override
  void initState() {
    super.initState();
    future = UnSplashProvider.getData(
        'https://api.unsplash.com/photos?page=1&per_page=50');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('Unsplash images')),
      ),
      body: Center(
        child: FutureBuilder<MyData>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return createListViewFromData(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget createListViewFromData(MyData data) {
    return ListView(
      children: List<Widget>.generate(data.images.length, (index) {
        return MyCustomCard(image: data.images[index]);
      }),
    );
  }
}

// ignore: must_be_immutable
class MyCustomCard extends StatelessWidget {
  UnSplashImage image;

  MyCustomCard({Key key, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: Colors.white12,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  blurRadius: 3.0,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SecondRoute(
                                bigImage: image.urlBig,
                              )),
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      image.urlSmall,
                      fit: BoxFit.cover,
                      height: 120.0,
                      width: 120.0,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      (image.firstName != null)
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'First name:',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                                Text(
                                  image.firstName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : Container(),
                      (image.lastName != null)
                          ? Row(
                              children: <Widget>[
                                Text(
                                  'Last name:',
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.6)),
                                ),
                                Text(
                                  image.lastName,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

class SecondRoute extends StatelessWidget {
  String bigImage;

  SecondRoute({Key key, this.bigImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: Stack(
        children: <Widget>[
          Center(child: CircularProgressIndicator()),
          Center(
            child: new FadeInImage.memoryNetwork(
              image: bigImage,
              placeholder: kTransparentImage,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
