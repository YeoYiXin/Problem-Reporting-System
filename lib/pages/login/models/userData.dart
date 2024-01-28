//YYX
//map user data to json
class userData {
  final String email;
  final String uid;
  final String password;
  userData({required this.email, required this.uid, required this.password});

  //return user data as map
  Map<String, dynamic> toJSon() => {
        "email": email,
        "password": password,
        "uid": uid,
      };
}
