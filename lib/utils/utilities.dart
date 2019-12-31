import 'package:shared_preferences/shared_preferences.dart';

class Utilities {
  void setMurdha(bool b) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IS_MURDHA", b);
  }

  void setCopas(bool b) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IS_COPAS", b);
  }

  void setSpasi(bool b) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("IS_SPASI", b);
  }
}