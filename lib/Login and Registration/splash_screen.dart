import "dart:async";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:shared_preferences_one/Login%20and%20Registration/shared_preferences_HomeScreen.dart";
import "package:shared_preferences_one/Login%20and%20Registration/shared_preferences_LoginScreen.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();

    whereToGo();

    // Timer(const Duration(seconds: 2), () {
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return SharedRegistration();
    //       },
    //     ),
    //   );
    // },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/Flutter_Logo.png"),
      ),
    );
  }

  void whereToGo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var isLoggedIn = preferences.getBool(KEYLOGIN);

    Timer(
      const Duration(seconds: 2),
      () {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LoginScreen();
              },
            ),
          );
        }
      },
    );
  }
}
