import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:shared_preferences_one/Login%20and%20Registration/shared_preferences_HomeScreen.dart";
import "package:shared_preferences_one/Login%20and%20Registration/splash_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SplashScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _savedText = "";
  String _savedText2 = "";

  @override
  void initState() {
    _getText();
    super.initState();
  }

  Future<void> _getText() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // SharedPreferences preferences2 = await SharedPreferences.getInstance();
    setState(
      () {
        _savedText = preferences.getString("keyName") ?? "";
        _savedText2 = preferences.getString("keyName2") ?? "";
        if (_savedText != null && _savedText2 != null) {
          _controller.text = _savedText;
          _controller2.text = _savedText2;
        }
      },
    );
  }

  Future<void> _setText(String text, String text2) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // SharedPreferences preferences2 = await SharedPreferences.getInstance();
    await preferences.setString("keyName", text);
    await preferences.setString("keyName2", text2);
    // await preferences2.setString("keyName2", text2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: SizedBox(
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Enter the Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  hintText: "Enter the Password",
                  labelText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  /// If Successfully Logged In (Credentials are Correct)

                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.setBool(SplashScreenState.KEYLOGIN, true);


                  _setText(_controller.text, _controller2.text);
                  setState(
                    () {
                      _savedText = _controller.text;
                      _savedText2 = _controller2.text;
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text(
                  "Save Text",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const HomeScreen();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text(
                  "Go to Login Page",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Email is : $_savedText",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Text(
                "Password is : $_savedText2",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
