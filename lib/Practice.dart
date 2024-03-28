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
      title: "Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const PracticeDemo(),
    );
  }
}

class PracticeDemo extends StatefulWidget {
  const PracticeDemo({super.key});

  @override
  State<PracticeDemo> createState() {
    return PracticeDemoState();
  }
}

class PracticeDemoState extends State<PracticeDemo> {
  TextEditingController controller = TextEditingController();
  String savedText = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        savedText = preferences.getString("keyName") ?? "";
      },
    );
  }

  Future<void> setData(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("keyName", text);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300.0,
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Enter the text",
                  labelText: "Text",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                setData(controller.text);
                setState(
                  () {
                    savedText = controller.text;
                  },
                );
                controller.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: const Size(200.0, 50.0),
              ),
              child: const Text(
                "Show the text",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Saved Text: $savedText",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
              ),
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
                fixedSize: const Size(200.0, 50.0),
              ),
              child: const Text(
                "Go to next Page",
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

class NextPage extends StatefulWidget {
  const NextPage({super.key});

  @override
  State<NextPage> createState() {
    return NextPageState();
  }
}

class NextPageState extends State<NextPage> {
  String name = "";

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(
      () {
        name = preferences.getString("keyName") ?? "";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Next Page"),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
          ],
        ),
      ),
    );
  }
}
