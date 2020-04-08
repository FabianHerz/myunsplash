import 'package:unsplashtest/unsplashimage.dart';

class MyData {
  List<UnSplashImage> images;

  MyData(var data) {
    print(data.length);
    images = List<UnSplashImage>.generate(data.length, (index) {
      return UnSplashImage(data[index]);
    });
  }
}
