//YYX
//map user data to json
class userData {
  final String email;
  final String uid;
  final String password;
  userData({required this.email, required this.uid, required this.password});

  //return user data as map
  Map<String, dynamic> toJSon() => {
        "uid": uid,
        "email": email,
        "password": password,
        "pId": "",
        "probNum": 0,
        "profilePicURL": "",
        "points": 0,
      };
}
