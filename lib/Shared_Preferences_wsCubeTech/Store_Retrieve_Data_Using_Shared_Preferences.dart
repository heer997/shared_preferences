import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

/// Shared Preferences : To Store Locally Persistent data, in most cases to Store User Specific
/// data, to store Smaller set of data, we use Shared Preferences in our Application.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Store and Retrieve data using Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const StoreRetrieve(),
    );
  }
}

class StoreRetrieve extends StatefulWidget {
  const StoreRetrieve({super.key});

  @override
  State<StoreRetrieve> createState() => _StoreRetrieveState();
}

class _StoreRetrieveState extends State<StoreRetrieve> {
  TextEditingController controller = TextEditingController();

  var nameValue = "No Value Saved";

  @override
  void initState() {
    super.initState();
    getValue();
  }

  void getValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var getName = preferences.getString("name");
    setState(
      () {
        nameValue = getName ?? "No Value Saved!";
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Share Preferences",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
              const SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.setString("name", controller.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Value saved!"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text(
                  "SAVE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 50.0),
              Text(
                nameValue,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
