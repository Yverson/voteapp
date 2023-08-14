class LoginData {
  String? userName;
  String? password;
  String? CodeOTP;
  String? Tel;
  String? noms;
  String? prenoms;

  static LoginData fromMap(Map<String, dynamic> map) {

    LoginData ridesBean = LoginData();
    ridesBean.password = map['password'];
    ridesBean.userName = map['userName'];
    ridesBean.CodeOTP = map['CodeOTP'];
    ridesBean.Tel = map['Tel'];
    ridesBean.noms = map['noms'];
    ridesBean.prenoms = map['prenoms'];
    return ridesBean;
  }

  Map toJson() => {
    "userName": userName,
    "password": password,
    "CodeOTP": CodeOTP,
    "Tel": Tel,
    "noms": noms,
    "prenoms": prenoms,
  };

}