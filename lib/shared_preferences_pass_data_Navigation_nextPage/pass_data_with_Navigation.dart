import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences Pass data with Navigation",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SharedPractice2(),
    );
  }
}

class SharedPractice2 extends StatefulWidget {
  const SharedPractice2({super.key});

  @override
  State<SharedPractice2> createState() {
    return SharedPractice2State();
  }
}

class SharedPractice2State extends State<SharedPractice2> {
  final TextEditingController _controller = TextEditingController();
  String _savedText = "";

  @override
  void initState() {
    _getText();
    super.initState();
  }

  Future<void> _getText() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _savedText = preferences.getString("keyName") ?? "";
    });
  }

  Future<void> _setText(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("keyName", text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shared Preferences with Navigation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                  hintText: "Enter the Name",
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                ),
              ),
              const SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  _setText(_controller.text);
                  setState(
                    () {
                      _savedText = _controller.text;
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text(
                  "Show the Text",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 20.0),
              Text(
                "Saved Text is : $_savedText",
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return NextPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text(
                  "Go to Next Page",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() {
    return NextPageState();
  }
}

class NextPageState extends State<NextPage> {
  String _name = "";

  @override
  void initState() {
    _getText();
    super.initState();
  }

  Future<void> _getText() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        _name = preferences.getString("keyName") ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shared Preferences with Navigation"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
