import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:shared_preferences_one/Login%20and%20Registration/shared_preferences_LoginScreen.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
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
    setState(
      () {
        _savedText = preferences.getString("keyName") ?? "";
        _savedText2 = preferences.getString("keyName2") ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shared Preferences Home Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
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
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text(
                  "Save Text",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 50.0),
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
