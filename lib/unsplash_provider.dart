import 'dart:convert';
import 'dart:io';
import 'data.dart';

class UnSplashProvider {
  static Future<MyData> getData(String url) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    var CLIENTID =
        'ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9';
    request.headers.add('Authorization', 'Client-ID $CLIENTID');
    HttpClientResponse response = await request.close();
    if (response.statusCode == 200) {
      print('start getting');

      String json = await response.transform(utf8.decoder).join();
      return MyData(jsonDecode(json));
    } else {
      // something went wrong :(
      print("Http error: ${response.statusCode}");
      // return empty list
      return null;
    }
  }
}
