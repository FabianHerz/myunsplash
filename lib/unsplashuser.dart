import 'dart:core';

class UnSplashUser {
  String firstName;
  String userName;
  String lastName;
  UnSplashUser(var data) {
    firstName = data['user']['first_name'];
    userName = data['user']['username'];
    lastName = data['user']['last_name'];
  }
}
