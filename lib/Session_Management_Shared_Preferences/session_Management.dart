import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Here below is Session Management with Shared Preferences with Simple Two Screens.
/// If we Tap on the Login Button then we navigate to the another Screen(Here HomeScreen)
/// At that time, if we closed the app and again open the app then the HomeScreen(Second Screen)
/// will appeared instead of LoginScreen(First Screen) as shown below :

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences Session Management",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen2(),
    );
  }
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkLoggedInStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.data == true) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  Future<bool> checkLoggedInStatus() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool("keyName") ?? false;
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
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setBool("keyName", true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: const Size(250.0, 50.0),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
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
        child: ElevatedButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setBool("keyName", false);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: const Size(250.0, 50.0),
          ),
          child: const Text(
            "Logout",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}
