import "dart:async";
import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Here below is the Session Management Code. In the initial stage, Splash screen will appear then
/// first time Login screen will appear. If you click on the "Login" button then the Home Screen will
/// appear. Then if you close the app and then restart the app, at that time after Splash Screen, Home
/// screen will appear (Login screen will be skipped).
/// In the Same case, if you press on the "Logout" button then the Login screen will appear and if you
/// close the app and then restart the app at that time after Splash Screen, Login screen will appear
/// (Home screen will be skipped).

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Session Management Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen3(),
    );
  }
}

class SplashScreen3 extends StatefulWidget {
  const SplashScreen3({super.key});

  @override
  State<SplashScreen3> createState() {
    return SplashScreen3State();
  }
}

class SplashScreen3State extends State<SplashScreen3> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      check();
      return;
    });
  }

  void check() async {
    bool isLoggedIn = await checkLoggedInStatus();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return isLoggedIn ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }

  Future<bool> checkLoggedInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('keyName') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Splash Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40.0),
            ),
            SizedBox(
              width: 300.0,
              height: 300.0,
              child: Image.network(
                  "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif"),
            ),
            const SizedBox(height: 30.0),
            Image.asset("assets/images/Flutter_Logo.png"),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "User Login Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.setBool("keyName", true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const HomeScreen();
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Login Successfully"),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(300.0, 50.0),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Logout Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                await preferences.setBool("keyName", false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginScreen();
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Logout..."),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(300.0, 50.0),
              ),
              child: const Text(
                "Logout",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
