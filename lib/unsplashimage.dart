import 'package:unsplashtest/unsplashuser.dart';

class UnSplashImage extends UnSplashUser {
  String urlSmall;
  String urlBig;

  UnSplashImage(var data) : super(data) {
    urlSmall = data['urls']['small'];
    urlBig = data['urls']['raw'];
  }
}
