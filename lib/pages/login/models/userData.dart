class userData {
  final String email;
  final String uid;
  userData({required this.email, required this.uid});

  //return user data as map
  Map<String, dynamic> toJSon() => {
        "uid": uid,
        "email": email,
        "level": 0,
        "pId": "",
        "probNum": 0,
        "profilePicURL": "",
        "points": 0,
      };
}
