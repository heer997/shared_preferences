import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

void main()
{
  runApp(const MyApp());
}
class MyApp extends StatelessWidget
{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Shared Preferences",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SharedPractice(),
    );
  }
}
class SharedPractice extends StatefulWidget
{
  const SharedPractice({super.key});
  @override
  State<SharedPractice> createState()
  {
    return SharedPracticeState();
  }
}
class SharedPracticeState extends State<SharedPractice>
{
  final TextEditingController _controller = TextEditingController();
  String _savedText = "";

  @override
  void initState()
  {
    _getText();
    super.initState();
  }

  Future<void> _getText() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      _savedText = preferences.getString("saved_text") ?? "";
    },);
  }

  Future<void> _setText(String text) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("saved_text", text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Example"),
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
                decoration: const InputDecoration(
                  hintText: "Enter the text",
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  _setText(_controller.text);
                  setState(() {
                    _savedText = _controller.text;
                  },);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  fixedSize: const Size(350.0, 50.0),
                ),
                child: const Text("Save Text",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20.0),
                ),
              ),
              const SizedBox(height: 40.0),
              Text("Saved Text : $_savedText",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}